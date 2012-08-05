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

import nme.Assets;
import nme.text.AntiAliasType;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import org.rygal.physics.Rectangle;

/**
 * <h2>Description</h2>
 * <p>
 * 	A embedded font that can be loaded from the assets.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	// Prerequisites:<br />
 * 	// * The variable screen is a Canvas-object<br />
 * 	// * The font is located at "assets/myfont.ttf"<br />
 * 	var font:EmbeddedFont = EmbeddedFont.fromAssets("assets/myfont.ttf", 12);
 * 	<br />
 * 	screen.drawString(font, "Hello World!", 0xFF0000, 8, 8);
 * </code>
 * 
 * @author Robert Böhm
 */
class EmbeddedFont extends Font {
	
	/** The TextFormat-object this font is described by. */
	public var textFormat(default, null):TextFormat;
	
	
	/** The font this object is based on. */
	private var _font:nme.text.Font;
	
	/** The size of this font. */
	private var _size:Int;
	
	
	/**
	 * Creates a new embedded font based on the given NME-font and size.
	 * 
	 * @param	font	The font this object is based on.
	 * @param	size	The size of this font.
	 */
	public function new(font:nme.text.Font, size:Int) {
		super();
		
		this._font = font;
		this._size = size;
		this.textFormat = new TextFormat(this._font.fontName, size);
	}
	
	
	/**
	 * Creates a new embedded font from the assets.
	 * 
	 * @param	id		The asset id of this font.
	 * @param	size	The size of this font.
	 * @return	The embedded font.
	 */
	public static function fromAssets(id:String, size:Int):EmbeddedFont {
		return new EmbeddedFont(Assets.getFont(id), size);
	}
	
	
	/**
	 * Returns the metrics of the given text using this font.
	 * 
	 * @param	text	The text to be used.
	 * @return	The metrics of the given text.
	 */
	override public function getTextMetrics(text:String):Rectangle {
		var field:TextField = new TextField();
		field.embedFonts = true;
		field.antiAliasType = AntiAliasType.NORMAL;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.defaultTextFormat = this.textFormat;
		field.text = text;
		field.setTextFormat(field.defaultTextFormat);
		return new Rectangle(0, 0, field.width, field.height);
	}
	
}