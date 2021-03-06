// Copyright (C) 2012 Robert Böhm
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
 * 	A mouse event. It contains information about the related mouse.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;this.game.mouse.addEventListener(MouseEvent.MOUSE_DOWN,<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;onMouseDown);<br />
 * 	}<br />
 * 	<br />
 * 	public function onMouseDown(e:MouseEvent):Void {<br />
 * 	&nbsp;&nbsp;trace("Mouse pressed! (x=" + e.x + ", y=" + e.y + ")");<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class MouseEvent extends Event {
	
	/** An event that will be called when the mouse button is pressed. */
	public static inline var MOUSE_DOWN:String = "mouseDown";
	
	/** An event that will be called when the mouse button is released. */
	public static inline var MOUSE_UP:String = "mouseUp";
	
	/** An event that will be called when the mouse is moved. */
	public static inline var MOUSE_MOVE:String = "mouseMove";
	
	/** An event that will be called when the mouse wheel is moved. */
	public static inline var MOUSE_WHEEL:String = "mouseWheel";
	
	/** An event that will be called when the right mouse button is
	 * 	pressed. */
	public static inline var RIGHT_MOUSE_DOWN:String = "rightMouseDown";
	
	/** An event that will be called when the right mouse button is
	 * 	released. */
	public static inline var RIGHT_MOUSE_UP:String = "rightMouseUp";
	
	/** An event that will be called when the middle mouse button is
	 * 	pressed. */
	public static inline var MIDDLE_MOUSE_DOWN:String = "middleMouseDown";
	
	/** An event that will be called when the middle mouse button is
	 * 	released. */
	public static inline var MIDDLE_MOUSE_UP:String = "middleMouseUp";
	
	
	/** The x-coordinate of the mouse. */
	public var x(default, null):Int;
	
	/** The y-coordinate of the mouse. */
	public var y(default, null):Int;
	
	/** Determines whether the mouse button is pressed or not. */
	public var isPressed(default, null):Bool;
	
	/** Determines whether the right mouse button is pressed or not. */
	public var isRightButtonPressed(default, null):Bool;
	
	/** Determines whether the middle mouse button is pressed or not. */
	public var isMiddleButtonPressed(default, null):Bool;
	
	
	/**
	 * Creates a new MouseEvent based on the given mouse.
	 * 
	 * @param	type	The type of this event, use one of the constants of
	 * 					MouseEvent, for instance MouseEvent.MOUSE_UP.
	 * @param	mouse	The mouse this event is related to.
	 */
	public function new(type:String, mouse:Mouse) {
		super(type);
		
		this.x = mouse.x;
		this.y = mouse.y;
		this.isPressed = mouse.isPressed;
		this.isRightButtonPressed = mouse.isRightButtonPressed;
		this.isMiddleButtonPressed = mouse.isMiddleButtonPressed;
	}
	
}