// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

import nme.Assets;

/**
 * <h2>Description</h2>
 * <p>
 * 	A font that is based on a tileset and character associations. It is also
 * 	capable of loading the Rygal-specific bitmap font definition file, more
 * 	details on that in the corresponding chapter.
 * </p>
 * 
 * <h2>Rygal's Bitmap Font Definition File Format</h2>
 * <p>
 * 	Rygal supports it's own, very simple, bitmap font format for monospaced
 * 	fonts. To create your own font, just create a tileset where each tile is one
 * 	character and create a corresponding character definition file. The
 * 	definition file looks like this:
 * </p>
 * <code>
 * 	%IMAGE_PATH%<br />
 * 	%TILE_WIDTH%x%TILE_HEIGHT%<br />
 * 	%CHARACTERS%
 * </code>
 * <p>
 * 	An example for a definition file of a font where the tileset is located at
 * 	"assets/charset.png" and each tile has a size of 6x13, whereas the tileset
 * 	contains the characters a-z, A-Z and 0-9, each in it's own row:
 * </p>
 * <code>
 * 	assets/charset.png<br />
 * 	6x13<br />
 * 	abcdefghijklmnopqrstuvwxyz<br />
 * 	ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
 * 	0123456789
 * </code>
 * <p>
 * 	The interpreter will automatically associate a character in the definition
 * 	file with the corresponding tile.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	// Prerequisites:<br />
 * 	// * The variable screen is a Canvas-object<br />
 * 	// * The character definition file is located at "assets/charset.txt"<br />
 * 	var font:BitmapFont = BitmapFont.fromAssets("assets/charset.txt");<br />
 * 	screen.drawString(font, "Hello World!", 0xFF0000, 8, 8);
 * </code>
 * 
 * @author Robert Böhm
 */
class BitmapFont extends Font {
	
	/** The width of each character. */
	public var charWidth:Int;
	
	/** The height of each character. */
	public var charHeight:Int;
	
	/** The tileset this font is based on. */
	private var _charset:Tileset;
	
	/** The characters with their corresponding tile IDs. */
	private var _characters:Hash<Int>;
	
	
	/**
	 * Creates a new bitmap font based on a tileset and character definitions.
	 * @param	charset		The tileset.
	 * @param	characters	The characters, whereas the coordinates have to
	 * 						match with their tile.
	 */
	public function new(charset:Tileset, characters:String) {
		super();
		
		this._charset = charset;
		this.charWidth = charset.tileWidth;
		this.charHeight = charset.tileHeight;
		
		this._characters = new Hash<Int>();
		var x:Int = 0;
		var y:Int = 0;
		for (i in 0...characters.length) {
			if (characters.charAt(i) == "\r" ||
				characters.charAt(i) == " ") {
				// Ignore
			} else if (characters.charAt(i) == "\n") {
				// Next line
				y++;
				x = 0;
			} else {
				// Regular character
				this._characters.set(
						characters.charAt(i), charset.getId(x++, y)
					);
			}
		}
	}
	
	/**
	 * Creates a new bitmap font, based on Rygal's bitmap font definition
	 * format.
	 * 
	 * @param	id	The bitmap font definition file.
	 * @return	The bitmap font that will be created.
	 */
	public static function fromAssets(id:String):BitmapFont {
		var definition:String = Assets.getText(id);
		var lines:Array<String> = definition.split("\n");
		var imageFile:String = StringTools.rtrim(lines[0]);
		var metrics:Array<String> = StringTools.rtrim(lines[1]).split("x");
		var width:Int = Std.parseInt(metrics[0]);
		var height:Int = Std.parseInt(metrics[1]);
		var characters:String = "";
		for (i in 2...lines.length) {
			if (i > 2)
				characters += "\n";
			
			characters += StringTools.rtrim(lines[i]);
		}
		
		return new BitmapFont(Tileset.fromTileSize(
			Texture.fromAssets(imageFile), width, height), characters);
	}
	
	/**
	 * Returns the texture for the given character.
	 * 
	 * @param	character	The character whose texture you're requesting.
	 * @return	The texture of the given character.
	 */
	public function getCharacterTexture(character:String):Texture {
		return _charset.getTextureById(_characters.get(character));
	}
	
}