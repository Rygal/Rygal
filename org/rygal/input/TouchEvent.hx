// Copyright (C) 2012 Robert Böhm, Christopher Kaster
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.input;

import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 * 	A touch event. It contains information about the related touch surface.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;this.game.touch.addEventListener(TouchEvent.TOUCH_MOVE,<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;onTouchMove);<br />
 * 	}<br />
 * 	<br />
 * 	public function onTouchMove(e:TouchEvent):Void {<br />
 * 	&nbsp;&nbsp;trace("Touch point moved! (x=" + e.x + ", y=" + e.y + ")");<br />
 * 	}
 * </code>
 * @author Christopher Kaster
 */
class TouchEvent extends Event {
	
	/** An event that will be called when a touch starts. */
	public static inline var TOUCH_BEGIN:String = "touchBegin";
	
	/** An event that will be called when a touch ends. */
	public static inline var TOUCH_END:String = "touchEnd";
	
	/** An event that will be called when the touch pointer is moved. */
	public static inline var TOUCH_MOVE:String = "touchMove";
	
	/** An event that will be called when the touch pointer is moved out of
	 * 	the game. */
	public static inline var TOUCH_OUT:String = "touchOut";
	
	/** An event that will be called when the touch pointer is moved inside the
	 * 	game. */
	public static inline var TOUCH_OVER:String = "touchOver";
	
	/** An event that will be called when I DON'T KNOW! Seriously, as soon as
	 * 	we figured out the usefulness of this event we'll fill this in. */
	public static inline var TOUCH_ROLL_OUT:String = "touchRollOut";
	
	/** Opposite of TOUCH_ROLL_OUT. (I guess :o) */
	public static inline var TOUCH_ROLL_OVER:String = "touchRollOver";
	
	/** An event that will be called when the user touched the screen without
	 * 	moving the pointer. */
	public static inline var TOUCH_TAP:String = "touchTap";
	
	
	/** The x-coordinate of the touch pointer. */
	public var x(default, null):Float;
	
	/** The y-coordinate of the touch pointer. */
	public var y(default, null):Float;
	
	/** The pressure on the touch pointer. */
	public var pressure(default, null):Float;
	
	/** Determines if this is the primary touch point, in other words when
	 * 	multiple touches occur, only the first one is the primary one. */
	public var isPrimaryTouchPoint(default, null):Bool;
	
	/** Determines the ID of the touch pointer. */
	public var touchPointID(default, null):Int;
	
	/** Determines if multi-touch is enabled. */
	public var isMultiTouchEnabled(default, null):Bool;
	
	
	/**
	 * Creates a new TouchEvent based on the given touch.
	 * 
	 * @param	type	The type of this event, use one of the constants of
	 * 					TouchEvent, for instance TouchEvent.TOUCH_MOVE.
	 * @param	touch	The touch this event is related to.
	 */
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