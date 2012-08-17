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


package org.rygal.audio;

import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 *  A sound event.
 * </p>
 * 
 * @author Robert Böhm
 */
class SoundEvent extends Event {
    
    /** An event that will be called when the sound is complete. */
    public static inline var SOUND_COMPLETE:String = "soundComplete";
    
    
    /**
     * Creates a new sound event.
     * 
     * @param   type    The type of this event.
     */
    public function new(type:String) {
        super(type);
    }
    
}
