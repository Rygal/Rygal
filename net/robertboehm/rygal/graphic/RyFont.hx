package net.robertboehm.rygal.graphic;

/**
 * ...
 * @author Robert Böhm
 */

class RyFont {
	
	private function new() { }
	
	public static function fromAssets(id:String, size:Int = -1):RyFont {
		if (size < 0) {
			// TODO: RyBitmapFont
			return null;
		} else {
			return RyEmbeddedFont.fromAssets(id, size);
		}
	}
	
}