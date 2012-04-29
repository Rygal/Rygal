// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.physics;

import org.rygal.GameObject;

/**
 * <h2>Description</h2>
 * <p>
 * 	A physical object, providing two crucial methods:
 *	<ol>
 * 		<li>
 * 			A method that can provide a primitive object, matching the original
 * 			one as accurate as possible.
 * 		</li>
 * 		<li>
 * 			A method that can check if this object collides with another
 * 			physical object. The default behaviour would be to check my
 * 			primitive with the other one, but you can extend it by handling more
 * 			specific collision groups. (e.g. Sprite against Sprite)
 * 		</li>
 * 	</ol>
 * </p>
 * 
 * @author Robert Böhm
 */
interface PhysicalObject {
	
	/**
	 * Returns a primitive version of this object, matching the original one as
	 * accurate as possible.
	 * 
	 * @return A primitive version of this object.
	 */
	public function getPrimitive():Primitive;
	
	/**
	 * Determines if this object collides with another physical object. There's
	 * only one rule you have to follow when you implement this method on your
	 * own: Don't let the other object check the collision for you! This could
	 * result in infinite recursion. However, if you really have to do that,
	 * make sure it won't result in a recursion.
	 * 
	 * @param	object	The other physical object to check the collision with.
	 * @return	True if it collides, else false.
	 */
	public function collides(object:PhysicalObject):Bool;
	
}