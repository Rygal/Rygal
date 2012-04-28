// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

import net.robertboehm.rygal.graphic.Canvas;
import net.robertboehm.rygal.input.Keyboard;
import net.robertboehm.rygal.input.Mouse;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.PixelSnapping;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;

/**
 * ...
 * @author Robert Böhm
 */

class Game {
	
	private var _lastUpdate:Int;
	private var _now:Int;
	private var _scenes:Hash<Scene>;
	private var _sprite:Sprite;
	private var _bitmap:Bitmap;
	private var _currentScene:Scene;
	private var _initialSceneName:String;
	private var _paused:Bool;
	private var _reallyPaused:Bool;
	private var _autoPaused:Bool;
	private var pauseScene:Scene;
	
	public var screen:Canvas;
	public var zoom:Int;
	public var width:Int;
	public var height:Int;
	public var mouse:Mouse;
	public var keyboard:Keyboard;
	public var cameraX:Int;
	public var cameraY:Int;
	
	public function new(width:Int, height:Int, zoom:Int, initialScene:Scene, initialSceneName:String="", pauseScene:Scene=null) {
		_bitmap = new Bitmap(new BitmapData(width, height));
		_bitmap.scaleX = _bitmap.scaleY = zoom;
		_sprite = new Sprite();
		
		_sprite.addChild(_bitmap);
		
		
		this._autoPaused = false;
		this._paused = false;
		this._reallyPaused = false;
		if (pauseScene == null) {
			this.pauseScene = new DefaultPauseScreen();
		} else {
			this.pauseScene = pauseScene;
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
	
	private function onDeactivate(e:Event):Void {
		if (!isPaused()) {
			_autoPaused = true;
			pause();
		}
	}
	
	private function onActivate(e:Event):Void {
		if (_autoPaused) {
			unpause();
		}
	}
	
	private function onEnterFrame(e:Event):Void {
		_now = Lib.getTimer();
		update(new GameTime(_now, _lastUpdate));
		_lastUpdate = _now;
	}
	
	public function registerScene(scene:Scene, name:String = ""):Void {
		_scenes.set(name, scene);
	}
	
	public function useScene(name:String = ""):Void {
		if (_currentScene != null)
			_currentScene.unload();
		
		_currentScene = _scenes.get(name);
		_currentScene.load(this);
	}
	
	private function update(time:GameTime):Void {
		if (this._paused != this._reallyPaused) {
			if (this._paused) {
				this.pauseScene.load(this);
				this._reallyPaused = true;
			} else {
				this.pauseScene.unload();
				this._reallyPaused = false;
			}
		}
		
		if (this._reallyPaused) {
			pauseScene.update(time);
		} else {
			_currentScene.update(time);
		}
		
		this.screen.translate(-cameraX, -cameraY);
		_currentScene.draw(this.screen);
		this.screen.reset();
		
		if (this._reallyPaused) {
			pauseScene.draw(this.screen);
		}
	}
	
	public function getDisplayObject():DisplayObject {
		return _sprite;
	}
	
	public function pause():Void {
		this._paused = true;
	}
	
	public function unpause():Void {
		this._autoPaused = false;
		this._paused = false;
	}
	
	public function isPaused():Bool {
		return this._paused;
	}
	
}
