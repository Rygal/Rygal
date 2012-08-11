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
import org.rygal.BasicGameObject;
import org.rygal.Game;
import org.rygal.GameTime;

/**
 * ...
 * @author Robert Böhm
 */
class Controller extends BasicGameObject {
	
	private var _game:Game;
	
	private var _inputs:Hash<Input>;
	
	
	public function new(game:Game) {
		super();
		
		this._game = game;
		this._inputs = new Hash<Input>();
	}
	
	
	public function registerInput<T:Input>(name:String, type:Class<T>):Void {
		if (type == BinaryInput) {
			var input:BinaryInput = new BinaryInput(_game, name);
			input.addEventListener(ControllerEvent.PRESSED, redirectEvent);
			input.addEventListener(ControllerEvent.RELEASED, redirectEvent);
			_inputs.set(name, input);
		}
	}
	
	public function bindMousebutton(input:String, key:Int):Void {
		_inputs.get(input).bindMousebutton(key);
	}
	
	public function bindKey(input:String, key:Int):Void {
		_inputs.get(input).bindKey(key);
	}
	
	public function queryInput(input:String):Bool {
		return cast(_inputs.get(input), BinaryInput).state;
	}
	
	override public function update(time:GameTime):Void {
		super.update(time);
		
		for (input in _inputs) {
			input.update();
		}
	}
	
	
	private function redirectEvent(e:ControllerEvent):Void {
		this.dispatchEvent(new ControllerEvent(e.type, e.source));
	}
	
}