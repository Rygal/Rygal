// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.util;

/**
 * <h2>Description</h2>
 * <p>
 * 	A class with utility methods who don't fit anywhere else. Every method is
 * 	static, thus you don't need to create an instance of this class.
 * </p>
 * 
 * @author Robert Böhm
 */
class Utils {
	
	/** The major number of the current Rygal version. (x.0.0) */
	public static var VERSION_MAJOR:Int = 1;
	
	/** The minor number of the current Rygal version. (0.x.0) */
	public static var VERSION_MINOR:Int = 1;
	
	/** The revision number of the current Rygal version. (0.0.x) */
	public static var VERSION_REVISION:Int = 0;
	
	
	/**
	 * You should never create an instance of this class!
	 */
	private function new() { }
	
	/**
	 * Returns the current Rygal version as a string in the regular format:
	 * 1.2.3
	 * 
	 * @return	The current version of Rygal as a string.
	 */
	public static function getVersion():String {
		return VERSION_MAJOR + "." + VERSION_MINOR + "." + VERSION_REVISION;
	}
	
	/**
	 * Returns a number, padded with zeros to fit a specific size.
	 * Note: The number won't be trimmed to fit the size, so
	 * 		 zeroPadNumber(512, 2) would result in "512", rather than "12"!
	 * 
	 * @param	number		The number to be padded with zeros.
	 * @param	targetSize	The target size.
	 * @return	The number, padded with zeros to fit the given size.
	 */
	public static function zeroPadNumber(number:Int, targetSize:Int):String {
		return StringTools.lpad(Std.string(number), "0", targetSize);
	}
	
}
