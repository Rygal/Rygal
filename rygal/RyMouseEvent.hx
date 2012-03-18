// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package rygal;

import nme.events.Event;
import nme.events.MouseEvent;

/**
 * ...
 * @author Robert Böhm
 */

class RyMouseEvent extends Event {
	
	public static var MOUSE_DOWN:String = "mouseDown";
	public static var MOUSE_UP:String = "mouseUp";
	public static var MOUSE_MOVE:String = "mouseMove";
	
	public var position:RyVector;
	public var isPressed:Bool;
	
	public function new(type:String, mouse:RyMouse) {
		super(type);
		
		this.position = mouse.position;
		this.isPressed = mouse.isPressed;
	}
	
}