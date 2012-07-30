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

/**
 * <h2>Description</h2>
 * <p>
 * 	A font that can be drawn on Canvas-objects.
 * </p>
 * 
 * <h2>Example (BitmapFont)</h2>
 * <code>
 * 	// Prerequisites:<br />
 * 	// * The variable screen is a Canvas-object<br />
 * 	// * The character definition file is located at "assets/charset.txt"<br />
 * 	var font:Font = Font.fromAssets("assets/charset.txt");<br />
 * 	screen.drawString(font, "Hello World!", 0xFF0000, 8, 8);
 * </code>
 * 
 * <h2>Example (EmbeddedFont)</h2>
 * <code>
 * 	// Prerequisites:<br />
 * 	// * The variable screen is a Canvas-object<br />
 * 	// * The font is located at "assets/myfont.ttf"<br />
 * 	var font:Font = Font.fromAssets("assets/myfont.ttf", 12);<br />
 * 	screen.drawString(font, "Hello World!", 0xFF0000, 8, 8);
 * </code>
 * 
 * @author Robert Böhm
 */
class Font {
	
	/** Left alignment. */
	public static inline var LEFT:Int = 0;
	
	/** Center alignment. */
	public static inline var CENTER:Int = 1;
	
	/** Right alignment. */
	public static inline var RIGHT:Int = 2;
	
	
	/**
	 * You can't create a font directly, use Bitmap- or EmbeddedFont instead.
	 */
	private function new() { }
	
	/**
	 * Loads a font from the assets. If you define a size, it's considered to be
	 * an embedded font, else it's considered to be a bitmap font.
	 * 
	 * @param	id		The asset id of the font.
	 * @param	size	The size of the font, use -1 to load a bitmap font.
	 * @return	The loaded font.
	 */
	public static function fromAssets(id:String, size:Int = -1):Font {
		if (size < 0) {
			return BitmapFont.fromAssets(id);
		} else {
			return EmbeddedFont.fromAssets(id, size);
		}
	}
	
}