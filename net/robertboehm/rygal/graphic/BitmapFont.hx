// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import nme.Assets;

/**
 * ...
 * @author Robert Böhm
 */

class BitmapFont extends Font {
	
	private var charset:Tileset;
	private var characters:Hash<Int>;
	public var charWidth:Int;
	public var charHeight:Int;
	
	public function new(charset:Tileset, characters:String) {
		super();
		
		this.charset = charset;
		this.charWidth = charset.tileWidth;
		this.charHeight = charset.tileHeight;
		
		this.characters = new Hash<Int>();
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
				this.characters.set(characters.charAt(i), charset.getId(x++, y));
			}
		}
	}
	
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
		
		return new BitmapFont(Tileset.fromTileSize(Texture.fromAssets(imageFile), width, height), characters);
	}
	
	public function getCharacterTexture(character:String):Texture {
		return charset.getTextureById(characters.get(character));
	}
	
}