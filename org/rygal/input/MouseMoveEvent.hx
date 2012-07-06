// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.input;

/**
 * <h2>Description</h2>
 * <p>
 * 	A mouse movement event. It contains information about the related mouse and
 * 	the occured movement.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;this.game.mouse.addEventListener(MouseMoveEvent.MOUSE_MOVE,
 * 	<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;onMouseMove);<br />
 * 	}<br />
 * 	<br />
 * 	public function onMouseMove(e:MouseMoveEvent):Void {<br />
 * 	&nbsp;&nbsp;trace("Mouse moved: " +<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;"(dx=" + e.deltaX + ", dy=" + e.deltaY + ")");<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class MouseMoveEvent extends MouseEvent {
	
	/** An event that will be called when the mouse is moved. */
	public static var MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
	
	/** The x-coordinate of the mouse prior to the movement. */
	public var previousX:Int;
	
	/** The y-coordinate of the mouse prior to the movement. */
	public var previousY:Int;
	
	/** The movement done on the x-axis. */
	public var deltaX:Int;
	
	/** The movement done on the y-axis. */
	public var deltaY:Int;
	
	
	/**
	 * Creates a new MouseMoveEvent based on the given mouse and movement data.
	 * 
	 * @param	type		The type of this event, usually only
	 * 						MouseMoveEvent.MOUSE_MOVE.
	 * @param	mouse		The mouse this event is related to.
	 * @param	previousX	The x-coordinate of the mouse prior to the movement.
	 * @param	previousY	The y-coordinate of the mouse prior to the movement.
	 */
	public function new(type:String, mouse:Mouse, previousX:Int,
			previousY:Int) {
		
		super(type, mouse);
		
		this.previousX = previousX;
		this.previousY = previousY;
		this.deltaX = x - previousX;
		this.deltaY = y - previousY;
	}
	
}