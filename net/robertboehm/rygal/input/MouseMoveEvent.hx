// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;

/**
 * ...
 * @author Robert Böhm
 */

class MouseMoveEvent extends MouseEvent {
	
	public static var MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
	
	public var previousX:Int;
	public var previousY:Int;
	public var deltaX:Int;
	public var deltaY:Int;
	
	public function new(type:String, mouse:Mouse, previousX:Int, previousY:Int) {
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