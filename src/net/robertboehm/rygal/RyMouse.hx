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
	
	public function new(zoom:Int, handler:DisplayObject) {
		_zoom = zoom;
		
		handler.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(e:MouseEvent):Void {
		this.x = e.localX / _zoom;
		this.y = e.localY / _zoom;
	}
	
}
