// Copyright (C) 2011 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import nme.display.DisplayObject;
import nme.display.Stage;
import nme.events.MouseEvent;

/**
 * ...
 * @author Robert Böhm
 */

class RyMouse {
	
	public var x:Int;
	public var y:Int;
	private var _zoom:Int;
	#if js
	// HTML5 MOUSE_MOVE doesn't work on Sprites, only the stage
	private var _handler:DisplayObject;
	#end
	
	public function new(handler:DisplayObject, zoom:Int=1) {
		_zoom = zoom;
		#if js
		_handler = handler;
		handler.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		#else
		handler.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		#end
	}
	
	private function onMouseMove(e:MouseEvent):Void {
		#if js
		this.x = Math.floor((e.localX - _handler.x) / _zoom);
		this.y = Math.floor((e.localY - _handler.y) / _zoom);
		#else
		this.x = Math.floor(e.localX / _zoom);
		this.y = Math.floor(e.localY / _zoom);
		#end
	}
	
}
