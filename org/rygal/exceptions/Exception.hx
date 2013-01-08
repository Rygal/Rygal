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


package org.rygal.exceptions;

/**
 * <h2>Description</h2>
 * <p>
 *  A generic exception class.
 * </p>
 * <p>
 *  Note: The error system is not implemented yet!
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 *  try {<br />
 *  &nbsp;&nbsp;throw new Exception("Something happened!");<br />
 *  } catch(e:Exception) {<br />
 *  &nbsp;&nbsp;// You're screwed!<br />
 *  }
 * </code>
 * 
 * @author Robert Böhm
 */
class Exception {
    
    /** The message of this exception. */
    private var _message:String;
    
    
    /**
     * Creates a new exception.
     * 
     * @param   ?message    A message for this exception.
     */
    public function new(?message:String) {
        this._message = message;
    }
    
    
    /**
     * Returns this exception, formatted as a string.
     * 
     * @return  This exception as a string.
     */
    public function toString():String {
        return Type.getClassName(Type.getClass(this)) +
            (_message == null ? "" : ": " + _message);
    }
    
}
