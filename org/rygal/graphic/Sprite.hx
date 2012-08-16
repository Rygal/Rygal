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

import org.rygal.BasicGameObject;
import org.rygal.GameObject;
import org.rygal.GameTime;
import org.rygal.physics.PhysicalObject;
import org.rygal.physics.Primitive;
import org.rygal.physics.Rectangle;
import nme.geom.Rectangle;

/**
 * <h2>Description</h2>
 * <p>
 * 	A sprite that is based on a single texture.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	var sprite:Sprite = new Sprite(Texture.fromAssets("assets/fire.png"));<br />
 * 	this.addChild(sprite);
 * </code>
 * 
 * @author Robert Böhm
 */
class Sprite extends BasicGameObject, implements PhysicalObject {
	
	/** The width of this sprite. */
	public var width(getWidth, never):Int;
	
	/** The height of this sprite. */
	public var height(getHeight, never):Int;
	
	/** The offsets from the sides used for the collision bounding box. */
	public var boundOffsets:Rectangle;
	
	/** The texture of this sprite. Use setTexture() to change it! */
	public var texture:Texture;
	
	
	/**
	 * Creates a new sprite based on the given texture and properties.
	 * 
	 * @param	texture			The texture this sprite will be based on.
	 * @param	x				The x-coordinate of this sprite.
	 * @param	y				The y-coordinate of this sprite.
	 * @param	boundOffsets	The offsets from the sides used for the
	 * 							collision bounding box.
	 */
	public function new(texture:Texture, x:Float = 0, y:Float = 0,
			boundOffsets:Rectangle = null) {
		super(x, y);
		
		this.boundOffsets = boundOffsets;
		this.texture = texture;
	}
	
	
	/**
	 * Returns the bounding box for this sprite.
	 * 
	 * @return	The bounding box for this sprite.
	 */
	public function getPrimitive():Primitive {
		if (boundOffsets != null) {
			return new Rectangle(
					x + boundOffsets.x,
					y + boundOffsets.y,
					width - boundOffsets.width - boundOffsets.x,
					height - boundOffsets.height - boundOffsets.y
				);
		} else {
			return new Rectangle(x, y, width, height);
		}
	}
	
	/**
	 * Determines if this sprite collides with the other object.
	 * 
	 * @param	object	The other object.
	 * @return	True if this sprite collides with the other object.
	 */
	public function collides(object:PhysicalObject):Bool {
		return this.getPrimitive().collides(object.getPrimitive());
	}
	
	/**
	 * Draws this sprite onto the given screen.
	 * 
	 * @param	screen	The screen this sprite shall be drawn to.
	 */
	override public function draw(screen:Canvas):Void {
		screen.draw(texture, x, y);
	}
	
	
	/**
	 * Returns the width of this sprite.
	 * 
	 * @return	The width of this sprite.
	 */
	private function getWidth():Int {
		return texture == null ? 0 : texture.width;
	}
	
	/**
	 * Returns the height of this sprite.
	 * 
	 * @return	The height of this sprite.
	 */
	private function getHeight():Int {
		return texture == null ? 0 : texture.height;
	}
	
}
