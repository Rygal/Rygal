// Copyright (C) 2012 Robert Böhm, Christopher Kaster
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

import org.rygal.Game;
import nme.display.DisplayObject;
import nme.events.EventDispatcher;

/**
 * <h2>Description</h2>
 * <p>
 * 	Coming soon....
 * </p>
 * @author Christopher Kaster
 */
class Joystick extends EventDispatcher {
	
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of touch events. */
	private var _handler:DisplayObject;
	
	
	/**
	 * Creates a new touch surface for the given DisplayObject.
	 * 
	 * @param	handler	The DisplayObject this touch pointer will be created
	 * 					for.
	 */
	public function new(handler:DisplayObject) {
		super();
		
		this._handler = handler;
		
		// TODO: add events to handler
	}
	
}
