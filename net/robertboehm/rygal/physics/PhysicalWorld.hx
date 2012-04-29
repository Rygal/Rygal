// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.physics;

import net.robertboehm.rygal.GameObject;

/**
 * <h2>Description</h2>
 * <p>
 * 	A physical world, capable of holding multiple physical objects to check
 * 	collisions against. The current functionality is very restricted, there is
 * 	a more advanced version with integrated gravity, etc. planned for the
 * 	future.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	var sprite1:Sprite = new Sprite(Texture.fromAssets("assets/tex1.png"));
 * 	<br />
 * 	var sprite2:Sprite = new Sprite(Texture.fromAssets("assets/tex2.png"));
 * 	<br />
 * 	sprite2.x = Math.random() * (game.width - sprite2.width);<br />
 * 	sprite2.y = Math.random() * (game.height - sprite2.height);<br />
 * 	this.addChild(sprite1);<br />
 * 	this.addChild(sprite2);<br />
 * 	var world:PhysicalWorld = new PhysicalWorld();<br />
 * 	world.addObject(sprite1);<br />
 * 	world.addObject(sprite2);<br />
 * 	trace(world.collides(sprite1));
 * </code>
 * 
 * @author Robert Böhm
 */
class PhysicalWorld implements PhysicalObject {
	
	/** A container with all physical objects this world contains. */
	private var _objects:Array<PhysicalObject>;
	
	
	/**
	 * Creates a new physical world.
	 */
	public function new() {
		_objects = new Array<PhysicalObject>();
	}
	
	/**
	 * Returns a primitive version of this world. (Always null)
	 * 
	 * @return	Always null.
	 */
	public function getPrimitive():Primitive {
		return null;
	}
	
	/**
	 * Adds an object to this world.
	 * 
	 * @param	object	The object to be added.
	 */
	public function addObject(object:PhysicalObject):Void {
		_objects.push(object);
	}
	
	/**
	 * Removes all object from this world.
	 */
	public function removeObjects():Void {
		_objects.splice(0, _objects.length);
	}
	
	/**
	 * Removes an object from this world.
	 * 
	 * @param	object	The object to be removed.
	 */
	public function removeObject(object:PhysicalObject):Void {
		_objects.remove(object);
	}
	
	/**
	 * Determines if the given object collides with other objects of this world.
	 * 
	 * @param	object	The object to be checked whether it collides or not.
	 * @return	True, if this object collides with other objects of this world.
	 */
	public function collides(object:PhysicalObject):Bool {
		for (obj in _objects) {
			if (obj != object && obj.collides(object)) {
				return true;
			}
		}
		return false;
	}
	
}