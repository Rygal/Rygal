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

class Animation {
	
	public var frameDelay(default, default):Int;
	public var sequence(default, default):TextureSequence;
	
	public function new(frameDelay:Int, sequence:TextureSequence) {
		this.frameDelay = frameDelay;
		this.sequence = sequence;
	}
	
	public static function fromTileset(frameDelay:Int, tileset:Tileset, start:Int = 0, end:Int = -1, reverse:Bool = false):Animation {
		return new Animation(frameDelay, TextureSequence.fromTileset(tileset, start, end, reverse));
	}
	
	public static function fromSpritesheet(frameDelay:Int, spritesheet:Spritesheet, names:Array<String>):Animation {
		return new Animation(frameDelay, TextureSequence.fromSpritesheet(spritesheet, names));
	}
	
}