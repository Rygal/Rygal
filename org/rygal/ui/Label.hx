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


package org.rygal.ui;

import nme.display.BitmapData;
import nme.geom.ColorTransform;
import nme.geom.Matrix;
import nme.text.AntiAliasType;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import org.rygal.graphic.BitmapFont;
import org.rygal.graphic.Canvas;
import org.rygal.graphic.EmbeddedFont;
import org.rygal.graphic.Font;
import org.rygal.BasicGameObject;
import org.rygal.physics.Rectangle;

/**
 * <h2>Description</h2>
 * <p>
 * 	A label that can display any text. It automatically handles caching and is
 * 	optimized to draw very fast. You should always use this instead of
 * 	Canvas.drawString() whenever possible.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	this.addChild(new Label(font, "Hello world!", Font.CENTER, 0xFF0000,<br />
 * 	&nbsp;&nbsp;1, this.game.width / 2, 0));
 * </code>
 * 
 * @author Robert Böhm
 */
class Label extends BasicGameObject {
	
	/** The font used in this label. */
	public var font(getFont, setFont):Font;
	
	/** The text to be displayed by this label. */
	public var text(getText, setText):String;
	
	/** The text alignment for this label. (e.g. Font.CENTER) */
	public var alignment(getAlignment, setAlignment):Int;
	
	/** The color of the text displayed in the label. */
	public var color(getColor, setColor):Int;
	
	/** The transparency of this label. (0 = Transparent, 1 = Solid) */
	public var alpha(getAlpha, setAlpha):Float;
	
	
	/** The font used in this label. */
	private var _font:Font;
	
	/** The text to be displayed by this label. */
	private var _text:String;
	
	/** The text alignment for this label. (e.g. Font.CENTER) */
	private var _alignment:Int;
	
	/** The color of the text displayed in the label. */
	private var _color:Int;
	
	/** The transparency of this label. (0 = Transparent, 1 = Solid) */
	private var _alpha:Float;
	
	/** The internal text field for this label used on embedded fonts. */
	private var _textField:TextField;
	
	/** The internal canvas for this label used on bitmap fonts. */
	private var _canvas:Canvas;
	
	
	/**
	 * Creates a new label with the given properties.
	 * 
	 * @param	font		The font of this label.
	 * @param	text		The text to be displayed by this label.
	 * @param	alignment	The text alignment of this label. (e.g. Font.RIGHT)
	 * @param	color		The color of the text displayed in the label.
	 * @param	alpha		The transparency of this label.
	 * 						(0 = Transparent, 1 = Solid)
	 * @param	x			The x-coordinate of this label.
	 * @param	y			The y-coordinate of this label.
	 */
	public function new(font:Font, text:String = "", alignment:Int = Font.LEFT, color:Int = 0x000000, alpha:Float = 1, x:Float = 0, y:Float = 0) {
		super();
		
		this._font = font;
		this._text = text;
		this._alignment = alignment;
		this._color = color;
		this._alpha = alpha;
		this.x = x;
		this.y = y;
		
		this._textField = new TextField();
		this._textField.embedFonts = true;
		this._textField.antiAliasType = AntiAliasType.NORMAL;
		this._textField.autoSize = TextFieldAutoSize.LEFT;
		
		refreshAll();
		
	}
	
	
	/**
	 * Draws this label on the given screen with a clipping rectangle.
	 * 
	 * @param	screen		The screen this label should be drawn to.
	 * @param	clipRect	The clipping rectangle
	 */
	public function drawClipped(screen:Canvas, clipRect:Rectangle):Void {
		var x:Float = this.x;
		if (Std.is(font, EmbeddedFont)) {
			var nmeClipRect:nme.geom.Rectangle = new nme.geom.Rectangle(
				screen.xTranslation + clipRect.x,
				screen.yTranslation + clipRect.y,
				clipRect.width, clipRect.height);
			
			if (this.alignment == Font.CENTER) {
				// Draw every line on it's own when center alignment is used.
				// This is due to a bug that appear under certain
				// circumstances, where some lines have decimal widths whereas
				// other lines have a width with a whole number, thus some of
				// the lines are displayed blurry.
				
				var wholeText:String = this._text;
				var lines:Array<String> = wholeText.split("\n");
				var y:Float = this.y;
				for (line in lines) {
					this.text = line;
					x = this.x - Std.int(_textField.width / 2);
					
					#if cpp
					screen.drawNmeDrawable(_textField,
						new Matrix(1, 0, 0, 1, x, y), null,
						nmeClipRect);
					#else
					screen.drawNmeDrawable(_textField,
						new Matrix(1, 0, 0, 1, x, y),
						new ColorTransform(1, 1, 1, this.alpha),
						nmeClipRect);
					#end
					
					y += _textField.textHeight;
				}
				this.text = wholeText;
				
				
			} else {
				if (this.alignment == Font.RIGHT) {
					x -= _textField.width;
				}
				#if cpp
				screen.drawNmeDrawable(_textField,
					new Matrix(1, 0, 0, 1, x, y), null,
					nmeClipRect);
				#else
				screen.drawNmeDrawable(_textField,
					new Matrix(1, 0, 0, 1, x, y),
					new ColorTransform(1, 1, 1, this.alpha),
					nmeClipRect);
				#end
			}
			
		} else {
			if (this.alignment == Font.CENTER) {
				x -= _canvas.width / 2;
			} else if (this.alignment == Font.RIGHT) {
				x -= _canvas.width;
			}
			screen.drawPart(_canvas.toTexture(), x,
				y, clipRect.x, clipRect.y,
				_canvas.width - (clipRect.x + clipRect.width),
				_canvas.height - (clipRect.y + clipRect.height));
		}
	}
	
	/**
	 * Draws this label on the given screen.
	 * 
	 * @param	screen	The screen this label should be drawn to.
	 */
	override public function draw(screen:Canvas):Void {
		super.draw(screen);
		
		var x:Float = this.x;
		if (Std.is(font, EmbeddedFont)) {
			if (this.alignment == Font.CENTER) {
				// Draw every line on it's own when center alignment is used.
				// This is due to a bug that appear under certain
				// circumstances, where some lines have decimal widths whereas
				// other lines have a width with a whole number, thus some of
				// the lines are displayed blurry.
				
				var wholeText:String = this._text;
				var lines:Array<String> = wholeText.split("\n");
				var y:Float = this.y;
				for (line in lines) {
					this.text = line;
					x = this.x - Std.int(_textField.width / 2);
					
					#if cpp
					screen.drawNmeDrawable(_textField, new Matrix(1, 0, 0, 1, x, y));
					#else
					screen.drawNmeDrawable(_textField, new Matrix(1, 0, 0, 1, x, y), new ColorTransform(1, 1, 1, this.alpha));
					#end
					
					y += _textField.textHeight;
				}
				this.text = wholeText;
				
				
			} else {
				if (this.alignment == Font.RIGHT) {
					x -= _textField.width;
				}
				#if cpp
				screen.drawNmeDrawable(_textField, new Matrix(1, 0, 0, 1, x, y));
				#else
				screen.drawNmeDrawable(_textField, new Matrix(1, 0, 0, 1, x, y), new ColorTransform(1, 1, 1, this.alpha));
				#end
			}
			
		} else {
			if (this.alignment == Font.CENTER) {
				x -= _canvas.width / 2;
			} else if (this.alignment == Font.RIGHT) {
				x -= _canvas.width;
			}
			screen.draw(_canvas.toTexture(), x, y);
		}
	}
	
	
	/**
	 * Returns the font used in this label.
	 * 
	 * @return	The font used in this label.
	 */
	private function getFont():Font {
		return _font;
	}
	
	/**
	 * Defines the font used in this label.
	 * 
	 * @param	font	The font used in this label.
	 * @return	The new font.
	 */
	private function setFont(font:Font):Font {
		if (font == this._font)
			return font;
		
		if ((Std.is(_font, EmbeddedFont) && !Std.is(font, EmbeddedFont)) ||
			(Std.is(_font, BitmapFont) && !Std.is(font, BitmapFont))) {
			
			_font = font;
			refreshAll();
		} else {
			_font = font;
			refreshTextFormat();
		}
		return _font;
	}
	
	/**
	 * Returns the text to be displayed by this label.
	 * 
	 * @return	The text to be displayed by this label.
	 */
	private function getText():String {
		return this._text;
	}
	
	/**
	 * Defines the text to be displayed by this label.
	 * 
	 * @param	text	The text to be displayed by this label.
	 * @return	The new text.
	 */
	private function setText(text:String):String {
		if (text == this._text)
			return text;
		
		this._text = text;
		refreshText();
		return this._text;
	}
	
	/**
	 * Returns the text alignment for this label.
	 * 
	 * @return	The text alignment for this label. (e.g. Font.CENTER)
	 */
	private function getAlignment():Int {
		return _alignment;
	}
	
	/**
	 * Defines the text alignment for this label.
	 * 
	 * @param	alignment	The text alignment for this label. (e.g. Font.LEFT)
	 * @return	The new text alignment.
	 */
	private function setAlignment(alignment:Int):Int {
		if (alignment == this._alignment)
			return alignment;
		
		_alignment = alignment;
		refreshTextFormat();
		return _alignment;
	}
	
	/**
	 * Returns the color of the text displayed in the label.
	 * 
	 * @return	The color of the text displayed in the label.
	 */
	private function getColor():Int {
		return _color;
	}
	
	/**
	 * Defines the color of the text displayed in the label.
	 * 
	 * @param	color	The color of the text displayed in the label.
	 * @return	The new color.
	 */
	private function setColor(color:Int):Int {
		if (color == this._color)
			return color;
		
		_color = color;
		refreshTextFormat();
		return _color;
	}
	
	/**
	 * Returns transparency of this label.
	 * 
	 * @return	The transparency of this label. (0 = Transparent, 1 = Solid)
	 */
	private function getAlpha():Float {
		return _alpha;
	}
	
	/**
	 * Defines the transparency of this label.
	 * 
	 * @param	alpha	The transparency of this label.
	 * 					(0 = Transparent, 1 = Solid)
	 * @return	The new transparency.
	 */
	private function setAlpha(alpha:Float):Float {
		alpha = Math.min(1, Math.max(0, alpha));
		if (alpha == this._alpha)
			return alpha;
		
		_alpha = alpha;
		refreshAlpha();
		return _alpha;
	}
	
	/**
	 * Refreshes the text of this label. This should be called whenever the
	 * text to be displayed by this label has been changed.
	 */
	private function refreshText():Void {
		if (Std.is(_font, EmbeddedFont)) {
			_textField.text = this.text;
			_textField.setTextFormat(_textField.defaultTextFormat);
		} else {
			recreateCanvas();
			redrawCanvas();
		}
	}
	
	/**
	 * Refreshes the transparency of this label. This should be called whenever
	 * the transparency of this label has been changed.
	 */
	private function refreshAlpha():Void {
		if (Std.is(_font, EmbeddedFont)) {
			#if cpp
			_textField.alpha = alpha;
			#end
		} else {
			redrawCanvas();
		}
	}
	
	/**
	 * Refreshes the text format. This should be called whenever the font,
	 * color or the text alignment of this label has been changed.
	 */
	private function refreshTextFormat():Void {
		if (Std.is(font, EmbeddedFont)) {
			var f:EmbeddedFont = cast(font, EmbeddedFont);
			
			this._textField.defaultTextFormat = new TextFormat(
				f.textFormat.font, f.textFormat.size, color, null, null, null,
				null, null, Font.getTextFormatAlign(alignment));
			
			_textField.setTextFormat(_textField.defaultTextFormat);
		} else {
			redrawCanvas();
		}
	}
	
	/**
	 * Recreates the canvas used for caching of bitmap fonts.
	 */
	private function recreateCanvas():Void {
		var metrics:Rectangle = font.getTextMetrics(text);
		if (metrics.width == 0) {
			metrics = new Rectangle(metrics.x, metrics.y, 1, metrics.height);
		}
		if (metrics.height == 0) {
			metrics = new Rectangle(metrics.x, metrics.y, metrics.width, 1);
		}
		_canvas = new Canvas(new BitmapData(
			Std.int(metrics.width), Std.int(metrics.height)));
	}
	
	/**
	 * Redraws the canvas used for caching of bitmap fonts.
	 */
	private function redrawCanvas():Void {
		_canvas.clear();
		var x:Float = 0;
		if (alignment == Font.CENTER) {
			x = _canvas.width / 2;
		} else if (alignment == Font.RIGHT) {
			x = _canvas.width;
		}
		_canvas.drawString(font, text, color, x, 0, alignment, alpha);
	}
	
	/**
	 * Refreshes the whole label.
	 */
	private function refreshAll():Void {
		if (Std.is(font, EmbeddedFont)) {
			refreshTextFormat();
			refreshAlpha();
			refreshText();
		} else {
			recreateCanvas();
			redrawCanvas();
		}
	}
	
}