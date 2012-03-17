package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyTileset {
	
	public var tileWidth:Int;
	public var tileHeight:Int;
	public var columns:Int;
	public var rows:Int;
	private var _textures:Array<RyTexture>;

	public function new(texture:RyTexture, columns:Int, rows:Int) {
		this.columns = columns;
		this.rows = rows;
		this.tileWidth = Math.floor(texture.width / columns);
		this.tileHeight = Math.floor(texture.height / rows);
		this._textures = new Array<RyTexture>();
		
		for (col in 0...columns) {
			for (row in 0...rows) {
				_textures.push(texture.slice(col * tileWidth, row * tileHeight, tileWidth, tileHeight));
			}
		}
	}
	
	public function fromTileSize(texture:RyTexture, tileWidth:Int, tileHeight:Int):RyTileset {
		return new RyTileset(texture, Math.floor(texture.width / columns), Math.floor(texture.height / rows));
	}
	
	public function getTexture(x:Int, y:Int):RyTexture {
		if (x < 0 || y < 0 || x >= columns || y >= rows)
			return null;
		
		return _textures[y + x * rows];
	}
	
}