// Copyright (C) 2011 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyGameTime {
	
	public var totalMs:Int;
	public var elapsedMs:Int;
	public var elapsedS:Float;

	public function new(now:Int, lastUpdate:Int) {
		totalMs = now;
		elapsedMs = now - lastUpdate;
		elapsedS = elapsedMs / 1000.0;
	}
	
}
