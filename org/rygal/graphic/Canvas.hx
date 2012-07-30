// Copyright (C) 2012 Robert Böhm
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

import nme.display.BitmapData;
import nme.geom.ColorTransform;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.text.AntiAliasType;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;

/**
 * <h2>Description</h2>
 * <p>
 * 	A canvas that can be used for drawing operations. It's also capable of being
 * 	converted to a texture, which can then be drawn on other canvas-objects.
 * </p>
 * <p>
 * 	It's a very core element of Rygal, since it's used for every drawing
 * 	operation. It also supports translations and has a translation stack, thus
 * 	it can be used for nested drawings.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	// Prerequisite: The variable texture contains a Texture-object.<br />
 * 	var canvas:Canvas = Canvas.create(320, 240, false);<br />
 * 	canvas.fillRect(0xFF0000, 20, 20, 280, 200);<br />
 * 	canvas.draw(texture, 20, 20);
 * </code>
 * 
 * @author Robert Böhm
 */
class Canvas {
	
	/** The width of this canvas. */
	public var width:Int;
	
	/** The height of this canvas. */
	public var height:Int;
	
	/** The current x-translation. */
	public var xTranslation:Float;
	
	/** The current y-translation. */
	public var yTranslation:Float;
	
	/** The bitmap data this canvas is based on. */
	private var _bitmapData:BitmapData;
	
	/** The translation stack for x-coordinates. */
	private var _xTranslations:Array<Float>;
	
	/** The translation stack for y-coordinates. */
	private var _yTranslations:Array<Float>;
	
	
	/**
	 * Creates a new canvas based on the given bitmap data.
	 * 
	 * @param	bitmapData	The bitmap data this canvas will be based on.
	 */
	public function new(bitmapData:BitmapData) {
		this._bitmapData = bitmapData;
		this.width = bitmapData.width;
		this.height = bitmapData.height;
		this.xTranslation = 0;
		this.yTranslation = 0;
		this._xTranslations = new Array<Float>();
		this._yTranslations = new Array<Float>();
	}
	
	/**
	 * Creates a new canvas based on the given properties.
	 * 
	 * @param	width		The width of the canvas.
	 * @param	height		The height of the canvas.
	 * @param	transparent	Shall the canvas get an alpha channel?
	 * @param	fillColor	The initial color of the canvas.
	 * @return	The new canvas with the given properties.
	 */
	public static function create(width:Int, height:Int,
			transparent:Bool = true, fillColor:Int = 0):Canvas {
		
		return new Canvas(
				new BitmapData(width, height, transparent, fillColor)
			);
	}
	
	/**
	 * Pushes the current translation onto the stack.
	 */
	public function push():Void {
		this._xTranslations.push(xTranslation);
		this._yTranslations.push(yTranslation);
	}
	
	/**
	 * Pops the translation from the stack.
	 */
	public function pop():Void {
		this.xTranslation = this._xTranslations.pop();
		this.yTranslation = this._yTranslations.pop();
	}
	
	/**
	 * Resets the translation and the translation stack.
	 */
	public function reset():Void {
		this.xTranslation = 0;
		this.yTranslation = 0;
		while (this._xTranslations.length > 0) {
			this._xTranslations.pop();
			this._yTranslations.pop();
		}
	}
	
	/**
	 * Perform a translation for the following drawing operations.
	 * 
	 * @param	x	The x-translation.
	 * @param	y	The y-translation.
	 */
	public function translate(x:Float, y:Float):Void {
		xTranslation += x;
		yTranslation += y;
	}
	
	/**
	 * Clears the whole canvas with the given color.
	 * Note: This is in many cases unnecessary and could be skipped, only
	 * perform this operation if it's really needed! If it's called at the
	 * beginning of each frame it may slow down your program even though you may
	 * draw other stuff over it.
	 * 
	 * @param	color	The color this canvas should be filled with.
	 */
	public function clear(color:Int = 0):Void {
		_bitmapData.fillRect(_bitmapData.rect, color);
	}
	
	/**
	 * Defines the color of the given pixel.
	 * 
	 * @param	x		The x-coordinate of the pixel.
	 * @param	y		The y-coordinate of the pixel.
	 * @param	color	The color of the pixel.
	 */
	public function setPixel(x:Int, y:Int, color:Int):Void {
		x += Std.int(xTranslation);
		y += Std.int(yTranslation);
		if (inBitmap(x, y)) {
			_bitmapData.setPixel32(x, y, color);
		}
	}
	
	/**
	 * Draws the given texture onto this canvas.
	 * 
	 * @param	texture	The texture to be drawn.
	 * @param	x		The x-coordinate where to draw to.
	 * @param	y		The y-coordinate where to draw to.
	 */
	public function draw(texture:Texture, x:Float, y:Float):Void {
		if (texture == null)
			return;
		
		x += xTranslation;
		y += yTranslation;
		_bitmapData.copyPixels(texture.bitmapData, texture.bitmapDataRect,
			new Point(x, y), null, null, true);
	}
	
	/**
	 * Draws a specific part of the given texture onto this canvas.
	 * 
	 * @param	texture			The texture to be drawn.
	 * @param	x				The x-coordinate where to draw to.
	 * @param	y				The y-coordinate where to draw to.
	 * @param	leftOffset		The offset from the left side of the texture.
	 * @param	topOffset		The offset from the upper side of the texture.
	 * @param	rightOffset		The offset from the right side of the texture.
	 * @param	bottomOffset	The offset from the bottom side of the texture.
	 */
	public function drawPart(texture:Texture, x:Float, y:Float,
			leftOffset:Int = 0, topOffset:Int = 0, rightOffset:Int = 0,
			bottomOffset:Int = 0):Void {
		
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
		_bitmapData.copyPixels(texture.bitmapData, sourceRect,
			new Point(x + leftOffset, y + topOffset), null, null, true);
	}
	
	/**
	 * Draw a filled rectangle onto this canvas with the given properties.
	 * 
	 * @param	color	The color of the rectangle.
	 * @param	x		The x-coordinate where to draw to.
	 * @param	y		The y-coordinate where to draw to.
	 * @param	width	The width of the rectangle.
	 * @param	height	The height of the rectangle.
	 */
	public function fillRect(color:Int, x:Float, y:Float, width:Float,
			height:Float):Void {
		
		_bitmapData.fillRect(new Rectangle(x, y, width, height), color);
	}
	
	/**
	 * Returns a texture that uses the same bitmap data, thus when you change
	 * this canvas the contents of the texture will also change. If you want to
	 * avoid that, you can clone the resulting texture.
	 * 
	 * @return	A texture that is based on the same bitmap data as this canvas.
	 */
	public function toTexture():Texture {
		return new Texture(_bitmapData);
	}
	
	/**
	 * Draws the given string onto this canvas with the given font and
	 * properties.
	 * Note: This may be slow on various platforms when used repeatedly, use
	 * Texture.fromString() to pre-cache a texture where possible and useful!
	 * 
	 * @param	font		The font to be used.
	 * @param	text		The text to be drawn.
	 * @param	color		The color of the text.
	 * @param	x			The x-coordinate where to draw to.
	 * @param	y			The y-coordinate where to draw to.
	 * @param	alignment	The alignment, use the constants defined in the
	 * 						Font-class.
	 */
	public function drawString(font:Font, text:String, color:Int, x:Float,
			y:Float, alignment:Int = 0):Void {
		
		x += xTranslation;
		y += yTranslation;
		
		if (Std.is(font, EmbeddedFont)) {
			drawStringByEmbeddedFont(
					cast(font, EmbeddedFont), text, color, x, y, alignment
				);
		} else if (Std.is(font, BitmapFont)) {
			var lines:Array<String> = text.split("\n");
			var bitmapFont:BitmapFont = cast(font, BitmapFont);
			for (i in 0...lines.length) {
				drawStringByBitmapFont(bitmapFont, lines[i], color, x,
					y + i * bitmapFont.charHeight, alignment);
			}
		}
	}
	
	/**
	 * Determines if the given (absolute) coordinates are inside this bitmap.
	 * 
	 * @param	x	The x-coordinate.
	 * @param	y	The y-coordinate.
	 * @return	True if the given coordinates are in this bitmap.
	 */
	private function inBitmap(x:Float, y:Float):Bool {
		return x >= 0 && y >= 0 && x < width && y < height;
	}
	
	/**
	 * Draws the given string onto this canvas with the given bitmap font and
	 * properties.
	 * 
	 * @param	font		The bitmap font to be used.
	 * @param	text		The text to be drawn.
	 * @param	color		The color of the text.
	 * @param	x			The x-coordinate where to draw to.
	 * @param	y			The y-coordinate where to draw to.
	 * @param	alignment	The alignment, use the constants defined in the
	 * 						Font-class.
	 */
	private function drawStringByBitmapFont(font:BitmapFont, text:String,
			color:Int, x:Float, y:Float, alignment:Int):Void {
		
		var m:Matrix;
		var ct:ColorTransform;
		var txt:Texture;
		var charBitmap:BitmapData = new BitmapData(
				font.charWidth, font.charHeight, (color >> 24) != 0, color
			);
		
		#if !flash
		var alphaMultiplier:Float = (color >> 24) / 255;
		var redMultiplier:Float = ((color >> 16) & 0xFF) / 255;
		var greenMultiplier:Float = ((color >> 8) & 0xFF) / 255;
		var blueMultiplier:Float = (color & 0xFF) / 255;
		
		if (alphaMultiplier == 0) alphaMultiplier = 1;
		#end
		
		var startX:Float = x;
		
		if (alignment == Font.CENTER) {
			startX -= text.length * font.charWidth / 2;
		} else if (alignment == Font.RIGHT) {
			startX -= text.length * font.charWidth;
		}
		
		var cX:Float = startX;
		var cY:Float = y;
		
		for (i in 0...text.length) {
			if (text.charAt(i) == " ") {
				cX += font.charWidth;
			} else {
				txt = font.getCharacterTexture(text.charAt(i));
				#if flash
				_bitmapData.copyPixels(charBitmap, charBitmap.rect,
					new Point(cX, cY), txt.bitmapData,
					txt.bitmapDataRect.topLeft, true);
				#else
				_bitmapData.draw(txt.bitmapData, new Matrix(1, 0, 0, 1,
					cX - txt.bitmapDataRect.left, cY - txt.bitmapDataRect.top),
					new ColorTransform(redMultiplier, greenMultiplier,
						blueMultiplier, alphaMultiplier),
					null, new Rectangle(cX, cY, txt.bitmapDataRect.width,
						txt.bitmapDataRect.height));
				#end
				
				cX += font.charWidth;
			}
		}
	}
	
	/**
	 * Draws the given string onto this canvas with the given embedded font and
	 * properties.
	 * 
	 * @param	font		The embedded font to be used.
	 * @param	text		The text to be drawn.
	 * @param	color		The color of the text.
	 * @param	x			The x-coordinate where to draw to.
	 * @param	y			The y-coordinate where to draw to.
	 * @param	alignment	The alignment, use the constants defined in the
	 * 						Font-class.
	 */
	private function drawStringByEmbeddedFont(font:EmbeddedFont, text:String,
			color:Int, x:Float, y:Float, alignment:Int):Void {
		
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
		
		#if js
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
		
		#if !js
		_bitmapData.draw(field, new Matrix(1, 0, 0, 1, x, y));
		#else
		_bitmapData.draw(field);
		#end
	}
	
}