// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import net.robertboehm.rygal.Game;
import nme.display.DisplayObject;
import nme.display.Stage;
import nme.events.EventDispatcher;
import nme.events.IEventDispatcher;

/**
 * ...
 * @author Robert Böhm
 */

class Mouse extends EventDispatcher {
	
	public var x:Int;
	public var y:Int;
	public var isPressed:Bool;
	private var _absoluteX:Int;
	private var _absoluteY:Int;
	private var _game:Game;
	private var _zoom:Int;
	#if (js || cpp)
	// HTML5 Mouse Events don't work on sprites, but they do on the stage
	private var _handler:DisplayObject;
	#end
	
	public function new(handler:DisplayObject, game:Game) {
		super();
		
		_game = game;
		#if (js || cpp)
		_handler = handler;
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_MOVE, onMouseMove);
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_DOWN, onMouseDown);
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_UP, onMouseUp);
		#else
		handler.addEventListener(nme.events.MouseEvent.MOUSE_MOVE, onMouseMove);
		handler.addEventListener(nme.events.MouseEvent.MOUSE_DOWN, onMouseDown);
		handler.addEventListener(nme.events.MouseEvent.MOUSE_UP, onMouseUp);
		#end
	}
	
	private function onMouseDown(e:nme.events.MouseEvent):Void {
		isPressed = true;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, this));
	}
	
	private function onMouseUp(e:nme.events.MouseEvent):Void {
		isPressed = false;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, this));
	}
	
	private function onMouseMove(e:nme.events.MouseEvent):Void {
		var prevX:Int = this._absoluteX;
		var prevY:Int = this._absoluteY;
		#if js
		this._absoluteX = Std.int((e.stageX - _handler.x) / _game.zoom);
		this._absoluteY = Std.int((e.stageY - _handler.y) / _game.zoom);
		#else
		this._absoluteX = Std.int(e.localX / _game.zoom);
		this._absoluteY = Std.int(e.localY / _game.zoom);
		#end
		prevX += _game.cameraX;
		prevY += _game.cameraY;
		this.x = _absoluteX + _game.cameraX;
		this.y = _absoluteY + _game.cameraY;
		this.dispatchEvent(new MouseMoveEvent(MouseEvent.MOUSE_MOVE, this, prevX, prevY));
	}
	
	public function show() {
		nme.ui.Mouse.show();
	}
	
	public function hide() {
		nme.ui.Mouse.hide();
	}
	
}
