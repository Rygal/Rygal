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
import org.rygal.util.Storage;

/**
 * ...
 * @author Robert Böhm
 */
class Input extends EventDispatcher {
	
	private static inline var DELIMITER:String = "<:$:>";
	
	
	public var name(default, null):String;
	
	public var game(default, null):Game;
	
	public var storage(default, null):Storage;
	
	
	private var _keyBindings:List<Int>;
	
	private var _mouseButtonMask:Int;
	
	
	public function new(game:Game, name:String) {
		super();
		
		this._keyBindings = new List<Int>();
		this._mouseButtonMask = 0;
		this.game = game;
		this.name = name;
	}
	
	
	public function bindMousebutton(key:Int):Void {
		this._mouseButtonMask |= key;
		if (storage != null) {
			storage.put(getStorageName("mouse"), this._mouseButtonMask);
		}
	}
	
	public function bindKey(key:Int):Void {
		if (Lambda.has(_keyBindings, key))
			return;
		
		this._keyBindings.push(key);
		if (storage != null) {
			var keyString:String = "";
			for (key in _keyBindings) {
				keyString += key + ",";
			}
			storage.put(getStorageName("keys"), keyString);
		}
	}
	
	public function reset():Void {
		this._keyBindings.clear();
		this._mouseButtonMask = 0;
	}
	
	public function update():Void { }
	
	public function connect(storage:Storage):Void {
		this.storage = storage;
		
		if (this.storage.isset(getStorageName("mouse"))) {
			var obj = this.storage.get(getStorageName("mouse"));
			if (Std.is(obj, Int)) {
				this._mouseButtonMask = cast(obj, Int);
			}
		}
		
		if (this.storage.isset(getStorageName("keys"))) {
			var obj = this.storage.get(getStorageName("keys"));
			if (Std.is(obj, String)) {
				var keyString:Array<String> = cast(obj, String).split(",");
				this._keyBindings.clear();
				for (s in keyString) {
					this._keyBindings.push(Std.parseInt(s));
				}
			}
		}
	}
	
	
	private function getStorageName(variable:String):String {
		return this.name + DELIMITER + variable;
	}
	
}