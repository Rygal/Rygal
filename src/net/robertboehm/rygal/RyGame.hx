// Copyright (C) 2011 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Robert Böhm
 */

class RyGame extends Bitmap {
	
	private var _lastUpdate:Int;
	private var _now:Int;
	private var _scenes:Hash<RyScene>;
	private var currentScene:RyScene;
	public var gameWidth:Int;
	public var gameHeight:Int;
	public var mouse:RyMouse;
	
	public function new(width:Int, height:Int, zoom:Int, initialScene:RyScene, initialSceneName:String="") {
		super(new BitmapData(width, height));
		
		this.mouse = new RyMouse(zoom, this);
		this.gameWidth = width;
		this.gameHeight = height;
		_scenes = new Hash<RyScene>();
		registerScene(initialScene, initialSceneName);
		useScene(initialSceneName);
		this.scaleX = this.scaleY = zoom;
		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	private function onAddedToStage(e:Event):Void {
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		_lastUpdate = Lib.getTimer();
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
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
		if (currentScene != null)
			currentScene.unload();
		
		currentScene = _scenes.get(name);
		currentScene.load(this);
	}
	
	private function update(time:RyGameTime):Void {
		currentScene.update(time);
		currentScene.draw(this.bitmapData);
	}
	
}
