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
import org.rygal.util.Storage;

/**
 * ...
 * @author Robert Böhm
 */
class BinaryInput extends Input {
	
	public var state(default, null):Bool;
	
	private var _previousState:Bool;
	
	
	public function new(game:Game, name:String) {
		super(game, name);
		
		this.state = false;
		this._previousState = false;
	}
	
	
	override public function update():Void {
		_previousState = state;
		state = false;
		
		for (key in _keyBindings) {
			if (game.keyboard.isKeyPressed(key)) {
				state = true;
				break;
			}
		}
		
		if ((_mouseButtonMask & game.mouse.buttonMask) > 0) {
			state = true;
		}
		
		if (state != _previousState) {
			if (state) {
				this.dispatchEvent(
					new ControllerEvent(ControllerEvent.PRESSED, this.name));
			} else {
				this.dispatchEvent(
					new ControllerEvent(ControllerEvent.RELEASED, this.name));
			}
		}
	}
	
	override public function connect(storage:Storage):Void {
		super.connect(storage);
		
		
	}
	
}