// Copyright (C) 2012 Christopher Kaster
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.

package rygal;

import nme.geom.Rectangle;

/**
 * ...
 * @author Christopher Kaster
 */

class RyRectangle extends Rectangle {
	
	public var position(getPosition, null):RyVector;
	
	private function getPosition():RyVector {
		return new RyVector(this.x, this.y);
	}
}