// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

import org.rygal.graphic.Canvas;
import org.rygal.input.Keyboard;
import org.rygal.input.Mouse;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

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
	
	/** The screen canvas that will be displayed. */
	public var screen:Canvas;
	
	/** The zoom factor this game is using. */
	public var zoom:Int;
	
	/** The width of this game. */
	public var width:Int;
	
	/** The height of this game. */
	public var height:Int;
	
	/** The mouse of this game. */
	public var mouse:Mouse;
	
	/** The keyboard of this game. */
	public var keyboard:Keyboard;
	
	/** The camera's x-position. */
	public var cameraX:Int;
	
	/** The camera's y-position. */
	public var cameraY:Int;
	
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
		
		_bitmap = new Bitmap(new BitmapData(width, height));
		_bitmap.scaleX = _bitmap.scaleY = zoom;
		_sprite = new Sprite();
		
		_sprite.addChild(_bitmap);
		
		
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
		if (_currentScene != null)
			_currentScene.unload();
		
		_currentScene = _scenes.get(name);
		_currentScene.load(this);
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
	 * Updates this game and it's currently active scene.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	private function update(time:GameTime):Void {
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
		
		this.mouse = new Mouse(_sprite, this);
		this.keyboard = new Keyboard(_sprite);
		_sprite.addEventListener(Event.DEACTIVATE, onDeactivate);
		_sprite.addEventListener(Event.ACTIVATE, onActivate);
		
		useScene(_initialSceneName);
		_lastUpdate = Lib.getTimer();
		_sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	/**
	 * A callback that will be called on each frame.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onEnterFrame(e:Event):Void {
		_now = Lib.getTimer();
		update(new GameTime(_now, _lastUpdate));
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
