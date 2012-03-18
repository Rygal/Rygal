// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package rygal;
import nme.display.DisplayObject;
import nme.events.EventDispatcher;
import nme.events.KeyboardEvent;

/**
 * ...
 * @author Robert Böhm
 */

class RyKeyboard extends EventDispatcher {
	
	private var _keys:Array<Bool>;

	public function new(handler:DisplayObject) {
		super();
		
		_keys = new Array<Bool>();
		for (i in 0...256) {
			_keys.push(false);
		}
		
		handler.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		handler.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		var intKeyCode:Int = cast(e.keyCode, Int);
		
		if (intKeyCode >= 0 && intKeyCode < _keys.length) {
			var previous:Bool = _keys[intKeyCode];
			_keys[intKeyCode] = true;
			
			if (e.charCode != 0) {
				dispatchEvent(new RyKeyboardEvent(RyKeyboardEvent.CHAR_TYPED, this, intKeyCode, e.charCode));
			}
			if (!previous) {
				dispatchEvent(new RyKeyboardEvent(RyKeyboardEvent.KEY_DOWN, this, intKeyCode, e.charCode));
			}
		}
	}
	
	private function onKeyUp(e:KeyboardEvent):Void {
		var intKeyCode:Int = cast(e.keyCode, Int);
		
		if (intKeyCode >= 0 && intKeyCode < _keys.length) {
			var previous:Bool = _keys[intKeyCode];
			_keys[intKeyCode] = false;
			
			if (previous) {
				dispatchEvent(new RyKeyboardEvent(RyKeyboardEvent.KEY_UP, this, intKeyCode, e.charCode));
			}
		}
	}
	
	public function isKeyPressed(keyCode:Int):Bool {
		if (keyCode >= 0 && keyCode < _keys.length) {
			return _keys[keyCode];
		}
		
		return false;
	}
	
}