package org.rygal.input;

import nme.events.Event;

/**
 * ...
 * @author Robert Böhm
 */
class ControllerEvent extends Event {
	
	/** An event that will be called when an input is pressed. */
	public static inline var PRESSED:String = "pressed";
	
	/** An event that will be called when an input is released. */
	public static inline var RELEASED:String = "released";
	
	
	public var input(default, null):String;
	
	
	public function new(type:String, input:String) {
		super(type);
		
		this.input = input;
	}
	
}