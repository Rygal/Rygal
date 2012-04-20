// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.physics;
import net.robertboehm.rygal.RyGameObject;

/**
 * ...
 * @author Robert Böhm
 */

class RyPhysicalWorld implements RyPhysicalObject {
	
	private var _objects:Array<RyPhysicalObject>;
	
	public function new() {
		_objects = new Array<RyPhysicalObject>();
	}
	
	public function getPrimitive():RyPrimitive {
		return null;
	}
	
	public function addObject(object:RyPhysicalObject):Void {
		_objects.push(object);
	}
	
	public function removeObjects():Void {
		_objects.splice(0, _objects.length);
	}
	
	public function removeObject(object:RyPhysicalObject):Void {
		_objects.remove(object);
	}
	
	public function collides(object:RyPhysicalObject):Bool {
		for (obj in _objects) {
			if (obj != object && obj.collides(object)) {
				return true;
			}
		}
		return false;
	}
	
}