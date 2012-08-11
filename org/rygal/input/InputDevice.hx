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


package org.rygal.input;

import nme.events.EventDispatcher;

/**
 * <h2>Description</h2>
 * <p>
 * 	A device handling specific input events. If you want to implement your own
 * 	device, please take a look at one of the default ones. (For instance
 * 	Keyboard)
 * </p>
 * 
 * @author Robert Böhm
 */
class InputDevice extends EventDispatcher {
	
	/**
	 * Creates a new input device.
	 */
	public function new() {
		super();
	}
	
	
	/**
	 * Disposes this input device.
	 */
	public function dispose():Void { }
	
}