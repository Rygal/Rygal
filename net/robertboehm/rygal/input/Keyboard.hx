// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import nme.display.DisplayObject;
import nme.events.EventDispatcher;

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
class Keyboard extends EventDispatcher {
	
	/** An array with all key states. */
	private var _keys:Array<Bool>;

	
	/**
	 * Creates a new Keyboard-object for the given DisplayObject.
	 * 
	 * @param	handler	The DisplayObject this keyboard will be created for.
	 */
	public function new(handler:DisplayObject) {
		super();
		
		_keys = new Array<Bool>();
		for (i in 0...256) {
			_keys.push(false);
		}
		
		handler.stage.addEventListener(nme.events.KeyboardEvent.KEY_DOWN,
			onKeyDown);
		handler.stage.addEventListener(nme.events.KeyboardEvent.KEY_UP,
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
	
	/**
	 * A callback that will be called whenever a key is pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onKeyDown(e:nme.events.KeyboardEvent):Void {
		var intKeyCode:Int = cast(e.keyCode, Int);
		
		if (intKeyCode >= 0 && intKeyCode < _keys.length) {
			var previous:Bool = _keys[intKeyCode];
			_keys[intKeyCode] = true;
			
			if (e.charCode != 0) {
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