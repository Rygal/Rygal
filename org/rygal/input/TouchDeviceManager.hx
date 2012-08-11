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
import org.rygal.Game;

/**
 * <h2>Description</h2>
 * <p>
 * 	A device manager for touches.
 * </p>
 * 
 * @author Robert Böhm
 */
class TouchDeviceManager extends DeviceManager {
	
	/** Determines if multi-touch is enabled. */
	public var isMultiTouchEnabled(default, null):Bool;
	
	/** The primary touch of this surface. */
	public var primaryTouch(default, null):Touch;
	
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of touch events. */
	private var _handler:DisplayObject;
	
	
	/**
	 * Creates a new touch device manager for the given game.
	 * 
	 * @param	game	The game the touch handler will be registered for.
	 */
	public function new(game:Game) {
		super(game);
		
		#if (!flash || flash10_1)
		if(Multitouch.supportsTouchEvents) {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			isMultiTouchEnabled = true;
		} else {
			isMultiTouchEnabled = false;
		}
		#else
		isMultiTouchEnabled = false;
		#end
		
		var handler:DisplayObject = game.getDisplayObject().stage;
		
		#if !flash
		handler.addEventListener(nme.events.TouchEvent.TOUCH_BEGIN,
			onTouchBegin);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_MOVE,
			onTouchMove);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_END,
			onTouchEnd);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_OVER,
			onTouchOver);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_OUT,
			onTouchOut);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_ROLL_OVER,
			onTouchRollOver);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_ROLL_OUT,
			onTouchRollOut);
		handler.addEventListener(nme.events.TouchEvent.TOUCH_TAP,
			onTouchTap);
		#end
	}
	
	
	/**
	 * Registers this touch device manager on the Game-class so it'll be used on
	 * any games that will be created.
	 */
	public static function use():Void {
		Game.registerDeviceManager(TouchDeviceManager);
	}
	
	override public function dispose():Void {
		super.dispose();
		
		#if !flash
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_BEGIN,
			onTouchBegin);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_MOVE,
			onTouchMove);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_END,
			onTouchEnd);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_OVER,
			onTouchOver);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_OUT,
			onTouchOut);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_ROLL_OVER,
			onTouchRollOver);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_ROLL_OUT,
			onTouchRollOut);
		handler.removeEventListener(nme.events.TouchEvent.TOUCH_TAP,
			onTouchTap);
		#end
	}
	
	
	/**
	 * A callback that will be called whenever a touch starts.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchBegin(e:nme.events.TouchEvent):Void {
		var t:Touch = new Touch(game, e.touchPointID);
		game.registerDevice(t, e.touchPointID);
		
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_BEGIN, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * A callback that will be called whenever a touch ends.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchEnd(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_END, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
		
		if (touch == primaryTouch) {
			primaryTouch = null;
		}
		
		touch.dispose();
		game.unregisterDevice(Touch, e.touchPointID);
	}
	
	/**
	 * A callback that will be called whenever the touch pointer is moved.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchMove(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_MOVE, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * A callback that will be called whenever the touch pointer is moved
	 * inside the game.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_OVER, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}

	/**
	 * A callback that will be called whenever the touch pointer is moved
	 * out of the game.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_OUT, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * A callback that will be called whenever, well, just have a look at:
	 * TouchEvent.TOUCH_ROLL_OVER
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchRollOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_ROLL_OVER, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * A callback that will be called whenever the opposite of the event that
	 * raises onTouchRollOver occurs.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchRollOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_ROLL_OUT, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * A callback that will be called whenever the user touched the screen
	 * without moving the pointer.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchTap(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		var te:TouchEvent = new TouchEvent(TouchEvent.TOUCH_TAP, touch);
		touch.dispatchEvent(te);
		this.dispatchEvent(te);
	}
	
	/**
	 * Updates the touch pointer's coordinates and other attributes.
	 * 
	 * @param	e	Event parameters used to obtain the new values.
	 */
	private function updateEvent(e:nme.events.TouchEvent):Void {
		var touch:Touch = game.getInput(Touch, e.touchPointID);
		
		touch.updateFromEvent(e);
		
		if (touch.isPrimaryTouchPoint) {
			this.primaryTouch = touch;
		}
	}
	
}