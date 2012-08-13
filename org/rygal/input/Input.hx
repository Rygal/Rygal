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
 * <h2>Description</h2>
 * <p>
 * 	An input for the controller. Various devices can be bound to an input,
 * 	resulting in different behaviour depending on the input. (e.g. BinaryInput)
 * </p>
 * 
 * @author Robert Böhm
 */
class Input extends EventDispatcher {
	
	/** The delimiter used for storage. */
	private static inline var DELIMITER:String = "<:$:>";
	
	
	/** The name of this input. */
	public var name(default, null):String;
	
	/** The game this input is bound to. */
	public var game(default, null):Game;
	
	/** The storage this input is connected to. */
	public var storage(default, null):Storage;
	
	
	/** Determines if this input is attached to the mouse. */
	private var _mouse:Bool;
	
	/** Determines if this input is attached to touch devices. */
	private var _touch:Bool;
	
	/** The keys that are bound to this input. */
	private var _keyBindings:List<Int>;
	
	/** The keysets that are bound to this input. */
	private var _keySets:List<Keyset>;
	
	/** The mouse button mask used to determine which buttons this input is
	 * 	bound to. */
	private var _mouseButtonMask:Int;
	
	/** The x-coordinate of this input's origin, used to determine relative
	 * 	pointing inputs. */
	private var _originX:Float;
	
	/** The y-coordinate of this input's origin, used to determine relative
	 * 	pointing inputs. */
	private var _originY:Float;
	
	
	/**
	 * Creates a new input for the given game and with the given name.
	 * 
	 * @param	game	The game this input will be bound to.
	 * @param	name	The name of this input.
	 */
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
	
	
	/**
	 * Defines the origin of this input used for relative pointing inputs.
	 * 
	 * @param	x	The x-coordinate of the origin.
	 * @param	y	The x-coordinate of the origin.
	 */
	public function setOrigin(x:Float, y:Float):Void {
		this._originX = x;
		this._originY = y;
	}
	
	/**
	 * Binds the mouse to this input.
	 */
	public function bindMouse():Void {
		this._mouse = true;
		this.store();
	}
	
	/**
	 * Binds touch devices to this input.
	 */
	public function bindTouch():Void {
		this._touch = true;
		this.store();
	}
	
	/**
	 * Binds the given mouse button to this input.
	 * 
	 * @param	button	The mouse button to be bound.
	 */
	public function bindMousebutton(button:Int):Void {
		this._mouseButtonMask |= button;
		this.store();
	}
	
	/**
	 * Binds the given key to this input.
	 * 
	 * @param	key	The key to be bound.
	 */
	public function bindKey(key:Int):Void {
		if (Lambda.has(_keyBindings, key))
			return;
		
		this._keyBindings.push(key);
		this.store();
	}
	
	/**
	 * Binds the given keyset to this input.
	 * 
	 * @param	keyset	The keyset to be bound.
	 */
	public function bindKeyset(keyset:Keyset):Void {
		if (Lambda.has(_keySets, keyset))
			return;
		
		this._keySets.push(keyset);
		this.store();
	}
	
	/**
	 * Updates this input.
	 */
	public function update():Void { }
	
	/**
	 * Connects this input to the given storage.
	 * 
	 * @param	storage	The storage this input will be connected to.
	 */
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
		
		if (this.storage.isset(getStorageName("keySets"))) {
			var obj = this.storage.get(getStorageName("keySets"));
			if (Std.is(obj, String)) {
				var keySetsString:Array<String> = cast(obj, String).split(",");
				this._keySets.clear();
				for (s in keySetsString) {
					var keys:Array<String> = s.split("|");
					if (keys.length == 8) {
						this._keySets.push(new Keyset(
								Std.parseInt(keys[0]),
								Std.parseInt(keys[1]),
								Std.parseInt(keys[2]),
								Std.parseInt(keys[3]),
								Std.parseInt(keys[4]),
								Std.parseInt(keys[5]),
								Std.parseInt(keys[6]),
								Std.parseInt(keys[7])
							));
					}
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
	
	/**
	 * Resets this input.
	 */
	public function reset():Void {
		this._keySets.clear();
		this._keyBindings.clear();
		this._mouseButtonMask = 0;
		this._mouse = false;
		this._touch = false;
		storage.unset(getStorageName("mouseButtons"));
		storage.unset(getStorageName("keySets"));
		storage.unset(getStorageName("keys"));
		storage.unset(getStorageName("mouse"));
		storage.unset(getStorageName("touch"));
	}
	
	
	/**
	 * Stores the configuration of this input into a connected storage. (If
	 * there is one)
	 */
	private function store():Void {
		if (storage != null) {
			storage.put(getStorageName("mouseButtons"), this._mouseButtonMask);
			
			var keyString:String = "";
			for (key in _keyBindings) {
				keyString += key + ",";
			}
			storage.put(getStorageName("keys"), keyString);
			
			var keySetString:String = "";
			for (keySet in _keySets) {
				keySetString += keySet.getKey(Keyset.NORTH) + "|" +
								keySet.getKey(Keyset.EAST) + "|" +
								keySet.getKey(Keyset.SOUTH) + "|" +
								keySet.getKey(Keyset.WEST) + "|" +
								keySet.getKey(Keyset.NORTHEAST) + "|" +
								keySet.getKey(Keyset.SOUTHEAST) + "|" +
								keySet.getKey(Keyset.SOUTHWEST) + "|" +
								keySet.getKey(Keyset.NORTHWEST) + ",";
			}
			storage.put(getStorageName("keySets"), keySetString);
			
			storage.put(getStorageName("mouse"), this._mouse);
			storage.put(getStorageName("touch"), this._touch);
		}
	}
	
	/**
	 * Returns the name of the given configuration variable, based on it's name
	 * as well as the name of the input.
	 * 
	 * @param	variable	The name of the variable to be stored.
	 * @return	The name that may be used for variable access of the storage.
	 */
	private function getStorageName(variable:String):String {
		return this.name + DELIMITER + variable;
	}
	
}