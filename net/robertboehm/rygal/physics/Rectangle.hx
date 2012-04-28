// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.physics;

/**
 * ...
 * @author Robert Böhm
 */

class Rectangle implements Primitive {
	
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var rect:nme.geom.Rectangle;
	
	public function new(x:Float, y:Float, width:Float, height:Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.rect = new nme.geom.Rectangle(x, y, width, height);
	}
	
	public function getPrimitive():Primitive {
		return this;
	}
	
	public function collides(obj:PhysicalObject):Bool {
		if (Std.is(obj, Rectangle)) {
			return this.rect.intersects(cast(obj, Rectangle).rect);
		}
		return false;
	}
	
}