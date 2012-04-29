// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

/**
 * <h2>Description</h2>
 * <p>
 * 	Contains time information.
 * </p>
 * 
 * @author Robert Böhm
 */
class GameTime {
	
	/** The system time in milliseconds. */
	public var totalMs:Int;
	
	/** The elapsed time in milliseconds. */
	public var elapsedMs:Int;
	
	/** The elapsed time in seconds. */
	public var elapsedS:Float;
	
	
	/**
	 * Creates a new object holding time information.
	 * 
	 * @param	now			The current system time.
	 * @param	lastUpdate	The last system time, used to calculate the delta
	 * 						values.
	 */
	public function new(now:Int, lastUpdate:Int) {
		totalMs = now;
		elapsedMs = now - lastUpdate;
		elapsedS = elapsedMs / 1000.0;
	}
	
}
