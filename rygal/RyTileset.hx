// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyTileset {
	
	public var tileWidth:Int;
	public var tileHeight:Int;
	public var columns:Int;
	public var rows:Int;
	public var length:Int;
	private var _textures:Array<RyTexture>;

	public function new(texture:RyTexture, columns:Int, rows:Int) {
		this.columns = columns;
		this.rows = rows;
		this.tileWidth = Math.floor(texture.width / columns);
		this.tileHeight = Math.floor(texture.height / rows);
		this._textures = new Array<RyTexture>();
		
		for (row in 0...rows) {
			for (col in 0...columns) {
				_textures.push(texture.slice(col * tileWidth, row * tileHeight, tileWidth, tileHeight));
			}
		}
		
		length = _textures.length;
	}
	
	public function fromTileSize(texture:RyTexture, tileWidth:Int, tileHeight:Int):RyTileset {
		return new RyTileset(texture, Math.floor(texture.width / columns), Math.floor(texture.height / rows));
	}
	
	public function getTextureById(id:Int):RyTexture {
		if (id < 0 || id >= length)
			return null;
		
		return _textures[id];
	}
	
	public function getTexture(x:Int, y:Int):RyTexture {
		if (x < 0 || y < 0 || x >= columns || y >= rows)
			return null;
		
		return _textures[x + y * columns];
	}
	
}