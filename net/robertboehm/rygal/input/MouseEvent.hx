// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;

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
	public static var MOUSE_DOWN:String = "mouseDown";
	
	/** An event that will be called when the mouse button is released. */
	public static var MOUSE_UP:String = "mouseUp";
	
	/** An event that will be called when the mouse is moved. */
	public static var MOUSE_MOVE:String = "mouseMove";
	
	/** The x-coordinate of the mouse. */
	public var x:Int;
	
	/** The y-coordinate of the mouse. */
	public var y:Int;
	
	/** Determines whether the mouse button is pressed or not. */
	public var isPressed:Bool;
	
	
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
	}
	
}