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
import nme.display.DisplayObject;
import nme.events.EventDispatcher;

/**
 * <h2>Description</h2>
 * <p>
 * 	A single-button mouse. It will automatically be created by the Game-class.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	if (this.game.mouse.isPressed) {<br />
 * 	&nbsp;&nbsp;// Let the player shoot<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Mouse extends InputDevice {
	
	/** The mask for the left mouse button. */
	public static inline var LEFT:Int = 1;
	
	/** The mask for the right mouse button. */
	public static inline var RIGHT:Int = 2;
	
	/** The mask for the middle mouse button. */
	public static inline var MIDDLE:Int = 4;
	
	
	/** The x-coordinate of the mouse. */
	public var x(default, null):Int;
	
	/** The y-coordinate of the mouse. */
	public var y(default, null):Int;
	
	/** Determines whether this mouse is pressed or not. */
	public var isPressed(default, null):Bool;
	
	/** Determines whether the right mouse button is pressed or not. */
	public var isRightButtonPressed(default, null):Bool;
	
	/** Determines whether the middle mouse button is pressed or not. */
	public var isMiddleButtonPressed(default, null):Bool;
	
	/** Returns a button mask for the current mouse state. For instance, it's
	 * 	001 if only the left button is pressed or 111 when every button is
	 * 	pressed. Use the Mouse.LEFT, ... constants to check for specific
	 * 	buttons.*/
	public var buttonMask(getButtonMask, never):Int;
	
	
	/** The absolute x-coordinate of the mouse. */
	private var _absoluteX:Int;
	
	/** The absolute y-coordinate of the mouse. */
	private var _absoluteY:Int;
	
	/** The game this mouse is based on. */
	private var _game:Game;
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of the mouse. */
	private var _handler:DisplayObject;
	
	
	/**
	 * Creates a new mouse for the given DisplayObject and Game.
	 * 
	 * @param	game	The Game this mouse will be created for.
	 */
	public function new(game:Game) {
		super();
		
		_game = game;
		_handler = game.getDisplayObject();
		
		isPressed = false;
		isRightButtonPressed = false;
		isMiddleButtonPressed = false;
		
	#if (js || cpp)
		_handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_MOVE,
			onMouseMove);
		_handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_DOWN,
			onMouseDown);
		_handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_UP,
			onMouseUp);
		_handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_WHEEL,
			onMouseWheel);
		
		#if cpp
		#if (!RYGAL_KEEP_MENU)
		_handler.stage.addEventListener(nme.events.MouseEvent.RIGHT_MOUSE_DOWN,
			onRightMouseDown);
		_handler.stage.addEventListener(nme.events.MouseEvent.RIGHT_MOUSE_UP,
			onRightMouseUp);
		#end
		_handler.stage.addEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_DOWN,
			onMiddleMouseDown);
		_handler.stage.addEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_UP,
			onMiddleMouseUp);
		#end
	#else
		_handler.addEventListener(nme.events.MouseEvent.MOUSE_MOVE,
			onMouseMove);
		_handler.addEventListener(nme.events.MouseEvent.MOUSE_DOWN,
			onMouseDown);
		_handler.addEventListener(nme.events.MouseEvent.MOUSE_UP,
			onMouseUp);
		_handler.addEventListener(nme.events.MouseEvent.MOUSE_WHEEL,
			onMouseWheel);
		
		#if (!flash || flash11_2)
		#if (!RYGAL_KEEP_MENU)
		_handler.addEventListener(nme.events.MouseEvent.RIGHT_MOUSE_DOWN,
			onRightMouseDown);
		_handler.addEventListener(nme.events.MouseEvent.RIGHT_MOUSE_UP,
			onRightMouseUp);
		#end
		_handler.addEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_DOWN,
			onMiddleMouseDown);
		_handler.addEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_UP,
			onMiddleMouseUp);
		#end
	#end
	}
	
	
	/**
	 * Displays the system cursor.
	 */
	public function show() {
		nme.ui.Mouse.show();
	}
	
	/**
	 * Hides the system cursor.
	 */
	public function hide() {
		nme.ui.Mouse.hide();
	}
	
	override public function dispose():Void {
		super.dispose();
		
	#if (js || cpp)
		_handler.stage.removeEventListener(nme.events.MouseEvent.MOUSE_MOVE,
			onMouseMove);
		_handler.stage.removeEventListener(nme.events.MouseEvent.MOUSE_DOWN,
			onMouseDown);
		_handler.stage.removeEventListener(nme.events.MouseEvent.MOUSE_UP,
			onMouseUp);
		_handler.stage.removeEventListener(nme.events.MouseEvent.MOUSE_WHEEL,
			onMouseWheel);
		
		#if cpp
		#if (!RYGAL_KEEP_MENU)
		_handler.stage.removeEventListener(
			nme.events.MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
		_handler.stage.removeEventListener(
			nme.events.MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
		#end
		_handler.stage.removeEventListener(
			nme.events.MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
		_handler.stage.removeEventListener(
			nme.events.MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);
		#end
	#else
		_handler.removeEventListener(nme.events.MouseEvent.MOUSE_MOVE,
			onMouseMove);
		_handler.removeEventListener(nme.events.MouseEvent.MOUSE_DOWN,
			onMouseDown);
		_handler.removeEventListener(nme.events.MouseEvent.MOUSE_UP,
			onMouseUp);
		_handler.removeEventListener(nme.events.MouseEvent.MOUSE_WHEEL,
			onMouseWheel);
		
		#if (!flash || flash11_2)
		#if (!RYGAL_KEEP_MENU)
		_handler.removeEventListener(nme.events.MouseEvent.RIGHT_MOUSE_DOWN,
			onRightMouseDown);
		_handler.removeEventListener(nme.events.MouseEvent.RIGHT_MOUSE_UP,
			onRightMouseUp);
		#end
		_handler.removeEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_DOWN,
			onMiddleMouseDown);
		_handler.removeEventListener(nme.events.MouseEvent.MIDDLE_MOUSE_UP,
			onMiddleMouseUp);
		#end
	#end
	}
	
	
	/**
	 * A callback that will be called whenever the mouse is pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseDown(e:nme.events.MouseEvent):Void {
		isPressed = true;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, this));
	}
	
	/**
	 * A callback that will be called whenever the mouse is released.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseUp(e:nme.events.MouseEvent):Void {
		isPressed = false;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, this));
	}
	
	/**
	 * A callback that will be called whenever the mouse is moved.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseMove(e:nme.events.MouseEvent):Void {
		var prevX:Int = this._absoluteX;
		var prevY:Int = this._absoluteY;
		#if js
		this._absoluteX = Std.int((e.stageX - _handler.x) / _game.zoom);
		this._absoluteY = Std.int((e.stageY - _handler.y) / _game.zoom);
		#else
		this._absoluteX = Std.int(e.localX / _game.zoom);
		this._absoluteY = Std.int(e.localY / _game.zoom);
		#end
		prevX += _game.cameraX;
		prevY += _game.cameraY;
		this.x = _absoluteX + _game.cameraX;
		this.y = _absoluteY + _game.cameraY;
		this.dispatchEvent(
				new MouseMoveEvent(MouseEvent.MOUSE_MOVE, this, prevX, prevY)
			);
	}
	
	/**
	 * A callback that will be called whenever the mouse wheel is moved.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseWheel(e:nme.events.MouseEvent):Void {
		this.dispatchEvent(new MouseWheelEvent(MouseEvent.MOUSE_WHEEL, this,
			e.delta));
	}
	
	/**
	 * A callback that will be called whenever the right mouse button is
	 * pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onRightMouseDown(e:nme.events.MouseEvent):Void {
		isRightButtonPressed = true;
		this.dispatchEvent(new MouseEvent(MouseEvent.RIGHT_MOUSE_DOWN, this));
	}
	
	/**
	 * A callback that will be called whenever the right mouse button is
	 * released.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onRightMouseUp(e:nme.events.MouseEvent):Void {
		isRightButtonPressed = false;
		this.dispatchEvent(new MouseEvent(MouseEvent.RIGHT_MOUSE_UP, this));
	}
	
	/**
	 * A callback that will be called whenever the middle mouse button is
	 * pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMiddleMouseDown(e:nme.events.MouseEvent):Void {
		isMiddleButtonPressed = true;
		this.dispatchEvent(new MouseEvent(MouseEvent.MIDDLE_MOUSE_DOWN, this));
	}
	
	/**
	 * A callback that will be called whenever the middle mouse button is
	 * released.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMiddleMouseUp(e:nme.events.MouseEvent):Void {
		isMiddleButtonPressed = false;
		this.dispatchEvent(new MouseEvent(MouseEvent.MIDDLE_MOUSE_UP, this));
	}
	
	/**
	 * Returns a button mask that can be used to check which buttons are
	 * pressed.
	 * 
	 * @return	A mask for the current mouse button states.
	 */
	private function getButtonMask():Int {
		return (this.isPressed ? Mouse.LEFT : 0) |
			(this.isRightButtonPressed ? Mouse.RIGHT : 0) |
			(this.isMiddleButtonPressed ? Mouse.MIDDLE : 0);
	}
	
}
