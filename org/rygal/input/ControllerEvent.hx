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

import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 *  A controller event. It contains information about the related input.
 * </p>
 * 
 * @author Robert Böhm
 */
class ControllerEvent extends Event {
    
    /** An event that will be called when an input is pressed. */
    public static inline var PRESSED:String = "pressed";
    
    /** An event that will be called when an input is released. */
    public static inline var RELEASED:String = "released";
    
    
    /** The name of the input this controller event is raised by. */
    public var input(default, null):String;
    
    
    /**
     * Creates a new controller event with the given properties.
     * 
     * @param   type    The type of this event.
     *                  For instance: ControllerEvent.PRESSED
     * @param   input   The name of the input this event is raised by.
     */
    public function new(type:String, input:String) {
        super(type);
        
        this.input = input;
    }
    
}
