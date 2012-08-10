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
 * ...
 * @author Robert Böhm
 */
class MouseDeviceManager extends DeviceManager {
	
	public function new(game:Game) {
		super(game);
		
		game.registerDevice(new Mouse(game));
	}
	
	
	public static function use():Void {
		Game.registerDeviceManager(MouseDeviceManager);
	}
	
}