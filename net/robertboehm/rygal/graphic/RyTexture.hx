// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Robert Böhm
 */

class RyTexture {
	
	public var bitmapData:BitmapData;
	public var bitmapDataRect:Rectangle;
	public var width:Int;
	public var height:Int;
	
	public function new(bitmapData:BitmapData, ?bitmapDataRect:Rectangle) {
		this.bitmapData = bitmapData;
		if (bitmapDataRect == null)
			bitmapDataRect = bitmapData.rect;
		
		this.bitmapDataRect = bitmapDataRect;
		this.width = Std.int(bitmapDataRect.width);
		this.height = Std.int(bitmapDataRect.height);
	}
	
	public static function fromAssets(name:String):RyTexture {
		return new RyTexture(Assets.getBitmapData(name));
	}
	
	public function slice(x:Int, y:Int, width:Int, height:Int):RyTexture {
		var newRect:Rectangle = new Rectangle(bitmapDataRect.x + x,
											  bitmapDataRect.y + y,
											  width, height);
		
		return new RyTexture(bitmapData, newRect);
	}
	
	public function toCanvas():RyCanvas {
		#if js
		var data:BitmapData = new BitmapData(width, height);
		#else
		var data:BitmapData = new BitmapData(width, height, bitmapData.transparent);
		#end
		
		data.copyPixels(bitmapData, bitmapDataRect, new Point());
		
		return new RyCanvas(data);
	}
	
}