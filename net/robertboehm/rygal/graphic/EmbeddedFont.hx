// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;

import nme.Assets;
import nme.text.TextFormat;

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
	public var textFormat:TextFormat;
	
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
	
}