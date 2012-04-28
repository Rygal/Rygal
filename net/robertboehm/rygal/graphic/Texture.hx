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

class Texture {
	
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
	
	public static function fromAssets(name:String):Texture {
		return new Texture(Assets.getBitmapData(name));
	}
	
	public static function fromText(font:Font, text:String, color:Int,
			width:Int = 256, height:Int = 64):Texture {
		
		var canvas:Canvas = Canvas.create(width, height);
		canvas.drawString(font, text, color, 0, 0);
		return canvas.toTexture();
	}
	
	public function slice(x:Int, y:Int, width:Int, height:Int):Texture {
		var newRect:Rectangle = new Rectangle(bitmapDataRect.x + x,
											  bitmapDataRect.y + y,
											  width, height);
		
		return new Texture(bitmapData, newRect);
	}
	
	public function toCanvas():Canvas {
		#if js
		var data:BitmapData = new BitmapData(width, height);
		#else
		var data:BitmapData = new BitmapData(width, height, bitmapData.transparent);
		#end
		
		data.copyPixels(bitmapData, bitmapDataRect, new Point());
		
		return new Canvas(data);
	}
	
}