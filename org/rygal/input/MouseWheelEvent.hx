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

/**
 * <h2>Description</h2>
 * <p>
 * 	A mouse wheel event. It contains information about the related mouse and
 * 	the occured mouse wheel movement.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;this.game.mouse.addEventListener(MouseWheelEvent.MOUSE_WHEEL,
 * 	<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;onMouseWheel);<br />
 * 	}<br />
 * 	<br />
 * 	public function onMouseWheel(e:MouseWheelEvent):Void {<br />
 * 	&nbsp;&nbsp;trace("Mouse wheel moved " +<br />
 *  &nbsp;&nbsp;&nbsp;&nbsp;(e.movement < 0 ? "down" : "up"));<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class MouseWheelEvent extends MouseEvent {
	
	/** An event that will be called when the mouse wheel is moved. */
	public static var MOUSE_WHEEL:String = MouseEvent.MOUSE_WHEEL;
	
	/** The movement of the mouse wheel. (If the value is negative, the wheel
	  * was moved down) */
	public var movement:Int;
	
	
	/**
	 * Creates a new MouseWheelEvent based on the given mouse and movement data.
	 * 
	 * @param	type		The type of this event, usually only
	 * 						MouseWheelEvent.MOUSE_WHEEL.
	 * @param	mouse		The mouse this event is related to.
	 * @param	movement	The movement of the mouse wheel.
	 */
	public function new(type:String, mouse:Mouse, movement:Int) {
		super(type, mouse);
		
		this.movement = movement;
	}
	
}