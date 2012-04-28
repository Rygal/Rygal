// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.physics;
import net.robertboehm.rygal.GameObject;

/**
 * ...
 * @author Robert Böhm
 */

interface PhysicalObject {
	
	public function getPrimitive():Primitive;
	
	public function collides(object:PhysicalObject):Bool;
	
}