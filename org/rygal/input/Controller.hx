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
import org.rygal.util.Storage;

/**
 * ...
 * @author Robert Böhm
 */
class Controller extends BasicGameObject {
	
	private var _storage:Storage;
	
	private var _game:Game;
	
	private var _inputs:Hash<Input>;
	
	
	public function new(game:Game) {
		super();
		
		this._storage = null;
		this._game = game;
		this._inputs = new Hash<Input>();
	}
	
	
	public function registerInput<T:Input>(name:String, type:Class<T>):Void {
		var input:Input;
		
		if (type == BinaryInput) {
			input = new BinaryInput(_game, name);
			input.addEventListener(ControllerEvent.PRESSED, redirectEvent);
			input.addEventListener(ControllerEvent.RELEASED, redirectEvent);
			_inputs.set(name, input);
		} else if (type == DirectionalInput) {
			input = new DirectionalInput(_game, name);
			_inputs.set(name, input);
		} else {
			return;
		}
		
		if (_storage != null) {
			input.connect(_storage);
		}
	}
	
	public function setOrigin(input:String, x:Float, y:Float):Void {
		_inputs.get(input).setOrigin(x, y);
	}
	
	public function bindMouse(input:String):Void {
		_inputs.get(input).bindMouse();
	}
	
	public function bindTouch(input:String):Void {
		_inputs.get(input).bindTouch();
	}
	
	public function bindMousebutton(input:String, key:Int):Void {
		_inputs.get(input).bindMousebutton(key);
	}
	
	public function bindKey(input:String, key:Int):Void {
		_inputs.get(input).bindKey(key);
	}
	
	public function bindKeyset(input:String, keyset:Keyset):Void {
		_inputs.get(input).bindKeyset(keyset);
	}
	
	public function queryBinaryInput(input:String):Bool {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, BinaryInput)) {
			return cast(_inputs.get(input), BinaryInput).state;
		}
		return false;
	}
	
	public function hasDirection(input:String):Bool {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, DirectionalInput)) {
			return cast(_inputs.get(input), DirectionalInput).hasDirection;
		}
		return false;
	}
	
	public function getDirection(input:String):Float {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, DirectionalInput)) {
			return cast(_inputs.get(input), DirectionalInput).direction;
		}
		return 0;
	}
	
	public function getDirectionalVectorX(input:String):Float {
		if (!hasDirection(input))
			return 0;
		
		return Math.cos(getDirection(input));
	}
	
	public function getDirectionalVectorY(input:String):Float {
		if (!hasDirection(input))
			return 0;
		
		return Math.sin(getDirection(input));
	}
	
	public function connect(storage:Storage):Void {
		_storage = storage;
		
		for (input in _inputs) {
			input.connect(storage);
		}
	}
	
	override public function update(time:GameTime):Void {
		super.update(time);
		
		for (input in _inputs) {
			input.update();
		}
	}
	
	
	private function redirectEvent(e:ControllerEvent):Void {
		this.dispatchEvent(new ControllerEvent(e.type, e.input));
	}
	
}