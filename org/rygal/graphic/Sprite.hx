// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
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
	
	/** The offsets from the sides used for the collision bounding box. */
	public var boundOffsets:Rectangle;
	
	/** The width of this sprite. */
	public var width:Int;
	
	/** The height of this sprite. */
	public var height:Int;
	
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
		setTexture(texture);
	}
	
	/**
	 * Defines the texture of this sprite.
	 * 
	 * @param	texture	The new texture this sprite will be based on.
	 */
	public function setTexture(texture:Texture):Void {
		this.texture = texture;
		
		if (texture != null) {
			this.width = texture.width;
			this.height = texture.height;
		} else {
			this.width = 0;
			this.height = 0;
		}
	}
	
	/**
	 * Draws this sprite onto the given screen.
	 * 
	 * @param	screen	The screen this sprite shall be drawn to.
	 */
	override public function draw(screen:Canvas):Void {
		if(texture != null)
			screen.draw(texture, x, y);
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
	
}
