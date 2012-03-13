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
	
	public function new(handler:DisplayObject) {
		handler.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(e:MouseEvent):Void {
		this.x = Math.floor(e.localX);
		this.y = Math.floor(e.localY);
	}
	
}
