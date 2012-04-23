// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;

/**
 * ...
 * @author Robert Böhm
 */

class RyFont {
	
	public static var LEFT:Int = 0;
	public static var CENTER:Int = 1;
	public static var RIGHT:Int = 2;
	
	private function new() { }
	
	public static function fromAssets(id:String, size:Int = -1):RyFont {
		if (size < 0) {
			// TODO: RyBitmapFont
			return null;
		} else {
			return RyEmbeddedFont.fromAssets(id, size);
		}
	}
	
}