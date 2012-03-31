// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import nme.display.BitmapData;
import nme.display.BitmapInt32;
import nme.geom.ColorTransform;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.text.TextField;
import nme.text.TextFormat;

/**
 * ...
 * @author Robert Böhm
 */

class RyCanvas {
	
	private var _bitmapData:BitmapData;
	private var _xTranslations:Array<Float>;
	private var _yTranslations:Array<Float>;
	public var width:Int;
	public var height:Int;
	public var xTranslation:Float;
	public var yTranslation:Float;
	
	public function new(bitmapData:BitmapData) {
		this._bitmapData = bitmapData;
		this.width = bitmapData.width;
		this.height = bitmapData.height;
		this.xTranslation = 0;
		this.yTranslation = 0;
		this._xTranslations = new Array<Float>();
		this._yTranslations = new Array<Float>();
	}
	
	public static function create(width:Int, height:Int, transparent:Bool=true, fillColor:Int=0):RyCanvas {
		return new RyCanvas(new BitmapData(width, height, transparent, fillColor));
	}
	
	private function inBitmap(x:Float, y:Float):Bool {
		return x >= 0 && y >= 0 && x < width && y < height;
	}
	
	public function push():Void {
		this._xTranslations.push(xTranslation);
		this._yTranslations.push(yTranslation);
	}
	
	public function pop():Void {
		this.xTranslation = this._xTranslations.pop();
		this.yTranslation = this._yTranslations.pop();
	}
	
	public function reset():Void {
		this.xTranslation = 0;
		this.yTranslation = 0;
		while (this._xTranslations.length > 0)
			this._xTranslations.pop();
			this._yTranslations.pop();
	}
	
	public function translate(x:Float, y:Float):Void {
		xTranslation += x;
		yTranslation += y;
	}
	
	public function setPixel(x:Int, y:Int, color:Int):Void {
		x += Std.int(xTranslation);
		y += Std.int(yTranslation);
		if (inBitmap(x, y)) {
			_bitmapData.setPixel32(x, y, color);
		}
	}
	
	private function drawStringByEmbeddedFont(font:RyEmbeddedFont, text:String, color:Int, x:Float, y:Float):Void {
		#if cpp
		font.textFormat.color = color;
		#end
		
		var field:TextField = new TextField();
		field.defaultTextFormat = font.textFormat;
		field.textColor = color;
		field.embedFonts = true;
		field.width = _bitmapData.width;
		field.height = _bitmapData.height;
		
		#if !flash
		field.x = x;
		field.y = y;
		#end
		field.text = text;
		field.setTextFormat(field.defaultTextFormat);
		
		#if flash
		var m:Matrix = new Matrix();
		m.translate(x, y);
		_bitmapData.draw(field, m);
		#else
		_bitmapData.draw(field);
		#end
	}
	
	/**
	 * Note: This may be slow on various platforms, use RyTexture.fromString() instead!
	 */
	public function drawString(font:RyFont, text:String, color:Int, x:Float, y:Float):Void {
		x += xTranslation;
		y += yTranslation;
		
		if (Std.is(font, RyEmbeddedFont)) {
			drawStringByEmbeddedFont(cast(font, RyEmbeddedFont), text, color, x, y);
		} else if (Std.is(font, RyBitmapFont)) {
			// TODO
		}
	}
	
	public function draw(texture:RyTexture, x:Float, y:Float):Void {
		x += xTranslation;
		y += yTranslation;
		_bitmapData.copyPixels(texture.bitmapData, texture.bitmapDataRect, new Point(x, y), null, null, true);
	}
	
	public function toTexture():RyTexture {
		return new RyTexture(_bitmapData);
	}
	
}