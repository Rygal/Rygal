package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyError {
	
	private var message:String;
	
	public function new(?message:String) {
		this.message = message;
	}
	
	override public function toString():String {
		return Type.getClassName(Type.getClass(this)) + (message == null ? "" : ": " + message);
	}
	
}