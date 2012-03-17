package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyUtils {

	private function new() { }
	
	public static function zeroPadNumber(number:Int, targetSize:Int):String {
		return leftPad(Std.string(number), targetSize, "0");
	}
	
	public static function leftPad(string:String, targetSize:Int, fillString:String = " "):String {
		while (string.length < targetSize)
			string = fillString + string;
		
		return string;
	}
	
	public static function rightPad(string:String, targetSize:Int, fillString:String = " "):String {
		while (string.length < targetSize)
			string = string + fillString;
		
		return string;
	}
	
}