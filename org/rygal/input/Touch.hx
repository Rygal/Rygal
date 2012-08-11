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
import nme.display.DisplayObject;
import nme.events.EventDispatcher;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;

/**
 * <h2>Description</h2>
 * <p>
 * 	The touch surface. It will automatically be created by the Game-class.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	if (game.touch.x >= enemy.x && game.touch.x <= enemy.width) {<br />
 * 	&nbsp;&nbsp;// touch point is under or above the enemy<br />
 * 	}
 * </code>
 * 
 * @author Christopher Kaster
 */
class Touch extends InputDevice {
	
	/** The x-coordinate of the touch pointer. */
	public var x(default, null):Float;
	
	/** The y-coordinate of the touch pointer. */
	public var y(default, null):Float;
	
	/** Determines the ID of the touch pointer. */
	public var touchPointID(default, null):Int;
	
	/** Determines if this is the primary touch point, in other words when
	 * 	multiple touches occur, only the first one is the primary one. */
	public var isPrimaryTouchPoint(default, null):Bool;
	
	/** Determines if multi-touch is enabled. */
	public var isMultiTouchEnabled(default, null):Bool;
	
	/** The pressure on the touch pointer. */
	public var pressure(default, null):Float;
	
	
	/** The handler used to register events on. Is also used to determine the
	 * 	relative coordinates of touch events. */
	private var _handler:DisplayObject;
	
	
	/**
	 * Creates a new touch surface for the given DisplayObject.
	 * 
	 * @param	handler	The DisplayObject this touch pointer will be created
	 * 					for.
	 */
	public function new(game:Game) {
		super();
		
		var handler:DisplayObject = game.getDisplayObject();
		
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
		
		this._handler = handler;
		
		#if !flash
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_BEGIN,
			onTouchBegin);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_MOVE,
			onTouchMove);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_END,
			onTouchEnd);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_OVER,
			onTouchOver);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_OUT,
			onTouchOut);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_ROLL_OVER,
			onTouchRollOver);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_ROLL_OUT,
			onTouchRollOut);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_TAP,
			onTouchTap);
		#end
	}
	
	
	/**
	 * A callback that will be called whenever a touch starts.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchBegin(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_BEGIN, this));
	}
	
	/**
	 * A callback that will be called whenever a touch ends.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchEnd(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_END, this));
	}
	
	/**
	 * A callback that will be called whenever the touch pointer is moved.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchMove(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_MOVE, this));
	}
	
	/**
	 * A callback that will be called whenever the touch pointer is moved
	 * inside the game.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OVER, this));
	}

	/**
	 * A callback that will be called whenever the touch pointer is moved
	 * out of the game.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OUT, this));
	}
	
	/**
	 * A callback that will be called whenever, well, just have a look at:
	 * TouchEvent.TOUCH_ROLL_OVER
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchRollOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OVER, this));
	}
	
	/**
	 * A callback that will be called whenever the opposite of the event that
	 * raises onTouchRollOver occurs.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchRollOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OUT, this));
	}
	
	/**
	 * A callback that will be called whenever the user touched the screen
	 * without moving the pointer.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onTouchTap(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_TAP, this));
	}
	
	/**
	 * Updates the touch pointer's coordinates and other attributes.
	 * 
	 * @param	e	Event parameters used to obtain the new values.
	 */
	private function updateEvent(e:nme.events.TouchEvent):Void {
		this.x = e.localX;
		this.y = e.localY;
		
		// pressure seems not to work in NME 3.4
		this.pressure = 1.0;
		
		this.touchPointID = e.touchPointID;
		this.isPrimaryTouchPoint = e.isPrimaryTouchPoint;
	}
	
}
