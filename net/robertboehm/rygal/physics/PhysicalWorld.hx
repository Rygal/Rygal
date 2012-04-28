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

class PhysicalWorld implements PhysicalObject {
	
	private var _objects:Array<PhysicalObject>;
	
	public function new() {
		_objects = new Array<PhysicalObject>();
	}
	
	public function getPrimitive():Primitive {
		return null;
	}
	
	public function addObject(object:PhysicalObject):Void {
		_objects.push(object);
	}
	
	public function removeObjects():Void {
		_objects.splice(0, _objects.length);
	}
	
	public function removeObject(object:PhysicalObject):Void {
		_objects.remove(object);
	}
	
	public function collides(object:PhysicalObject):Bool {
		for (obj in _objects) {
			if (obj != object && obj.collides(object)) {
				return true;
			}
		}
		return false;
	}
	
}