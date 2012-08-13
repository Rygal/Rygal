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
 * <h2>Description</h2>
 * <p>
 * 	A controller that is used to abstract physical inputs from the game logic.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	private var controller:Controller;<br />
 * 	<br />
 * 	override public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;controller = new Controller(game);<br />
 * 	&nbsp;&nbsp;this.addChildAt(controller, 0);<br />
 * 	&nbsp;&nbsp;controller.registerInput("fire", BinaryInput);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;controller.bindKey("fire", Keys.SPACE);<br />
 * 	&nbsp;&nbsp;controller.bindKey("fire", Keys.RETURN);<br />
 * 	&nbsp;&nbsp;controller.bindMousebutton("fire", Mouse.LEFT);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;controller.connect(new Storage("controls"));<br />
 * 	}<br />
 * 	<br />
 * 	override public function unload():Void {<br />
 * 	&nbsp;&nbsp;super.unload();<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;if(controller.queryBinaryInput("fire")) {<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;// Shoot a projectile...<br />
 * 	&nbsp;&nbsp;}<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Controller extends BasicGameObject {
	
	/** The storage this controller is connected to. */
	private var _storage:Storage;
	
	/** The game this controller is bound to. */
	private var _game:Game;
	
	/** The inputs this controller contains. */
	private var _inputs:Hash<Input>;
	
	
	/**
	 * Creates a new controller for the given game.
	 * 
	 * @param	game	The game this controller will be bound to.
	 */
	public function new(game:Game) {
		super();
		
		this._storage = null;
		this._game = game;
		this._inputs = new Hash<Input>();
	}
	
	
	/**
	 * Registers a new input with the given name and type on this controller.
	 * 
	 * @param	name	The name of the new input.
	 * @param	type	The type of the new input. For instance BinaryInput or
	 * 					DirectionalInput.
	 */
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
	
	/**
	 * Defines the origin of the given input. This may only affect directional
	 * inputs.
	 * 
	 * @param	input	The input this new origin will be given to.
	 * @param	x		The x-coordinate of the origin.
	 * @param	y		The y-coordinate of the origin.
	 */
	public function setOrigin(input:String, x:Float, y:Float):Void {
		_inputs.get(input).setOrigin(x, y);
	}
	
	/**
	 * Binds a mouse to the given input.
	 * 
	 * @param	input	The input the mouse will be bound to.
	 */
	public function bindMouse(input:String):Void {
		_inputs.get(input).bindMouse();
	}
	
	/**
	 * Binds touch devices to the given input.
	 * 
	 * @param	input	The input touch devices will be bound to.
	 */
	public function bindTouch(input:String):Void {
		_inputs.get(input).bindTouch();
	}
	
	/**
	 * Binds the given mouse button to the given input.
	 * 
	 * @param	input	The input the mouse button will be bound to.
	 * @param	button	The mouse button that will be bound to the given input.
	 */
	public function bindMousebutton(input:String, button:Int):Void {
		_inputs.get(input).bindMousebutton(button);
	}
	
	/**
	 * Binds the given key to the given input.
	 * 
	 * @param	input	The input the key will be bound to.
	 * @param	key		The key that will be bound to the given input.
	 */
	public function bindKey(input:String, key:Int):Void {
		_inputs.get(input).bindKey(key);
	}
	
	/**
	 * Binds the given keyset to the given input.
	 * 
	 * @param	input	The input the keyset will be bound to.
	 * @param	keyset	The keyset that will be bound to the given input.
	 */
	public function bindKeyset(input:String, keyset:Keyset):Void {
		_inputs.get(input).bindKeyset(keyset);
	}
	
	/**
	 * Queries the state of the given input. This will only work on
	 * BinaryInputs!
	 * 
	 * @param	input	The input whose state will be queried.
	 * @return	The state of the given input.
	 */
	public function queryBinaryInput(input:String):Bool {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, BinaryInput)) {
			return cast(_inputs.get(input), BinaryInput).state;
		}
		return false;
	}
	
	/**
	 * Determines if the given input has any direction. This will only work on
	 * DirectionalInputs!
	 * 
	 * @param	input	The input whose direction will be queried.
	 * @return	True, if the given input has any direction, else false.
	 */
	public function hasDirection(input:String):Bool {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, DirectionalInput)) {
			return cast(_inputs.get(input), DirectionalInput).hasDirection;
		}
		return false;
	}
	
	/**
	 * Returns the direction of the given input. This will only work on
	 * DirectionalInputs!
	 * 
	 * @param	input	The input whose direction will be queried.
	 * @return	The direction of the given input in radian measure.
	 */
	public function getDirection(input:String):Float {
		var i:Input = _inputs.get(input);
		if (i != null && Std.is(i, DirectionalInput)) {
			return cast(_inputs.get(input), DirectionalInput).direction;
		}
		return 0;
	}
	
	/**
	 * Returns the x-coordinate of a directional vector of the given input. This
	 * will only work on DirectionalInputs!
	 * 
	 * @param	input	The input whose direction will be queried.
	 * @return	The x-coordinate of a vector with the given direction or 0 if
	 * 			the given input doesn't have any direction.
	 */
	public function getDirectionalVectorX(input:String):Float {
		if (!hasDirection(input))
			return 0;
		
		return Math.cos(getDirection(input));
	}
	
	/**
	 * Returns the y-coordinate of a directional vector of the given input. This
	 * will only work on DirectionalInputs!
	 * 
	 * @param	input	The input whose direction will be queried.
	 * @return	The y-coordinate of a vector with the given direction or 0 if
	 * 			the given input doesn't have any direction.
	 */
	public function getDirectionalVectorY(input:String):Float {
		if (!hasDirection(input))
			return 0;
		
		return Math.sin(getDirection(input));
	}
	
	/**
	 * Connects this controller to the given storage.
	 * 
	 * @param	storage	The storage this controller will be connected to.
	 */
	public function connect(storage:Storage):Void {
		_storage = storage;
		
		for (input in _inputs) {
			input.connect(storage);
		}
	}
	
	/**
	 * Updates this controller as well as the inputs of it.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	override public function update(time:GameTime):Void {
		super.update(time);
		
		for (input in _inputs) {
			input.update();
		}
	}
	
	
	/**
	 * Dispatches the given ControllerEvent.
	 * 
	 * @param	e	The ControllerEvent to be dispatched.
	 */
	private function redirectEvent(e:ControllerEvent):Void {
		this.dispatchEvent(new ControllerEvent(e.type, e.input));
	}
	
}