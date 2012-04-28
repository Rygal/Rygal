// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import nme.events.Event;

/**
 * ...
 * @author Robert Böhm
 */

class MouseEvent extends Event {
	
	public static var MOUSE_DOWN:String = "mouseDown";
	public static var MOUSE_UP:String = "mouseUp";
	public static var MOUSE_MOVE:String = "mouseMove";
	
	public var x:Int;
	public var y:Int;
	public var isPressed:Bool;
	
	public function new(type:String, mouse:Mouse) {
		super(type);
		
		this.x = mouse.x;
		this.y = mouse.y;
		this.isPressed = mouse.isPressed;
	}
	
}