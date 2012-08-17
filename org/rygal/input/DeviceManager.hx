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
import org.rygal.Game;

/**
 * <h2>Description</h2>
 * <p>
 *  A device managers that manages the devices of a specific type for games. If
 *  you want to implement your own device manager, please take a look at one of
 *  the default ones. (For instance KeyboardDeviceManager)
 * </p>
 * 
 * @author Robert Böhm
 */
class DeviceManager extends EventDispatcher {
    
    /** The game this device manager is registered on. */
    public var game(default, null):Game;
    
    
    /**
     * Creates a new device manager for the given game.
     * 
     * @param   game    The game this device manager is registered on.
     */
    public function new(game:Game) {
        super();
        
        this.game = game;
    }
    
    
    /**
     * Registers the default device managers. (Mouse, Keyboard & Touch)
     */
    public static function useDefaultDeviceManagers():Void {
        KeyboardDeviceManager.use();
        MouseDeviceManager.use();
        TouchDeviceManager.use();
        JoystickDeviceManager.use();
    }
    
    
    /**
     * Disposes this device manager.
     */
    public function dispose():Void { }
    
}
