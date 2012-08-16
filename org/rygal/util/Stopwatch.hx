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


package org.rygal.util;

import nme.Lib;

/**
 * <h2>Description</h2>
 * <p>
 * 	A stopwatch can keep track of time.
 * </p>
 * 
 * @author Robert Böhm
 */
class Stopwatch {
	
	/** The time this stopwatch has been started. (Default = 0) */
	public var startTime(default, null):Int;

	/** The time this stopwatch has been stopped. (Default = 0) */
	public var endTime(default, null):Int;

	/** The elapsed time since this stopwatch has been started. */
	public var elapsed(getElapsed, never):Int;
	
	
	/**
	 * Creates a new stopwatch.
	 */
	public function new() {
		this.startTime = 0;
		this.endTime = 0;
	}
	
	
	/**
	 * Starts this stopwatch.
	 */
	public function start():Void {
		this.startTime = Lib.getTimer();
	}
	
	/**
	 * Stops this stopwatch.
	 */
	public function stop():Void {
		this.endTime = Lib.getTimer();
	}
	
	
	/**
	 * Returns the elapsed time since this stopwatch has been started.
	 * 
	 * @return	The elapsed time since this stopwatch has been started.
	 */
	private function getElapsed():Int {
		if (this.endTime < this.startTime) {
			return Lib.getTimer() - this.startTime;
		} else {
			return this.endTime - this.startTime;
		}
	}
	
}
