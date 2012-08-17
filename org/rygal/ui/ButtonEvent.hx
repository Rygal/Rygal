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


package org.rygal.ui;
import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 *  A button event. It may only be dispatched by buttons.
 * </p>
 * 
 * @author Robert Böhm
 */
class ButtonEvent extends Event {
    
    /** An event that will be called when the button was clicked. */
    public static inline var CLICKED:String = "clicked";

    
    /**
     * Creates a new ButtonEvent.
     * 
     * @param   type    The type of this event, use one of the constants of
     *                  ButtonEvent, for instance ButtonEvent.CLICKED.
     */
    public function new(type:String) {
        super(type);
    }
    
}
