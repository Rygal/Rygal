// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.util;

/**
 * ...
 * @author Robert Böhm
 */

class RyUtils {
	
	public static var VERSION_MAJOR:Int = 0;
	public static var VERSION_MINOR:Int = 5;
	public static var VERSION_REVISION:Int = 0;

	private function new() { }
	
	public static function getVersion():String {
		return VERSION_MAJOR + "." + VERSION_MINOR + "." + VERSION_REVISION;
	}
	
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