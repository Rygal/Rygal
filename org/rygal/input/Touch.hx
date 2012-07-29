// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.input;

import org.rygal.Game;
import nme.display.DisplayObject;
import nme.events.EventDispatcher;

/**
 * @author Christopher Kaster
 */
class Touch extends EventDispatcher {
	
	public var x:Float;
	public var y:Float;
	public var isPressed:Bool;
	
	public function new() {
		super();
		isPressed = false;
	}
	
	private function onTouchEnter(e:nme.events.TouchEvent):Void {
		isPressed = true;
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_BEGIN, this));
	}

	private function onTouchLeave(e:nme.events.TouchEvent):Void {
		isPressed = false;
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_END, this));
	}
	
	private function onTouchMove(e:nme.events.TouchEvent):Void {
		this.x = e.localX;
		this.y = e.localY;
		this.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_MOVE, this));
	}
	
}
