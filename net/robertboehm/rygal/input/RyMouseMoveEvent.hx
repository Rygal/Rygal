// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import nme.events.Event;
import nme.events.MouseEvent;

/**
 * ...
 * @author Robert Böhm
 */

class RyMouseMoveEvent extends RyMouseEvent {
	
	public static var MOUSE_MOVE:String = RyMouseEvent.MOUSE_MOVE;
	
	public var previousX:Int;
	public var previousY:Int;
	public var deltaX:Int;
	public var deltaY:Int;
	
	public function new(type:String, mouse:RyMouse, previousX:Int, previousY:Int) {
		super(type, mouse);
		
		this.previousX = previousX;
		this.previousY = previousY;
		this.x = mouse.x;
		this.y = mouse.y;
		this.deltaX = x - previousX;
		this.deltaY = y - previousY;
		this.isPressed = mouse.isPressed;
	}
	
}