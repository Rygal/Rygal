// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import nme.Assets;
import nme.filesystem.File;

/**
 * ...
 * @author Robert Böhm
 */

class Spritesheet {
	
	private var _textures:Hash<Texture>;
	
	private function new(textures:Hash<Texture>) {
		this._textures = textures;
	}
	
	public static function fromGenericXmlAsset(id:String):Spritesheet {
		return fromGenericXml(Assets.getText(id), id.substr(0, id.lastIndexOf("/")));
	}
	
	public static function fromGenericXml(xml:String, ?imageFolder:String):Spritesheet {
		if (imageFolder == null) {
			imageFolder = ".";
		}
		
		var lastChar:String = imageFolder.charAt(imageFolder.length - 1);
		if (lastChar != "/") {
			imageFolder += "/";
		}
		
		var textureAtlas:Xml = Xml.parse(xml).firstElement();
		var texture:Texture = Texture.fromAssets(imageFolder + textureAtlas.get("imagePath"));
		var textures:Hash<Texture> = new Hash<Texture>();
		var x:Int;
		var y:Int;
		var w:Int;
		var h:Int;
		for (sprite in textureAtlas) {
			if (sprite.nodeType == Xml.Element && sprite.nodeName == "sprite") {
				x = Std.parseInt(sprite.get("x"));
				y = Std.parseInt(sprite.get("y"));
				w = Std.parseInt(sprite.get("w"));
				h = Std.parseInt(sprite.get("h"));
				textures.set(sprite.get("n"), texture.slice(x, y, w, h));
			}
		}
		return new Spritesheet(textures);
	}
	
	public function getTexture(name:String):Texture {
		return _textures.get(name);
	}
	
}