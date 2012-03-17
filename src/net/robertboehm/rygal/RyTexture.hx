package net.robertboehm.rygal;
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
	public var width:Int;
	public var height:Int;
	
	public function new(bitmapData:BitmapData) {
		this.bitmapData = bitmapData;
		this.width = bitmapData.width;
		this.height = bitmapData.height;
	}
	
	public static function fromAssets(name:String):RyTexture {
		return new RyTexture(Assets.getBitmapData(name));
	}
	
	public function slice(x:Int, y:Int, width:Int, height:Int):RyTexture {
		var data:BitmapData = new BitmapData(width, height, bitmapData.transparent);
		data.copyPixels(bitmapData, new Rectangle(x, y, width, height), new Point());
		return new RyTexture(data);
	}
	
	public function toCanvas():RyCanvas {
		return new RyCanvas(bitmapData);
	}
	
}