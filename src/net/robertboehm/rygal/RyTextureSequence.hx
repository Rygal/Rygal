package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyTextureSequence {
	
	private var _textures:Array<RyTexture>;
	public var length:Int;
	
	public function new(textures:Array<RyTexture>) {
		this._textures = textures;
		this.length = textures.length;
	}
	
	public function get(id:Int) {
		return _textures[id];
	}
	
	public function iterator():RyTextureSequenceIterator {
		return new RyTextureSequenceIterator(this);
	}
	
	public function getLoopingIterator():RyTextureSequenceIterator {
		return new RyTextureSequenceIterator(this, true);
	}
	
	
	/**
	 * The following range is taken:
	 * start <= Texture ID < end
	 * 
	 * @param	start	The first ID to use (Inclusive).
	 * @param	end		The last ID to use (Exclusive).
	 * @return	
	 */
	public static function fromTileset(tileset:RyTileset, start:Int = 0, end:Int = -1):RyTextureSequence {
		if (end < 0)
			end = tileset.length;
		
		var textures:Array<RyTexture> = new Array<RyTexture>();
		for (i in start...end) {
			textures.push(tileset.getTextureById(i));
		}
		return new RyTextureSequence(textures);
	}
	
	public static function fromSpritesheet(spritesheet:RySpritesheet, names:Array<String>):RyTextureSequence {
		var textures:Array<RyTexture> = new Array<RyTexture>();
		for (name in names) {
			textures.push(spritesheet.getTexture(name));
		}
		return new RyTextureSequence(textures);
	}
	
}