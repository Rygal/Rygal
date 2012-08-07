// Copyright (C) 2012 Robert Böhm, Christopher Kaster
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
import org.rygal.input.JoystickEvent;

import nme.display.DisplayObject;
import nme.events.EventDispatcher;

/**
 * <h2>Description</h2>
 * <p>
 * 	Coming soon....
 * </p>
 * @author Christopher Kaster
 */
class Joystick extends EventDispatcher {
	
	public var id:Int;
	public var deviceID:Int;
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	private var _buttonsPressed:Hash<Bool>;
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of touch events. */
	private var _handler:DisplayObject;
	
	
	public function new(handler:DisplayObject) {
		super();
		
		_buttonsPressed = new Hash<Bool>();
		_buttonsPressed.set("0:13", true);
		
		this._handler = handler;
		
		#if (cpp && !mobile)
		_handler.stage.addEventListener(nme.events.JoystickEvent.AXIS_MOVE, onAxisMove);
		_handler.stage.addEventListener(nme.events.JoystickEvent.BALL_MOVE, onBallMove);
		_handler.stage.addEventListener(nme.events.JoystickEvent.BUTTON_DOWN, onButtonDown);
		_handler.stage.addEventListener(nme.events.JoystickEvent.BUTTON_UP, onButtonUp);
		_handler.stage.addEventListener(nme.events.JoystickEvent.HAT_MOVE, onHatMove);
		#end
	}
	
	private function onAxisMove(e:nme.events.JoystickEvent) {
		updateEvent(e);
		this.dispatchEvent(new JoystickEvent(JoystickEvent.AXIS_MOVE, this));
	}
	
	private function onBallMove(e:nme.events.JoystickEvent) {
		updateEvent(e);
		this.dispatchEvent(new JoystickEvent(JoystickEvent.BALL_MOVE, this));
	}
	
	private function onButtonDown(e:nme.events.JoystickEvent) {
		updateEvent(e);
		_buttonsPressed.set(e.device + ":" + e.id, true);
		this.dispatchEvent(new JoystickEvent(JoystickEvent.BUTTON_DOWN, this));
	}
	
	private function onButtonUp(e:nme.events.JoystickEvent) {
		updateEvent(e);
		_buttonsPressed.set(e.device + ":" + e.id, false);
		this.dispatchEvent(new JoystickEvent(JoystickEvent.BUTTON_UP, this));
	}
	
	private function onHatMove(e:nme.events.JoystickEvent) {
		updateEvent(e);
		this.dispatchEvent(new JoystickEvent(JoystickEvent.HAT_MOVE, this));
	}
	
	private function updateEvent(e:nme.events.JoystickEvent) {
		this.id = e.id;
		this.deviceID = e.device;
		this.x = e.x;
		this.y = e.y;
		this.z = e.z;
	}
	
	public function isButtonPressed(deviceID:Int, buttonID:Int):Bool {
		return _buttonsPressed.get(e.device + ":" + e.id);
	}
}
