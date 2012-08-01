// Copyright (C) 2012 Robert Böhm, Christopher Kaster
// This file is part of Rygal.
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
 * @author Christopher Kaster
 */
class Touch extends EventDispatcher {
	
	public var x:Float;
	public var y:Float;
	public var touchPointID:Int;
	public var isPrimaryTouchPoint:Bool;
	public var isMultiTouchEnabled:Bool;
	
	public var pressure:Float;
	
	private var handler:DisplayObject;
	
	public function new(handler:DisplayObject) {
		super();
		
		if(Multitouch.supportsTouchEvents) {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			isMultiTouchEnabled = true;
		} else {
			isMultiTouchEnabled = false;
		}
		
		this.handler = handler;
		
		#if !flash
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_BEGIN,
			onTouchBegin);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_MOVE,
			onTouchMove);
		handler.stage.addEventListener(nme.events.TouchEvent.TOUCH_BEGIN,
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
	
	private function onTouchBegin(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_BEGIN, this));
	}

	private function onTouchEnd(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_END, this));
	}
	
	private function onTouchMove(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_MOVE, this));
	}
	
	private function onTouchOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OVER, this));
	}

	private function onTouchOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OUT, this));
	}
	
	private function onTouchRollOver(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OVER, this));
	}
	
	private function onTouchRollOut(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OUT, this));
	}

	private function onTouchTap(e:nme.events.TouchEvent):Void {
		updateEvent(e);
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_TAP, this));
	}
	
	private function updateEvent(e:nme.events.TouchEvent):Void {
		this.x = e.localX;
		this.y = e.localY;
		
		// pressure seems not to work in NME 3.4
		this.pressure = 1.0;
		
		this.touchPointID = e.touchPointID;
		this.isPrimaryTouchPoint = e.isPrimaryTouchPoint;
	}
	
}
