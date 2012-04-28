// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import nme.events.Event;

/**
 * ...
 * @author Robert Böhm
 */

class KeyboardEvent extends Event {
	
	public static var KEY_DOWN:String = "keyDown";
	public static var KEY_UP:String = "keyUp";
	public static var CHAR_TYPED:String = "charTyped";
	
	public var keyCode:Int;
	public var charCode:Int;
	public var charString:String;
	private var _keyboard:Keyboard;

	public function new(type:String, keyboard:Keyboard, keyCode:Int, charCode:Int) {
		super(type);
		
		this._keyboard = keyboard;
		this.keyCode = keyCode;
		this.charCode = charCode;
		if (charCode != 0) {
			this.charString = String.fromCharCode(charCode);
		} else {
			this.charString = "";
		}
	}
	
	public function isKeyPressed(keyCode:Int):Bool {
		return _keyboard.isKeyPressed(keyCode);
	}
	
}