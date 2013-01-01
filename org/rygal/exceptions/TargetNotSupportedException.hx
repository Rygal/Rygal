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
 *  An exception to be thrown whenever a target is not supported.
 * </p>
 * 
 * @author Christopher Kaster
 */
class TargetNotSupportedException extends Exception {
    
    /**
     * Creates a new TargetNotSupportedException for the current target
     */
    public function new() {
	var message:String = "Target not supported";

	#if cpp
	message += ": C++";	
	#elseif flash
	message += ": Flash";
	#elseif js
	message += ": JavaScript"
	#end

	super(message);
    }
    
}
