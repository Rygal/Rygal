// Copyright (C) 2012 Robert Böhm, Christopher Kaster
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
	public static var TOUCH_OUT:String = "touchOut";
	public static var TOUCH_OVER:String = "touchOver";
	public static var TOUCH_ROLL_OUT:String = "touchRollOut";
	public static var TOUCH_ROLL_OVER:String = "touchRollOver";
	public static var TOUCH_TAP:String = "touchTap";
	
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var pressure(default, null):Float;
	
	public var isPrimaryTouchPoint(default, null):Bool;
	public var touchPointID(default, null):Int;
	public var isMultiTouchEnabled(default, null):Bool;
	
	public function new(type:String, touch:Touch) {
		super(type);
		
		this.x = touch.x;
		this.y = touch.y;
		this.pressure = touch.pressure;
		
		this.isPrimaryTouchPoint = touch.isPrimaryTouchPoint;
		this.touchPointID = touch.touchPointID;
		this.isMultiTouchEnabled = touch.isMultiTouchEnabled;
	}
	
}