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
 *  An exception to be thrown whenever the arguments were invalid.
 * </p>
 * <p>
 *  Note: The exception system is not implemented yet!
 * </p>
 * 
 * @author Robert Böhm
 */
class InvalidArgumentException extends Exception {
    
    /**
     * Creates a new InvalidArgumentException with the given message.
     * 
     * @param   ?message    A message for this exception.
     */
    public function new(?message:String) {
        super(message);
    }
    
}
