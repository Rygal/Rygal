package net.robertboehm.rygal.graphic;

/**
 * ...
 * @author Robert Böhm
 */

class RyAnimation {
	
	public var frameDelay(default, default):Int;
	public var sequence(default, default):RyTextureSequence;
	
	public function new(frameDelay:Int, sequence:RyTextureSequence) {
		this.frameDelay = frameDelay;
		this.sequence = sequence;
	}
	
	public static function fromTileset(frameDelay:Int, tileset:RyTileset, start:Int = 0, end:Int = -1):RyAnimation {
		return new RyAnimation(frameDelay, RyTextureSequence.fromTileset(tileset, start, end));
	}
	
	public static function fromSpritesheet(frameDelay:Int, spritesheet:RySpritesheet, names:Array<String>):RyAnimation {
		return new RyAnimation(frameDelay, RyTextureSequence.fromSpritesheet(spritesheet, names));
	}
	
}