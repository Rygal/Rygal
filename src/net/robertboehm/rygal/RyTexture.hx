package net.robertboehm.rygal;
import nme.Assets;
import nme.display.BitmapData;

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
	
	public function toCanvas():RyCanvas {
		return new RyCanvas(bitmapData);
	}
	
}