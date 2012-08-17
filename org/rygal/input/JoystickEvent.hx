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

import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 *  Coming soon...
 * </p>
 * @author Christopher Kaster
 */
class JoystickEvent extends Event {

    public static var AXIS_MOVE:String = "axisMove";
    public static var BALL_MOVE:String = "ballMove";
    public static var BUTTON_DOWN:String = "buttonDown";
    public static var BUTTON_UP:String = "buttonUp";
    public static var HAT_MOVE:String = "hatMove";

    public var id:Int;
    public var deviceID:Int;
    
    public var x:Float;
    public var y:Float;
    public var z:Float;

    public function new(type:String, joystick:Joystick) {
        super(type);
        
        this.id = joystick.id;
        this.deviceID = joystick.deviceID;
        this.x = joystick.x;
        this.y = joystick.y;
        this.z = joystick.z;
    }
    
}
