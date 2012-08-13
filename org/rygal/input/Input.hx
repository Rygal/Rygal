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
	
	
	private var _mouse:Bool;
	
	private var _touch:Bool;
	
	private var _keyBindings:List<Int>;
	
	private var _keySets:List<Keyset>;
	
	private var _mouseButtonMask:Int;
	
	private var _originX:Float;
	
	private var _originY:Float;
	
	
	public function new(game:Game, name:String) {
		super();
		
		this._keyBindings = new List<Int>();
		this._keySets = new List<Keyset>();
		this._mouseButtonMask = 0;
		this._mouse = false;
		this._touch = false;
		this._originX = 0;
		this._originY = 0;
		this.game = game;
		this.name = name;
	}
	
	
	public function setOrigin(x:Float, y:Float):Void {
		this._originX = x;
		this._originY = y;
	}
	
	public function bindMouse():Void {
		this._mouse = true;
		this.store();
	}
	
	public function bindTouch():Void {
		this._touch = true;
		this.store();
	}
	
	public function bindMousebutton(key:Int):Void {
		this._mouseButtonMask |= key;
		this.store();
	}
	
	public function bindKey(key:Int):Void {
		if (Lambda.has(_keyBindings, key))
			return;
		
		this._keyBindings.push(key);
		this.store();
	}
	
	public function bindKeyset(keyset:Keyset):Void {
		if (Lambda.has(_keySets, keyset))
			return;
		
		this._keySets.push(keyset);
		this.store();
	}
	
	public function update():Void { }
	
	public function connect(storage:Storage):Void {
		this.storage = storage;
		
		if (this.storage.isset(getStorageName("mouseButtons"))) {
			var obj = this.storage.get(getStorageName("mouseButtons"));
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
		
		if (this.storage.isset(getStorageName("mouse"))) {
			var obj = this.storage.get(getStorageName("mouse"));
			if (Std.is(obj, Bool)) {
				this._mouse = cast(obj, Bool);
			}
		}
		
		if (this.storage.isset(getStorageName("touch"))) {
			var obj = this.storage.get(getStorageName("touch"));
			if (Std.is(obj, Bool)) {
				this._touch = cast(obj, Bool);
			}
		}
		
		this.store();
	}
	
	public function reset():Void {
		this._keySets.clear();
		this._keyBindings.clear();
		this._mouseButtonMask = 0;
		this._mouse = false;
		this._touch = false;
		storage.unset(getStorageName("mouseButtons"));
		storage.unset(getStorageName("keys"));
		storage.unset(getStorageName("mouse"));
		storage.unset(getStorageName("touch"));
	}
	
	private function store():Void {
		if (storage != null) {
			storage.put(getStorageName("mouseButtons"), this._mouseButtonMask);
			
			var keyString:String = "";
			for (key in _keyBindings) {
				keyString += key + ",";
			}
			storage.put(getStorageName("keys"), keyString);
			
			storage.put(getStorageName("mouse"), this._mouse);
			storage.put(getStorageName("touch"), this._touch);
		}
	}
	
	
	private function getStorageName(variable:String):String {
		return this.name + DELIMITER + variable;
	}
	
}