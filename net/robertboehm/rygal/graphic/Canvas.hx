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
import nme.geom.Rectangle;
import nme.text.AntiAliasType;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Robert Böhm
 */

class Canvas {
	
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
	
	public static function create(width:Int, height:Int, transparent:Bool=true, fillColor:Int=0):Canvas {
		return new Canvas(new BitmapData(width, height, transparent, fillColor));
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
	
	public function clear(color:Int = 0):Void {
		_bitmapData.fillRect(_bitmapData.rect, color);
	}
	
	public function setPixel(x:Int, y:Int, color:Int):Void {
		x += Std.int(xTranslation);
		y += Std.int(yTranslation);
		if (inBitmap(x, y)) {
			_bitmapData.setPixel32(x, y, color);
		}
	}
	
	private function drawStringByBitmapFont(font:BitmapFont, text:String, color:Int, x:Float, y:Float, alignment:Int):Void {
		var cX:Float = x;
		var cY:Float = y;
		var m:Matrix;
		var ct:ColorTransform;
		var txt:Texture;
		var charBitmap:BitmapData = new BitmapData(font.charWidth, font.charHeight, (color >> 24) != 0, color);
		for (i in 0...text.length) {
			if (text.charAt(i) == " ") {
				cX += font.charWidth;
			} else if (text.charAt(i) == "\n") {
				cX = x;
				cY += font.charHeight;
			} else {
				txt = font.getCharacterTexture(text.charAt(i));
				_bitmapData.copyPixels(charBitmap, charBitmap.rect, new Point(cX, cY), txt.bitmapData, txt.bitmapDataRect.topLeft, true);
				cX += font.charWidth;
			}
		}
	}
	
	private function drawStringByEmbeddedFont(font:EmbeddedFont, text:String, color:Int, x:Float, y:Float, alignment:Int):Void {
		#if cpp
		font.textFormat.color = color;
		#end
		
		var field:TextField = new TextField();
		field.antiAliasType = AntiAliasType.NORMAL;
		field.defaultTextFormat = font.textFormat;
		field.textColor = color;
		field.embedFonts = true;
		//field.width = _bitmapData.width;
		field.height = _bitmapData.height;
		
		#if !flash
		field.x = x;
		field.y = y;
		#end
		field.text = text;
		field.setTextFormat(field.defaultTextFormat);
		
		field.autoSize = TextFieldAutoSize.LEFT;
		
		if (alignment == Font.CENTER) {
			x -= Std.int(field.width / 2);
		} else if (alignment == Font.RIGHT) {
			x -= field.width;
		}
		
		#if flash
		var m:Matrix = new Matrix();
		m.translate(x, y);
		_bitmapData.draw(field, m);
		#else
		_bitmapData.draw(field);
		#end
	}
	
	/**
	 * Note: This may be slow on various platforms, use Texture.fromString() instead!
	 */
	public function drawString(font:Font, text:String, color:Int, x:Float, y:Float, alignment:Int=0):Void {
		x += xTranslation;
		y += yTranslation;
		
		if (Std.is(font, EmbeddedFont)) {
			drawStringByEmbeddedFont(cast(font, EmbeddedFont), text, color, x, y, alignment);
		} else if (Std.is(font, BitmapFont)) {
			drawStringByBitmapFont(cast(font, BitmapFont), text, color, x, y, alignment);
		}
	}
	
	public function draw(texture:Texture, x:Float, y:Float):Void {
		if (texture == null)
			return;
		
		x += xTranslation;
		y += yTranslation;
		_bitmapData.copyPixels(texture.bitmapData, texture.bitmapDataRect, new Point(x, y), null, null, true);
	}
	
	public function drawPart(texture:Texture, x:Float, y:Float, leftOffset:Int=0, topOffset:Int=0, rightOffset:Int=0, bottomOffset:Int=0):Void {
		if (texture == null)
			return;
		
		var sourceRect:Rectangle = new Rectangle(
				texture.bitmapDataRect.x + leftOffset,
				texture.bitmapDataRect.y + topOffset,
				texture.bitmapDataRect.width - rightOffset - leftOffset,
				texture.bitmapDataRect.height - bottomOffset - topOffset
			);
		
		x += xTranslation;
		y += yTranslation;
		_bitmapData.copyPixels(texture.bitmapData, sourceRect, new Point(x + leftOffset, y + topOffset), null, null, true);
	}
	
	public function fillRect(color:Int, x:Float, y:Float, width:Float, height:Float):Void {
		_bitmapData.fillRect(new Rectangle(x, y, width, height), color);
	}
	
	public function toTexture():Texture {
		return new Texture(_bitmapData);
	}
	
}