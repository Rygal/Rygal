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

import nme.display.DisplayObject;
import nme.events.EventDispatcher;
import org.rygal.Game;

/**
 * <h2>Description</h2>
 * <p>
 * 	A simple keyboard. It will automatically be created by the Game-class.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	if (this.game.keyboard.isKeyPressed(Keys.SPACE)) {<br />
 * 	&nbsp;&nbsp;// Let the player jump<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Keyboard extends InputDevice {
	
	private static inline var KEYS_SIZE:Int = 512;
	
	/** An array with all key states. */
	private var _keys:Array<Bool>;
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of the mouse. */
	private var _handler:DisplayObject;

	
	/**
	 * Creates a new Keyboard-object for the given DisplayObject.
	 * 
	 * @param	handler	The DisplayObject this keyboard will be created for.
	 */
	public function new(game:Game) {
		super();
		
		_handler = game.getDisplayObject();
		
		_keys = new Array<Bool>();
		for (i in 0...512) {
			_keys.push(false);
		}
		
		_handler.stage.addEventListener(nme.events.KeyboardEvent.KEY_DOWN,
			onKeyDown);
		_handler.stage.addEventListener(nme.events.KeyboardEvent.KEY_UP,
			onKeyUp);
	}
	
	
	/**
	 * Determines if the given key is currently pressed.
	 * 
	 * @param	keyCode	The key that should be checked for. You can use the
	 * 					constants defined in the class Keys.
	 * 					For instance: Keys.SPACE for the space key.
	 * @return	True if the given key is pressed.
	 */
	public function isKeyPressed(keyCode:Int):Bool {
		if (keyCode >= 0 && keyCode < _keys.length) {
			return _keys[keyCode];
		}
		
		return false;
	}
	
	override public function dispose():Void {
		super.dispose();
		
		_handler.stage.removeEventListener(nme.events.KeyboardEvent.KEY_DOWN,
			onKeyDown);
		_handler.stage.removeEventListener(nme.events.KeyboardEvent.KEY_UP,
			onKeyUp);
	}
	
	
	/**
	 * A callback that will be called whenever a key is pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onKeyDown(e:nme.events.KeyboardEvent):Void {
		var intKeyCode:Int = cast(e.keyCode, Int);
		if (e.charCode >= "a".charCodeAt(0) && e.charCode <= 'z'.charCodeAt(0)) {
			intKeyCode = String.fromCharCode(e.charCode).toUpperCase().charCodeAt(0);
		}
		
		if (intKeyCode >= 0 && intKeyCode < _keys.length) {
			var previous:Bool = _keys[intKeyCode];
			_keys[intKeyCode] = true;
			
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_TYPED, this,
				intKeyCode, e.charCode));
			
			if (e.charCode != 0 || intKeyCode == Keys.DELETE) {
				// Delete didn't have a charCode on C++ target.
				dispatchEvent(new KeyboardEvent(KeyboardEvent.CHAR_TYPED, this,
					intKeyCode, e.charCode));
			}
			
			if (!previous) {
				dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, this,
					intKeyCode, e.charCode));
			}
		}
	}
	
	/**
	 * A callback that will be called whenever a key is released.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onKeyUp(e:nme.events.KeyboardEvent):Void {
		var intKeyCode:Int = cast(e.keyCode, Int);
		if (e.charCode >= "a".charCodeAt(0) && e.charCode <= 'z'.charCodeAt(0)) {
			intKeyCode = String.fromCharCode(e.charCode).toUpperCase().charCodeAt(0);
		}
		
		if (intKeyCode >= 0 && intKeyCode < _keys.length) {
			var previous:Bool = _keys[intKeyCode];
			_keys[intKeyCode] = false;
			
			if (previous) {
				dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, this,
					intKeyCode, e.charCode));
			}
		}
	}
	
}