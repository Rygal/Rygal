// Copyright (C) 2012 Robert Böhm
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

import org.rygal.graphic.Canvas;
import org.rygal.input.DeviceManager;
import org.rygal.input.InputDevice;
import org.rygal.input.Keyboard;
import org.rygal.input.Mouse;
import org.rygal.input.Touch;
import org.rygal.input.Joystick;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import org.rygal.input.TouchDeviceManager;
import org.rygal.input.JoystickDeviceManager;

/**
 * <h2>Description</h2>
 * <p>
 *  The core class of a Rygal game. This class manages the screen, zooming,
 *  pausing, scene management, cameras, input handling, etc. and is the core
 *  interface between the GameObjects and the NME DisplayObject-stuff.
 * </p>
 * 
 * <h2>Example (Initialization, inside your main function)</h2>
 * <code>
 *  // Prerequisite: You have a scene called MainScene<br />
 *  stage.addChild(new Game(320, 240, 2, new MainScene()).getDisplayObject());
 * </code>
 * 
 * @author Robert Böhm
 */
class Game {
    
    /** The registered device managers. */
    private static var _deviceManagerTypes:Array<Class<DeviceManager>> =
        new Array<Class<DeviceManager>>();
    
    
    /** The screen canvas that will be displayed. */
    public var screen(default, null):Canvas;
    
    /** The mouse of this game. */
    public var mouse(getMouse, null):Mouse;
    
    /** The keyboard of this game. */
    public var keyboard(getKeyboard, null):Keyboard;
    
    /** The touch surface of this game. */
    public var touch(getTouch, null):TouchDeviceManager;
    
    /** The primary joystick of this game */
    public var joystick(getJoystick, null):JoystickDeviceManager;
    
    /** The zoom factor this game is using. */
    public var zoom(default, null):Int;
    
    /** The width of this game. */
    public var width(default, null):Int;
    
    /** The height of this game. */
    public var height(default, null):Int;
    
    /** The camera's x-position. */
    public var cameraX:Int = 0;
    
    /** The camera's y-position. */
    public var cameraY:Int = 0;
    
    /** The game's speed modifier.
     *  (Affects the "elapsed" times of update-calls) */
    public var speed:Float = 1;
    
    /** The step per update or 0 if no fixed timestep should be used. */
    public var fixedTimestep:Float = 0;
    
    /** Determines if this game should use automatically pause when the focus of
     *  the game is lost. */
    public var autoPause:Bool = true;
    
    
    /** An array with the device managers of this game. */
    private var _deviceManagers:Array<DeviceManager>;
    
    /** Contains all the registered devices of this game. */
    private var _devices:Hash<IntHash<InputDevice>>;
    
    /** All registered scenes. */
    private var _scenes:Hash<Scene>;
    
    /** The main display's sprite. (Note: It's a nme.display.Sprite) */
    private var _sprite:Sprite;
    
    /** The main display's bitmap. */
    private var _bitmap:Bitmap;
    
    /** The current scene. */
    private var _currentScene:Scene;
    
    /** The pause scene. */
    private var _pauseScene:Scene;
    
    /** The upcoming scene. */
    private var _nextScene:Scene;
    
    /** The last update in milliseconds. */
    private var _lastUpdate:Float;
    
    /** The current time in milliseconds. */
    private var _now:Float;
    
    /** Determines if the game is paused. */
    private var _wantPause:Bool = false;
    
    /** Determines if the game is currently really paused. */
    private var _paused:Bool = false;
    
    /** The accumulator for timesteps. */
    private var _accumulator:Float = 0;
    
    
    /**
     * Creates a new game based on the given parameters.
     * 
     * @param   width               The width of this game.
     * @param   height              The height of this game.
     * @param   zoom                The zoom factor of this game.
     * @param   initialScene        The initial scene.
     * @param   initialSceneName    The name of the initial scene.
     * @param   pauseScene          The pause scene.
     * @param   fixedTimestep       The step per update or 0 if no fixed
     *                              timestep should be used.
     */
    public function new(width:Int, height:Int, zoom:Int, initialScene:Scene,
            initialSceneName:String = "", pauseScene:Scene = null,
            fixedTimestep:Float = 0) {
        
        // Automatically load the default device manager so the "user" doesn't
        // have to worry about it:
        DeviceManager.useDefaultDeviceManagers();
        
        _devices = new Hash<IntHash<InputDevice>>();
        _deviceManagers = new Array<DeviceManager>();
        _scenes = new Hash<Scene>();
        
        _bitmap = new Bitmap(new BitmapData(width, height));
        _bitmap.scaleX = _bitmap.scaleY = zoom;
        _sprite = new Sprite();
        _sprite.addChild(_bitmap);
        
        if (pauseScene == null) {
            this._pauseScene = new DefaultPauseScene();
        } else {
            this._pauseScene = pauseScene;
        }
        
        this.screen = new Canvas(_bitmap.bitmapData);
        this.fixedTimestep = fixedTimestep;
        this.zoom = zoom;
        this.width = width;
        this.height = height;
        
        registerScene(initialScene, initialSceneName);
        useScene(initialSceneName);
        
        _sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
    
    
    /**
     * Determines whether a device manager is already registered or not.
     * 
     * @param   deviceManager   The device manager to be queried.
     * @return  True if the device manager is registered, else false.
     */
    public static function hasDeviceManager(
            deviceManager:Class<DeviceManager>):Bool {
        
        for (manager in _deviceManagerTypes) {
            if (manager == deviceManager)
                return true;
        }
        
        return false;
    }
    
    /**
     * Registers the given device manager.
     * 
     * @param   deviceManager   The device manager to be registered.
     */
    public static function registerDeviceManager(
            deviceManager:Class<DeviceManager>):Void {
        
        if (!hasDeviceManager(deviceManager)) {
            _deviceManagerTypes.push(deviceManager);
        }
    }
    
    /**
     * Unregisters the given device manager
     * 
     * @param   deviceManager   The device manager to be unregistered.
     */
    public static function unregisterDeviceManager(
            deviceManager:Class<DeviceManager>):Void {
        
        _deviceManagerTypes.remove(deviceManager);
    }
    
    
    /**
     * Returns the device manager of the given type.
     * 
     * @param   type    The type of the requested device manager.
     * @return  Either the device manager or null if the given type is not
     *          registered.
     */
    public function getDeviceManager<T:DeviceManager>(type:Class<T>):T {
        for (deviceManager in _deviceManagers) {
            if (Std.is(deviceManager, type)) {
                return cast deviceManager;
            }
        }
        return null;
    }
    
    /**
     * Determines if a device of the given type and with the given ID is
     * registered.
     * 
     * @param   type    The type of the device.
     * @param   id      The ID of the device. (Only used on some device types)
     * @return  True if the device exists, else false.
     */
    public function hasDevice<T:InputDevice>(type:Class<T>, id:Int = 0):Bool {
        if (_devices.exists(Type.getClassName(type))) {
            var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
            if (ih.exists(id)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Returns the device of the given type and with the given ID.
     * 
     * @param   type    The type of the requested device.
     * @param   id      The ID of the device. (Only used on some device types)
     * @return  The requested device or null if it doesn't exist.
     */
    public function getDevice<T:InputDevice>(type:Class<T>, id:Int = 0):T {
        if (_devices.exists(Type.getClassName(type))) {
            var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
            if (ih.exists(id)) {
                return ih.get(id);
            }
        }
        return null;
    }
    
    /**
     * Returns all devices of the given type.
     * 
     * @param   type    The type of the requested devices.
     * @return  An iterator over all devices of the given type.
     */
    public function getDevices<T:InputDevice>(type:Class<T>):Iterator<T> {
        if (_devices.exists(Type.getClassName(type))) {
            var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
            return ih.iterator();
        }
        // Return a dummy iterator rather than null.
        return new IntHash<T>().iterator();
    }
    
    /**
     * Returns the amount of devices of the given type.
     * 
     * @param   type    The type of the requested devices.
     * @return  The amount of devices.
     */
    public function getDeviceCount<T:InputDevice>(type:Class<T>):Int {
        if (_devices.exists(Type.getClassName(type))) {
            var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
            return Lambda.count(ih);
        }
        return 0;
    }
    
    /**
     * Determines if an input of the given type and with the given ID is
     * registered.
     * 
     * @param   type    The type of the input.
     * @param   id      The ID of the input. (Only used on some device types)
     * @return  True if the input exists, else false.
     */
    public function hasInput<T:InputDevice>(type:Class<T>, id:Int = 0):Bool {
        return hasDevice(type, id);
    }
    
    /**
     * Returns the input of the given type and with the given ID. This method is
     * an alias for getDevice.
     * 
     * @param   type    The type of the requested input.
     * @param   id      The ID of the input. (Only used on some device types)
     * @return  The requested input or null if it doesn't exist.
     */
    public function getInput<T:InputDevice>(type:Class<T>, id:Int = 0):T {
        return getDevice(type, id);
    }
    
    /**
     * Returns all inputs of the given type. This method is an alias for
     * getInputs.
     * 
     * @param   type    The type of the requested inputs.
     * @return  An iterator over all inputs of the given type.
     */
    public function getInputs<T:InputDevice>(type:Class<T>):Iterator<T> {
        return getDevices(type);
    }
    
    /**
     * Returns the amount of inputs of the given type.
     * 
     * @param   type    The type of the requested inputs.
     * @return  The amount of inputs.
     */
    public function getInputCount<T:InputDevice>(type:Class<T>):Int {
        return getDeviceCount(type);
    }
    
    /**
     * Registers the given device.
     * 
     * @param   device  The device to be registered.
     * @param   id      The ID of the device to be registered.
     */
    public function registerDevice<T:InputDevice>(device:T, id:Int = 0):Void {
        var className:String = Type.getClassName(Type.getClass(device));
        if (!_devices.exists(className)) {
            _devices.set(className, new IntHash<InputDevice>());
        }
        var ih:IntHash<InputDevice> = _devices.get(className);
        if (ih.exists(id)) {
            if (ih.get(id) != device) {
                ih.get(id).dispose();
            } else {
                // If the same device is already registered
                return;
            }
        }
        _devices.get(className).set(id, device);
    }
    
    /**
     * Unregisters the device of the given type.
     * 
     * @param   type    The type of the device to be unregistered.
     * @param   id      The ID of the device to be unregistered.
     */
    public function unregisterDevice<T:InputDevice>(type:Class<T>, id:Int = 0):Void {
        
        var className:String = Type.getClassName(type);
        
        if (_devices.exists(className)) {
            var ih:IntHash<InputDevice> = _devices.get(className);
            if (ih.exists(id)) {
                ih.get(id).dispose();
                ih.remove(id);
            }
        }
    }
    
    /**
     * Registers the given scene in this game.
     * 
     * @param   scene   The scene to be registered.
     * @param   name    The name of the scene to be registered.
     */
    public function registerScene(scene:Scene, name:String = ""):Void {
        _scenes.set(name, scene);
    }
    
    /**
     * Uses the given scene.
     * 
     * @param   name    The name of the scene to be used.
     */
    public function useScene(name:String = ""):Void {
        _nextScene = _scenes.get(name);
    }
    
    /**
     * Returns a display object containing this game's graphics.
     * 
     * @return  A display object containing this game's graphics.
     */
    public function getDisplayObject():DisplayObject {
        return _sprite;
    }
    
    /**
     * Pauses this game.
     */
    public function pause():Void {
        this._wantPause = true;
    }
    
    /**
     * Unpauses this game.
     */
    public function unpause():Void {
        this._wantPause = false;
    }
    
    /**
     * Determines if this game is currently paused.
     * 
     * @return  True if this game is currently paused.
     */
    public function isPaused():Bool {
        return this._wantPause;
    }
    
    
    /**
     * Returns the mouse for this game.
     * 
     * @return  The mouse for this game.
     */
    private function getMouse():Mouse {
        return getDevice(Mouse);
    }
    
    /**
     * Returns the keyboard for this game.
     * 
     * @return  The keyboard for this game.
     */
    private function getKeyboard():Keyboard {
        return getDevice(Keyboard);
    }
    
    /**
     * Returns the touch surface for this game.
     * 
     * @return  The touch surface for this game.
     */
    private function getTouch():TouchDeviceManager {
        return getDeviceManager(TouchDeviceManager);
    }
    
    /**
     * Returnss all touch handlers for this game.
     * 
     * @return  All touch handlers for this game.
     */
    private function getTouches():Iterator<Touch> {
        return getInputs(Touch);
    }
    
    /**
     * Returns the joystick of this game.
     */
    private function getJoystick():JoystickDeviceManager {
        return getDeviceManager(JoystickDeviceManager);
    }
    
    /**
     * Updates this game and it's currently active scene.
     * 
     * @param   time    The time elapsed since the last update.
     */
    private function update(time:GameTime):Void {
        if (this._nextScene != null) {
            if (_currentScene != null)
                _currentScene.unload();
            
            _currentScene = _nextScene;
            _nextScene = null;
            _currentScene.load(this);
        }
        
        if (this._wantPause != this._paused) {
            if (this._wantPause) {
                this._pauseScene.load(this);
                this._paused = true;
            } else {
                this._pauseScene.unload();
                this._paused = false;
            }
        }
        
        if (this._paused) {
            _pauseScene.update(time);
        } else {
            _currentScene.update(time);
        }
    }
    
    /**
     * Draws this game.
     */
    private function draw():Void {
        this.screen.translate(-cameraX, -cameraY);
        _currentScene.draw(this.screen);
        this.screen.reset();
        
        if (this._paused) {
            _pauseScene.draw(this.screen);
        }
    }
    
    /**
     * A callback that will be called when this game is added to the stage.
     * 
     * @param   e   Event parameters.
     */
    private function onAddedToStage(e:Event):Void {
        _sprite.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        _sprite.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        
        for (deviceManagerType in _deviceManagerTypes) {
            _deviceManagers.push(
                    Type.createInstance(deviceManagerType, [this])
                );
        }
        
        _sprite.addEventListener(Event.DEACTIVATE, onDeactivate);
        
        _lastUpdate = Lib.getTimer();
        _sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
    
    /**
     * A callback that will be called when this game is removed from the stage.
     * 
     * @param   e   Event parameters.
     */
    private function onRemovedFromStage(e:Event):Void {
        _sprite.removeEventListener(Event.REMOVED_FROM_STAGE,
            onRemovedFromStage);
        _sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        
        for (deviceManager in _deviceManagers) {
            deviceManager.dispose();
            _deviceManagers.remove(deviceManager);
        }
        
        // Remove registered devices:
        for (deviceHash in _devices) {
            for (device in deviceHash) {
                device.dispose();
            }
        }
        _devices = new Hash<IntHash<InputDevice>>();
        
        _sprite.removeEventListener(Event.DEACTIVATE, onDeactivate);
        _sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
    
    /**
     * A callback that will be called on each frame.
     * 
     * @param   e   Event parameters.
     */
    private function onEnterFrame(e:Event):Void {
        _now = Lib.getTimer();
        if (fixedTimestep > 0) {
            var updated:Bool = false;
            _accumulator += _now - _lastUpdate;
            while (_accumulator > fixedTimestep) {
                updated = true;
                _accumulator -= fixedTimestep;
                update(GameTime.fromElapsed(_lastUpdate, fixedTimestep));
                _lastUpdate += fixedTimestep;
            }
            if(updated)
                draw();
        } else {
            update(new GameTime(_now, _lastUpdate));
            draw();
            _lastUpdate = _now;
        }
    }
    
    /**
     * A callback that will be called when this game lost focus.
     * 
     * @param   e   Event parameters.
     */
    private function onDeactivate(e:Event):Void {
        if (autoPause) {
            pause();
        }
    }
    
}
