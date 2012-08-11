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

/**
 * <h2>Description</h2>
 * <p>
 * 	The core class of a Rygal game. This class manages the screen, zooming,
 * 	pausing, scene management, cameras, input handling, etc. and is the core
 * 	interface between the GameObjects and the NME DisplayObject-stuff.
 * </p>
 * 
 * <h2>Example (Initialization, inside your main function)</h2>
 * <code>
 * 	// Prerequisite: You have a scene called MainScene<br />
 * 	stage.addChild(new Game(320, 240, 2, new MainScene()).getDisplayObject());
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
	
	/** The zoom factor this game is using. */
	public var zoom(default, null):Int;
	
	/** The width of this game. */
	public var width(default, null):Int;
	
	/** The height of this game. */
	public var height(default, null):Int;
	
	/** The mouse of this game. */
	public var mouse(getMouse, null):Mouse;
	
	/** The keyboard of this game. */
	public var keyboard(getKeyboard, null):Keyboard;
	
	/** The primay touch handler of this game. */
	public var touch(getTouch, null):Touch;
	
	/** The primary joystick of this game */
	public var joystick(getJoystick, null):Joystick;
	
	/** The camera's x-position. */
	public var cameraX:Int;
	
	/** The camera's y-position. */
	public var cameraY:Int;
	
	/** The game's speed modifier.
	 * 	(Affects the "elapsed" times of update-calls) */
	public var speed:Float;
	
	
	/** An array with the device managers of this game. */
	private var _deviceManagers:Array<DeviceManager>;
	
	/** Contains all the registered devices of this game. */
	private var _devices:Hash<IntHash<InputDevice>>;
	
	/** The last update in milliseconds. */
	private var _lastUpdate:Int;
	
	/** The current time in milliseconds. */
	private var _now:Int;
	
	/** All registered scenes. */
	private var _scenes:Hash<Scene>;
	
	/** The main display's sprite. (Note: It's a nme.display.Sprite) */
	private var _sprite:Sprite;
	
	/** The main display's bitmap. */
	private var _bitmap:Bitmap;
	
	/** The current scene. */
	private var _currentScene:Scene;
	
	/** The name of the initial scene. */
	private var _initialSceneName:String;
	
	/** Determines if the game is paused. */
	private var _paused:Bool;
	
	/** Determines if the game is currently really paused. */
	private var _reallyPaused:Bool;
	
	/** The pause scene. */
	private var _pauseScene:Scene;
	
	/** Determines if the last pause requested was made automatically due to
	  * focus loss. */
	private var _autoPaused:Bool;
	
	/** The upcoming scene. */
	private var _nextScene:Scene;
	
	
	/**
	 * Creates a new game based on the given parameters.
	 * 
	 * @param	width				The width of this game.
	 * @param	height				The height of this game.
	 * @param	zoom				The zoom factor of this game.
	 * @param	initialScene		The initial scene.
	 * @param	initialSceneName	The name of the initial scene.
	 * @param	pauseScene			The pause scene.
	 */
	public function new(width:Int, height:Int, zoom:Int, initialScene:Scene,
			initialSceneName:String = "", pauseScene:Scene = null) {
		
		// Automatically load the default device manager so the "user" doesn't
		// have to worry about it:
		DeviceManager.useDefaultDeviceManagers();
		
		_devices = new Hash<IntHash<InputDevice>>();
		_deviceManagers = new Array<DeviceManager>();
		
		_bitmap = new Bitmap(new BitmapData(width, height));
		_bitmap.scaleX = _bitmap.scaleY = zoom;
		_sprite = new Sprite();
		
		_sprite.addChild(_bitmap);
		
		this.speed = 1;
		this._autoPaused = false;
		this._paused = false;
		this._reallyPaused = false;
		if (pauseScene == null) {
			this._pauseScene = new DefaultPauseScene();
		} else {
			this._pauseScene = pauseScene;
		}
		this.screen = new Canvas(_bitmap.bitmapData);
		this.zoom = zoom;
		this.width = width;
		this.height = height;
		this.cameraX = 0;
		this.cameraY = 0;
		_initialSceneName = initialSceneName;
		_scenes = new Hash<Scene>();
		registerScene(initialScene, initialSceneName);
		_sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	
	/**
	 * Determines whether a device manager is already registered or not.
	 * 
	 * @param	deviceManager	The device manager to be queried.
	 * @return	True if the device manager is registered, else false.
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
	 * @param	deviceManager	The device manager to be registered.
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
	 * @param	deviceManager	The device manager to be unregistered.
	 */
	public static function unregisterDeviceManager(
			deviceManager:Class<DeviceManager>):Void {
		
		_deviceManagerTypes.remove(deviceManager);
	}
	
	
	/**
	 * Returns the device manager of the given type.
	 * 
	 * @param	type	The type of the requested device manager.
	 * @return	Either the device manager or null if the given type is not
	 * 			registered.
	 */
	public function getDeviceManager < T : DeviceManager > (type:Class<T>):T {
		for (deviceManager in _deviceManagers) {
			if (Std.is(deviceManager, type)) {
				return cast deviceManager;
			}
		}
		return null;
	}
	
	/**
	 * Returns the device of the given type and with the given ID.
	 * 
	 * @param	type	The type of the requested device.
	 * @param	id		The ID of the device. (Only used on some device types)
	 * @return	The requested device or null if it doesn't exist.
	 */
	public function getDevice < T : InputDevice > (type:Class<T>,
			id:Int = 0):T {
		
		var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
		return ih.get(id);
	}
	
	/**
	 * Returns all devices of the given type.
	 * 
	 * @param	type	The type of the requested devices.
	 * @return	An iterator over all devices of the given type.
	 */
	public function getDevices < T : InputDevice > (type:Class<T>):Iterator<T> {
		var ih:IntHash<T> = cast _devices.get(Type.getClassName(type));
		if (ih == null) {
			// Return a dummy iterator rather than null.
			return new IntHash<T>().iterator();
		} else {
			return ih.iterator();
		}
	}
	
	/**
	 * Returns the input of the given type and with the given ID. This method is
	 * an alias for getDevice.
	 * 
	 * @param	type	The type of the requested input.
	 * @param	id		The ID of the input. (Only used on some device types)
	 * @return	The requested input or null if it doesn't exist.
	 */
	public function getInput < T : InputDevice > (type:Class<T>, id:Int = 0):T {
		return getDevice(type, id);
	}
	
	/**
	 * Returns all inputs of the given type. This method is an alias for
	 * getInputs.
	 * 
	 * @param	type	The type of the requested inputs.
	 * @return	An iterator over all inputs of the given type.
	 */
	public function getInputs < T : InputDevice > (type:Class<T>):Iterator<T> {
		return getInputs(type);
	}
	
	/**
	 * Registers the given device.
	 * 
	 * @param	device	The device to be registered.
	 * @param	id		The ID of the device to be registered.
	 */
	public function registerDevice < T : InputDevice > (device:T,
			id:Int = 0):Void {
		
		var className:String = Type.getClassName(Type.getClass(device));
		if (!_devices.exists(className)) {
			_devices.set(className, new IntHash<InputDevice>());
		}
		_devices.get(className).set(id, device);
	}
	
	/**
	 * Unregisters the device of the given type.
	 * 
	 * @param	type	The type of the device to be unregistered.
	 * @param	id		The ID of the device to be unregistered.
	 */
	public function unregisterDevice < T : InputDevice > (type:Class<T>,
			id:Int = 0):Void {
		
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
	 * @param	scene	The scene to be registered.
	 * @param	name	The name of the scene to be registered.
	 */
	public function registerScene(scene:Scene, name:String = ""):Void {
		_scenes.set(name, scene);
	}
	
	/**
	 * Uses the given scene.
	 * 
	 * @param	name	The name of the scene to be used.
	 */
	public function useScene(name:String = ""):Void {
		_nextScene = _scenes.get(name);
	}
	
	/**
	 * Returns a display object containing this game's graphics.
	 * 
	 * @return	A display object containing this game's graphics.
	 */
	public function getDisplayObject():DisplayObject {
		return _sprite;
	}
	
	/**
	 * Pauses this game.
	 */
	public function pause():Void {
		this._paused = true;
	}
	
	/**
	 * Unpauses this game.
	 */
	public function unpause():Void {
		this._autoPaused = false;
		this._paused = false;
	}
	
	/**
	 * Determines if this game is currently paused.
	 * 
	 * @return	True if this game is currently paused.
	 */
	public function isPaused():Bool {
		return this._paused;
	}
	
	
	/**
	 * Returns the mouse for this game.
	 * 
	 * @return	The mouse for this game.
	 */
	private function getMouse():Mouse {
		return getDevice(Mouse);
	}
	
	/**
	 * Returns the keyboard for this game.
	 * 
	 * @return	The keyboard for this game.
	 */
	private function getKeyboard():Keyboard {
		return getDevice(Keyboard);
	}
	
	/**
	 * Returns the primary touch handler for this game.
	 * 
	 * @return	The primary touch handler for this game.
	 */
	private function getTouch():Touch {
		return getDeviceManager(TouchDeviceManager).primaryTouch;
	}
	
	/**
	 * Returnss all touch handlers for this game.
	 * 
	 * @return	All touch handlers for this game.
	 */
	private function getTouches():Iterator<Touch> {
		return getInputs(Touch);
	}
	
	/**
	 * Returns the joystick of this game.
	 */
	private function getJoystick():Joystick {
		return getDevice(Joystick);
	}
	
	/**
	 * Updates this game and it's currently active scene.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	private function update(time:GameTime):Void {
		if (this._nextScene != null) {
			if (_currentScene != null)
				_currentScene.unload();
			
			_currentScene = _nextScene;
			_nextScene = null;
			_currentScene.load(this);
		}
		
		if (this._paused != this._reallyPaused) {
			if (this._paused) {
				this._pauseScene.load(this);
				this._reallyPaused = true;
			} else {
				this._pauseScene.unload();
				this._reallyPaused = false;
			}
		}
		
		if (this._reallyPaused) {
			_pauseScene.update(time);
		} else {
			_currentScene.update(time);
		}
		
		this.screen.translate(-cameraX, -cameraY);
		_currentScene.draw(this.screen);
		this.screen.reset();
		
		if (this._reallyPaused) {
			_pauseScene.draw(this.screen);
		}
	}
	
	/**
	 * A callback that will be called when this game is added to the stage.
	 * 
	 * @param	e	Event parameters.
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
		_sprite.addEventListener(Event.ACTIVATE, onActivate);
		
		useScene(_initialSceneName);
		_lastUpdate = Lib.getTimer();
		_sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	/**
	 * A callback that will be called when this game is removed from the stage.
	 * 
	 * @param	e	Event parameters.
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
		_sprite.removeEventListener(Event.ACTIVATE, onActivate);
		_sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	/**
	 * A callback that will be called on each frame.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onEnterFrame(e:Event):Void {
		_now = Lib.getTimer();
		update(new GameTime(_now, _lastUpdate, speed));
		_lastUpdate = _now;
	}
	
	/**
	 * A callback that will be called when this game lost focus.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onDeactivate(e:Event):Void {
		if (!isPaused()) {
			_autoPaused = true;
			pause();
		}
	}
	
	/**
	 * A callback that will be called when this game has been focused.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onActivate(e:Event):Void {
		if (_autoPaused) {
			unpause();
		}
	}
	
}
