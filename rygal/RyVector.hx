// Copyright (C) 2011 Christopher Kaster
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package rygal;

/**
 * ...
 * @author Christopher Kaster
 */
class RyVector {
	
	public var x:Float;
	public var y:Float;
	
	public static var Zero:RyVector = new RyVector(0, 0);
	public static var One:RyVector = new RyVector(1, 1);
	
	public function new(?x:Float, ?y:Float) {
		if (x != null) {
			this.x = x;
			if (y != null) {
				this.y = y;
			} else {
				this.y = 0;
			}
		} else {
			this.x = 0;
			this.y = 0;
		}
	}
	
	public function add(v:RyVector) {
		this.x += v.x;
		this.y += v.y;
	}
	
	public function divide(scalar:Float) {
		this.x /= scalar;
		this.y /= scalar;
	}
	
	public function equals(v:RyVector):Bool {
		if (this.x == v.x && this.y == v.y)
			return true;
		else
			return false;
	}
}
 