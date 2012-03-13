// Copyright (C) 2011 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import nme.display.BitmapData;
import nme.geom.Point;

/**
 * ...
 * @author Robert Böhm
 */

class RySprite implements RyGameObject {
	
	public var x:Float;
	public var y:Float;
	
	public var bitmapData:BitmapData;
	
	public function new(bitmapData:BitmapData) {
		this.bitmapData = bitmapData;
	}
	
	public function update(time:RyGameTime) {
	}
	
	public function draw(screen:BitmapData) {
		screen.copyPixels(bitmapData, bitmapData.rect, new Point(x, y), null, null, true);
	}
	
}
