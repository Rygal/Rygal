// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import nme.display.BitmapData;
import nme.display.BitmapInt32;
import nme.geom.Point;

/**
 * ...
 * @author Robert Böhm
 */

class RyCanvas {
	
	private var _bitmapData:BitmapData;
	public var width:Int;
	public var height:Int;
	
	public function new(bitmapData:BitmapData) {
		this._bitmapData = bitmapData;
		this.width = bitmapData.width;
		this.height = bitmapData.height;
	}
	
	public static function create(width:Int, height:Int, transparent:Bool=true, ?fillColor:Int):RyCanvas {
		return new RyCanvas(new BitmapData(width, height, transparent, fillColor));
	}
	
	public function setPixel(x:Int, y:Int, color:Int):Void {
		_bitmapData.setPixel32(x, y, color);
	}
	
	public function draw(texture:RyTexture, x:Float, y:Float):Void {
		_bitmapData.copyPixels(texture.bitmapData, texture.bitmapData.rect, new Point(x, y), null, null, true);
	}
	
	public function toTexture():RyTexture {
		return new RyTexture(_bitmapData);
	}
	
}