// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.input;

import nme.events.Event;

/**
 * 
 * @author Christopher Kaster
 */
class TouchEvent extends Event {
	
	public static var TOUCH_BEGIN:String = "touchBegin";
	public static var TOUCH_END:String = "touchEnd";
	public static var TOUCH_MOVE:String = "touchMove";
	
	public var x:Float;
	public var y:Float;
	public var isPressed:Bool;
	
	public function new(type:String, touch:Touch) {
		super(type);
		
		this.x = touch.x;
		this.y = touch.y;
		this.isPressed = touch.isPressed;
	}
	
}