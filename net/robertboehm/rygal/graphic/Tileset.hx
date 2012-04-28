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

class Tileset {
	
	public var tileWidth:Int;
	public var tileHeight:Int;
	public var columns:Int;
	public var rows:Int;
	public var length:Int;
	private var _textures:Array<Texture>;

	public function new(texture:Texture, columns:Int, rows:Int) {
		this.columns = columns;
		this.rows = rows;
		this.tileWidth = Std.int(texture.width / columns);
		this.tileHeight = Std.int(texture.height / rows);
		this._textures = new Array<Texture>();
		
		for (row in 0...rows) {
			for (col in 0...columns) {
				_textures.push(texture.slice(col * tileWidth, row * tileHeight, tileWidth, tileHeight));
			}
		}
		
		length = _textures.length;
	}
	
	public static function fromTileSize(texture:Texture, tileWidth:Int, tileHeight:Int):Tileset {
		return new Tileset(texture, Std.int(texture.width / tileWidth), Std.int(texture.height / tileHeight));
	}
	
	public function getId(x:Int, y:Int):Int {
		return x + y * columns;
	}
	
	public function getTextureById(id:Int):Texture {
		if (id < 0 || id >= length)
			return null;
		
		return _textures[id];
	}
	
	public function getTexture(x:Int, y:Int):Texture {
		if (x < 0 || y < 0 || x >= columns || y >= rows)
			return null;
		
		return _textures[x + y * columns];
	}
	
}