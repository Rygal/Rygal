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

import org.rygal.Game;

/**
 * <h2>Description</h2>
 * <p>
 * 	A device manager for keyboards.
 * </p>
 * 
 * @author Robert Böhm
 */
class KeyboardDeviceManager extends DeviceManager {
	
	/**
	 * Creates a new keyboard device manager for the given game.
	 * 
	 * @param	game	The game the keyboard will be registered for.
	 */
	public function new(game:Game) {
		super(game);
		
		game.registerDevice(new Keyboard(game));
	}
	
	
	/**
	 * Registers this keyboard device manager on the Game so it'll be used on
	 * any games that will be created.
	 */
	public static function use():Void {
		Game.registerDeviceManager(KeyboardDeviceManager);
	}
	
}