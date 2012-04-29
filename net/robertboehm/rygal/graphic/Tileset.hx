// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;

/**
 * <h2>Description</h2>
 * <p>
 * 	A tileset that contains multiple textures.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	var tileset:Tileset = new Tileset(<br />
 * 	&nbsp;&nbsp;Texture.fromAssets("assets/walkAnimation.png"), 4, 1);<br />
 * 	<br />
 * 	var sprite:AnimatedSprite = new AnimatedSprite();<br />
 * 	sprite.registerAnimation("walk", Animation.fromTileset(250, tileset));<br />
 * 	sprite.loop("walk");
 * </code>
 * 
 * @author Robert Böhm
 */
class Tileset {
	
	/** The width of each tile. */
	public var tileWidth:Int;
	
	/** The height of each tile. */
	public var tileHeight:Int;
	
	/** The amount of columns. */
	public var columns:Int;
	
	/** The amount of rows. */
	public var rows:Int;
	
	/** The amount of tiles. */
	public var length:Int;
	
	/** The textures this tileset contains. */
	private var _textures:Array<Texture>;

	
	/**
	 * Creates a new tileset based on the given texture, the amount of columns
	 * and the amount of rows.
	 * 
	 * @param	texture	The texture the tileset is based on.
	 * @param	columns	The amount of columns the tileset has.
	 * @param	rows	The amount of rows the tileset has.
	 */
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
	
	/**
	 * Creates a new tileset based on the given texture and tile metrics.
	 * 
	 * @param	texture		The texture the tileset is based on.
	 * @param	tileWidth	The width of each tile of the tileset.
	 * @param	tileHeight	The height of each tile of the tileset.
	 * @return	The new tileset based on the given properties.
	 */
	public static function fromTileSize(texture:Texture, tileWidth:Int, tileHeight:Int):Tileset {
		return new Tileset(texture, Std.int(texture.width / tileWidth), Std.int(texture.height / tileHeight));
	}
	
	/**
	 * Returns the tile ID of the given tile position.
	 * 
	 * @param	x	The x-position in tiles.
	 * @param	y	The y-position in tiles.
	 * @return	The tile ID.
	 */
	public function getId(x:Int, y:Int):Int {
		return x + y * columns;
	}
	
	/**
	 * Returns the texture with the given tile ID.
	 * 
	 * @param	id	The tile ID.
	 * @return	The texture with the given tile ID.
	 */
	public function getTextureById(id:Int):Texture {
		if (id < 0 || id >= length)
			return null;
		
		return _textures[id];
	}
	
	/**
	 * Returns the texture on the given tile position.
	 * 
	 * @param	x	The x-position in tiles.
	 * @param	y	The y-position in tiles.
	 * @return	The texture on the given tile position.
	 */
	public function getTexture(x:Int, y:Int):Texture {
		if (x < 0 || y < 0 || x >= columns || y >= rows)
			return null;
		
		return _textures[x + y * columns];
	}
	
}