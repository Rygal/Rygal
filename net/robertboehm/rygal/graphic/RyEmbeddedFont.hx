package net.robertboehm.rygal.graphic;
import nme.Assets;
import nme.text.Font;
import nme.text.TextFormat;

/**
 * ...
 * @author Robert Böhm
 */

class RyEmbeddedFont extends RyFont {
	
	private var _font:Font;
	private var _size:Int;
	public var textFormat:TextFormat;
	
	public function new(font:Font, size:Int) {
		super();
		
		this._font = font;
		this._size = size;
		this.textFormat = new TextFormat(this._font.fontName, size);
	}
	
	public static function fromAssets(id:String, size:Int):RyEmbeddedFont {
		return new RyEmbeddedFont(Assets.getFont(id), size);
	}
	
}