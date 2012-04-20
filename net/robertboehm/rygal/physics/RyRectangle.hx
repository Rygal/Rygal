// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.physics;
import nme.geom.Rectangle;

/**
 * ...
 * @author Robert Böhm
 */

class RyRectangle implements RyPrimitive {
	
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var rect:Rectangle;
	
	public function new(x:Float, y:Float, width:Float, height:Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.rect = new Rectangle(x, y, width, height);
	}
	
	public function getPrimitive():RyPrimitive {
		return this;
	}
	
	public function collides(obj:RyPhysicalObject):Bool {
		if (Std.is(obj, RyRectangle)) {
			return this.rect.intersects(cast(obj, RyRectangle).rect);
		}
		return false;
	}
	
}