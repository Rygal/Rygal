// Copyright (C) 2012 Robert Böhm
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

/**
 * <h2>Description</h2>
 * <p>
 * 	A spritesheet that contains multiple textures.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	var spritesheet:Spritesheet = new Spritesheet(<br />
 * 	&nbsp;&nbsp;Texture.fromAssets("assets/walkAnimation.png"), 4, 1);<br />
 * 	<br />
 * 	var sprite:AnimatedSprite = new AnimatedSprite();<br />
 * 	sprite.registerAnimation("walk", Animation.fromSpritesheet(250, spritesheet));<br />
 * 	sprite.loop("walk");
 * </code>
 * 
 * @author Robert Böhm
 */
class Spritesheet {
	
	/** The width of a sprite. */
	public var spriteWidth(default, null):Int;
	
	/** The height of a sprite. */
	public var spriteHeight(default, null):Int;
	
	/** The amount of columns. */
	public var columns(default, null):Int;
	
	/** The amount of rows. */
	public var rows(default, null):Int;
	
	/** The amount of sprites. */
	public var length(getLength, never):Int;
	
	
	/** The textures this spritesheet contains. */
	private var _textures:Array<Texture>;

	
	/**
	 * Creates a new spritesheet based on the given texture, the amount of columns
	 * and the amount of rows.
	 * 
	 * @param	texture	The texture the spritesheet is based on.
	 * @param	columns	The amount of columns the spritesheet has.
	 * @param	rows	The amount of rows the spritesheet has.
	 */
	public function new(texture:Texture, columns:Int, rows:Int) {
		this.columns = columns;
		this.rows = rows;
		this.spriteWidth = Std.int(texture.width / columns);
		this.spriteHeight = Std.int(texture.height / rows);
		this._textures = new Array<Texture>();
		
		for (row in 0...rows) {
			for (col in 0...columns) {
				_textures.push(texture.slice(col * spriteWidth, row * spriteHeight,
						spriteWidth, spriteHeight));
			}
		}
	}
	
	
	/**
	 * Creates a new spritesheet based on the given texture and sprite metrics.
	 * 
	 * @param	texture			The texture the spritesheet is based on.
	 * @param	spriteWidth		The width of each sprite of the spritesheet.
	 * @param	spriteHeight	The height of each sprite of the spritesheet.
	 * @return	The new spritesheet based on the given properties.
	 */
	public static function fromSpriteSize(texture:Texture, spriteWidth:Int,
			spriteHeight:Int):Spritesheet {
		
		return new Spritesheet(texture, Std.int(texture.width / spriteWidth),
			Std.int(texture.height / spriteHeight));
	}
	
	
	/**
	 * Returns the sprite ID of the given sprite position.
	 * 
	 * @param	x	The x-position in sprites.
	 * @param	y	The y-position in sprites.
	 * @return	The sprite ID.
	 */
	public function getId(x:Int, y:Int):Int {
		return x + y * columns;
	}
	
	/**
	 * Returns the texture with the given sprite ID.
	 * 
	 * @param	id	The sprite ID.
	 * @return	The texture with the given sprite ID.
	 */
	public function getTextureById(id:Int):Texture {
		if (id < 0 || id >= length)
			return null;
		
		return _textures[id];
	}
	
	/**
	 * Returns the texture on the given sprite position.
	 * 
	 * @param	x	The x-position in sprites.
	 * @param	y	The y-position in sprites.
	 * @return	The texture on the given sprite position.
	 */
	public function getTexture(x:Int, y:Int):Texture {
		if (x < 0 || y < 0 || x >= columns || y >= rows)
			return null;
		
		return _textures[x + y * columns];
	}
	
	
	/**
	 * Returns the amount of sprites.
	 * 
	 * @return	The amount of sprites.
	 */
	private function getLength():Int {
		return _textures.length;
	}
	
}