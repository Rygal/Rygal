package net.robertboehm.rygal;
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
	
	public var x:Int;
	public var y:Int;
	public var isPressed:Bool;
	
	public function new(type:String, mouse:RyMouse) {
		super(type);
		
		this.x = mouse.x;
		this.y = mouse.y;
		this.isPressed = mouse.isPressed;
	}
	
}