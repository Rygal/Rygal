// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import net.robertboehm.rygal.graphic.RyCanvas;

/**
 * ...
 * @author Robert Böhm
 */

class RyGameObjectContainer implements RyGameObject {
	
	public var x:Float;
	public var y:Float;
	
	private var _children:Array<RyGameObject>;
	
	public function new() {
		_children = new Array<RyGameObject>();
	}
	
	public function addChildAt(child:RyGameObject, index:Int):Void {
		_children.insert(index, child);
	}
	
	public function addChild(child:RyGameObject):Void {
		_children.push(child);
	}
	
	public function removeChildren():Void {
		_children.splice(0, _children.length);
	}
	
	public function removeChild(child:RyGameObject):Void {
		_children.remove(child);
	}
	
	public function isChild(child:RyGameObject):Bool {
		for (c in _children) {
			if (c == child) {
				return true;
			}
		}
		return false;
	}
	
	public function getChildren():Array<RyGameObject> {
		return _children;
	}
	
	public function update(time:RyGameTime):Void {
		for (child in _children) {
			child.update(time);
		}
	}
	
	public function draw(screen:RyCanvas):Void {
		for (child in _children) {
			child.draw(screen);
		}
	}
	
}
