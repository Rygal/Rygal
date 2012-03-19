// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

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

class RyGame {
	
	private var _lastUpdate:Int;
	private var _now:Int;
	private var _scenes:Hash<RyScene>;
	private var _sprite:Sprite;
	private var _bitmap:Bitmap;
	private var _currentScene:RyScene;
	private var _initialSceneName:String;
	
	public var screen:RyCanvas;
	public var zoom:Int;
	public var width:Int;
	public var height:Int;
	public var mouse:RyMouse;
	public var keyboard:RyKeyboard;
	
	public function new(width:Int, height:Int, zoom:Int, initialScene:RyScene, initialSceneName:String="") {
		_bitmap = new Bitmap(new BitmapData(width, height));
		_bitmap.scaleX = _bitmap.scaleY = zoom;
		_sprite = new Sprite();
		
		_sprite.addChild(_bitmap);
		
		
		this.screen = new RyCanvas(_bitmap.bitmapData);
		this.zoom = zoom;
		this.width = width;
		this.height = height;
		_initialSceneName = initialSceneName;
		_scenes = new Hash<RyScene>();
		registerScene(initialScene, initialSceneName);
		_sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	private function onAddedToStage(e:Event):Void {
		_sprite.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		this.mouse = new RyMouse(_sprite, zoom);
		this.keyboard = new RyKeyboard(_sprite);
		useScene(_initialSceneName);
		_lastUpdate = Lib.getTimer();
		_sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void {
		_now = Lib.getTimer();
		update(new RyGameTime(_now, _lastUpdate));
		_lastUpdate = _now;
	}
	
	public function registerScene(scene:RyScene, name:String = ""):Void {
		_scenes.set(name, scene);
	}
	
	public function useScene(name:String = ""):Void {
		if (_currentScene != null)
			_currentScene.unload();
		
		_currentScene = _scenes.get(name);
		_currentScene.load(this);
	}
	
	private function update(time:RyGameTime):Void {
		_currentScene.update(time);
		_currentScene.draw(this.screen);
	}
	
	public function getDisplayObject():DisplayObject {
		return _sprite;
	}
	
}
