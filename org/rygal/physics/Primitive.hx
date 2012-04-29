// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.physics;

/**
 * <h2>Description</h2>
 * <p>
 * 	A primitive object. When you want to create your own primitive, you have to
 * 	make sure, you're able to provide collision checks for EVERY other
 * 	primitive! Also, you must not let the other object make the collision check
 * 	for you! (Would result in infinite recursion)
 * </p>
 * 
 * @author Robert Böhm
 */
interface Primitive implements PhysicalObject {
	
}