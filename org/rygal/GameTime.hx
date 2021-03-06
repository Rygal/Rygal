// Copyright (C) 2012 Robert Böhm
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
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
	public var totalMs(default, null):Int;
	
	/** The elapsed time in milliseconds. */
	public var elapsedMs(default, null):Int;
	
	/** The elapsed time in seconds. */
	public var elapsedS(default, null):Float;
	
	
	/**
	 * Creates a new object holding time information.
	 * 
	 * @param	now			The current system time.
	 * @param	lastUpdate	The last system time, used to calculate the delta
	 * 						values.
	 * @param	speed		The speed modifier, will be multiplied to the
	 * 						elapsed values.
	 */
	public function new(now:Int, lastUpdate:Int, speed:Float = 1) {
		totalMs = now;
		elapsedMs = Math.round(speed * (now - lastUpdate));
		elapsedS = speed * elapsedMs / 1000.0;
	}
	
}
