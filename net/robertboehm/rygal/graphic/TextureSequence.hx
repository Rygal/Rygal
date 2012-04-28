// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;

/**
 * ...
 * @author Robert Böhm
 */

class TextureSequence {
	
	private var _textures:Array<Texture>;
	public var length:Int;
	
	public function new(textures:Array<Texture>) {
		this._textures = textures;
		this.length = textures.length;
	}
	
	public function get(id:Int) {
		return _textures[id];
	}
	
	public function iterator():TextureSequenceIterator {
		return new TextureSequenceIterator(this);
	}
	
	public function getIterator(repeatCount:Int=0):TextureSequenceIterator {
		return new TextureSequenceIterator(this, repeatCount);
	}
	
	
	/**
	 * The following range is taken:
	 * start <= Texture ID < end
	 * 
	 * @param	start	The first ID to use (Inclusive).
	 * @param	end		The last ID to use (Exclusive).
	 * @return	
	 */
	public static function fromTileset(tileset:Tileset, start:Int = 0, end:Int = -1, reverse:Bool = false):TextureSequence {
		if (end < 0)
			end = tileset.length;
		
		var textures:Array<Texture> = new Array<Texture>();
		for (i in start...end) {
			textures.push(tileset.getTextureById(i));
		}
		if (reverse) {
			var i:Int = end - 1;
			while (--i > start) {
				textures.push(tileset.getTextureById(i));
			}
		}
		return new TextureSequence(textures);
	}
	
	public static function fromSpritesheet(spritesheet:Spritesheet, names:Array<String>):TextureSequence {
		var textures:Array<Texture> = new Array<Texture>();
		for (name in names) {
			textures.push(spritesheet.getTexture(name));
		}
		return new TextureSequence(textures);
	}
	
}