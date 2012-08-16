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

import nme.display.DisplayObject;
import org.rygal.Game;

/**
 * <h2>Description</h2>
 * <p>
 * 	A device manager for joysticks.
 * </p>
 * 
 * @author Christopher Kaster
 */
class JoystickDeviceManager extends DeviceManager {
	
	/** The handler used to register events on. */
	private var _handler:DisplayObject;
	
	/**
	 * 
	 * @param	game	The game the joystick handler will be registered for.
	 */
	public function new(game:Game) {
		super(game);
		
		_handler = game.getDisplayObject().stage;
		
		#if (cpp && !mobile)
		_handler.addEventListener(nme.events.JoystickEvent.AXIS_MOVE, onAxisMove);
		_handler.addEventListener(nme.events.JoystickEvent.BALL_MOVE, onBallMove);
		_handler.addEventListener(nme.events.JoystickEvent.BUTTON_DOWN, onButtonDown);
		_handler.addEventListener(nme.events.JoystickEvent.BUTTON_UP, onButtonUp);
		_handler.addEventListener(nme.events.JoystickEvent.HAT_MOVE, onHatMove);
		#end
	}
	
	
	/**
	 * Registers this touch device manager on the Game-class so it'll be used on
	 * any games that will be created.
	 */
	public static function use():Void {
		Game.registerDeviceManager(JoystickDeviceManager);
	}
	
	override public function dispose():Void {
		super.dispose();
		
		#if (cpp && !mobile)
		_handler.removeEventListener(nme.events.JoystickEvent.AXIS_MOVE, onAxisMove);
		_handler.removeEventListener(nme.events.JoystickEvent.BALL_MOVE, onBallMove);
		_handler.removeEventListener(nme.events.JoystickEvent.BUTTON_DOWN, onButtonDown);
		_handler.removeEventListener(nme.events.JoystickEvent.BUTTON_UP, onButtonUp);
		_handler.removeEventListener(nme.events.JoystickEvent.HAT_MOVE, onHatMove);
		#end
	}
	
	#if !flash
	private function onAxisMove(e:nme.events.JoystickEvent) {
		isRegistered(e);
		updateEvent(e);
		
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		var je:JoystickEvent = new JoystickEvent(JoystickEvent.AXIS_MOVE, joystick);
		joystick.dispatchEvent(je);
		this.dispatchEvent(je);
	}
	
	private function onBallMove(e:nme.events.JoystickEvent) {
		isRegistered(e);
		updateEvent(e);
		
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		var je:JoystickEvent = new JoystickEvent(JoystickEvent.BALL_MOVE, joystick);
		joystick.dispatchEvent(je);
		this.dispatchEvent(je);
	}
	
	private function onButtonDown(e:nme.events.JoystickEvent) {
		isRegistered(e);
		updateEvent(e);
		
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		var je:JoystickEvent = new JoystickEvent(JoystickEvent.BUTTON_DOWN, joystick);
		
		joystick.setButtonState(je, true);
		
		joystick.dispatchEvent(je);
		this.dispatchEvent(je);
	}
	
	private function onButtonUp(e:nme.events.JoystickEvent) {
		isRegistered(e);
		updateEvent(e);
		
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		var je:JoystickEvent = new JoystickEvent(JoystickEvent.BUTTON_UP, joystick);
		
		joystick.setButtonState(je, false);
		
		joystick.dispatchEvent(je);
		this.dispatchEvent(je);
	}
	
	private function onHatMove(e:nme.events.JoystickEvent) {
		isRegistered(e);
		updateEvent(e);
		
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		var je:JoystickEvent = new JoystickEvent(JoystickEvent.HAT_MOVE, joystick);
		joystick.dispatchEvent(je);
		this.dispatchEvent(je);
	}
	
	private function updateEvent(e:nme.events.JoystickEvent):Void {
		var joystick:Joystick = game.getDevice(Joystick, e.device);
		
		joystick.updateFromEvent(e);
	}
	
	private function isRegistered(e:nme.events.JoystickEvent):Void {
		if(!game.hasDevice(Joystick, e.device)) {
			var j:Joystick = new Joystick(game, e.device);
			
			game.registerDevice(j, e.device);
		}
	}
	#end
	
}