// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.input;
import nme.ui.Keyboard;

/**
 * <h2>Description</h2>
 * <p>
 * 	A class with every key as a constant. You can use it to avoid magic numbers
 * 	for keycodes. It also provides helping methods that are related to keys.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	if (this.game.keyboard.isKeyPressed(Keys.SPACE)) {<br />
 * 	&nbsp;&nbsp;// Let the player jump<br />
 * 	}
 * </code>
 * 
 * <h2>Example <i>(Tracing a key's name)</i></h2>
 * <code>
 * 	// Prerequisite: The variable e contains a KeyboardEvent.<br />
 * 	trace("You pressed: " + Keys.getKeyName(e.keyCode));
 * </code>
 * 
 * @author Robert Böhm
 */
class Keys {
	
	public static var UNKNOWN:Int = 0;
	
	public static var ALTERNATE:Int = 18;
	public static var BACKQUOTE:Int = 192;
	public static var BACKSLASH:Int = 220;
	public static var BACKSPACE:Int = 8;
	public static var CAPS_LOCK:Int = 20;
	public static var COMMA:Int = 188;
	public static var COMMAND:Int = 15;
	public static var CONTROL:Int = 17;
	public static var DELETE:Int = 46;
	public static var DOWN:Int = 40;
	public static var END:Int = 35;
	public static var ENTER:Int = 13;
	public static var EQUAL:Int = 187;
	public static var ESCAPE:Int = 27;
	public static var F1:Int = 112;
	public static var F2:Int = 113;
	public static var F3:Int = 114;
	public static var F4:Int = 115;
	public static var F5:Int = 116;
	public static var F6:Int = 117;
	public static var F7:Int = 118;
	public static var F8:Int = 119;
	public static var F9:Int = 120;
	public static var F10:Int = 121;
	public static var F11:Int = 122;
	public static var F12:Int = 123;
	public static var F13:Int = 124;
	public static var F14:Int = 125;
	public static var F15:Int = 126;
	public static var HOME:Int = 36;
	public static var INSERT:Int = 45;
	public static var LEFT:Int = 37;
	public static var LEFTBRACKET:Int = 219;
	public static var MINUS:Int = 189;
	public static var NUMBER_0:Int = 48;
	public static var NUMBER_1:Int = 49;
	public static var NUMBER_2:Int = 50;
	public static var NUMBER_3:Int = 51;
	public static var NUMBER_4:Int = 52;
	public static var NUMBER_5:Int = 53;
	public static var NUMBER_6:Int = 54;
	public static var NUMBER_7:Int = 55;
	public static var NUMBER_8:Int = 56;
	public static var NUMBER_9:Int = 57;
	public static var NUMPAD:Int = 21;
	public static var NUMLOCK:Int = 144;
	public static var NUMPAD_0:Int = 96;
	public static var NUMPAD_1:Int = 97;
	public static var NUMPAD_2:Int = 98;
	public static var NUMPAD_3:Int = 99;
	public static var NUMPAD_4:Int = 100;
	public static var NUMPAD_5:Int = 101;
	public static var NUMPAD_6:Int = 102;
	public static var NUMPAD_7:Int = 103;
	public static var NUMPAD_8:Int = 104;
	public static var NUMPAD_9:Int = 105;
	public static var NUMPAD_ADD:Int = 107;
	public static var NUMPAD_DECIMAL:Int = 110;
	public static var NUMPAD_DIVIDE:Int = 111;
	public static var NUMPAD_ENTER:Int = 108;
	public static var NUMPAD_MULTIPLY:Int = 106;
	public static var NUMPAD_SUBTRACT:Int = 109;
	public static var PAGE_DOWN:Int = 34;
	public static var PAGE_UP:Int = 33;
	public static var PERIOD:Int = 190;
	public static var QUOTE:Int = 222;
	public static var RIGHT:Int = 39;
	public static var RIGHTBRACKET:Int = 221;
	public static var SEMICOLON:Int = 186;
	public static var SHIFT:Int = 16;
	public static var SLASH:Int = 191;
	public static var SPACE:Int = 32;
	public static var TAB:Int = 9;
	public static var UP:Int = 38;
	
	// A-Z
	public static var A:Int = getLetterKeyCode("A");
	public static var B:Int = getLetterKeyCode("B");
	public static var C:Int = getLetterKeyCode("C");
	public static var D:Int = getLetterKeyCode("D");
	public static var E:Int = getLetterKeyCode("E");
	public static var F:Int = getLetterKeyCode("F");
	public static var G:Int = getLetterKeyCode("G");
	public static var H:Int = getLetterKeyCode("H");
	public static var I:Int = getLetterKeyCode("I");
	public static var J:Int = getLetterKeyCode("J");
	public static var K:Int = getLetterKeyCode("K");
	public static var L:Int = getLetterKeyCode("L");
	public static var M:Int = getLetterKeyCode("M");
	public static var N:Int = getLetterKeyCode("N");
	public static var O:Int = getLetterKeyCode("O");
	public static var P:Int = getLetterKeyCode("P");
	public static var Q:Int = getLetterKeyCode("Q");
	public static var R:Int = getLetterKeyCode("R");
	public static var S:Int = getLetterKeyCode("S");
	public static var T:Int = getLetterKeyCode("T");
	public static var U:Int = getLetterKeyCode("U");
	public static var V:Int = getLetterKeyCode("V");
	public static var W:Int = getLetterKeyCode("W");
	public static var X:Int = getLetterKeyCode("X");
	public static var Y:Int = getLetterKeyCode("Y");
	public static var Z:Int = getLetterKeyCode("Z");
	
	
	/**
	 * You shouldn't create an instance of Keys.
	 */
	private function new() {}
	
	/**
	 * Used to get the keycode of a letter. This is due to the fact that some
	 * platforms are using different keycodes for letters than others.
	 * 
	 * @param	letter	The letter whose keycode you need.
	 * @return	The keycode of the given letter.
	 */
	private static function getLetterKeyCode(letter:String):Int {
		#if cpp
		return letter.toLowerCase().charCodeAt(0);
		#else
		return letter.toUpperCase().charCodeAt(0);
		#end
	}
	
	/**
	 * Returns a readable name for the given keycode. You can use getKeyCode to
	 * revert the process.
	 * 
	 * @param	keyCode	The keycode whose string representation you want.
	 * @return	The string representation of the given keycode.
	 */
	public static function getKeyName(keyCode:Int):String {
		return switch(keyCode) {
			case ALTERNATE: "Alternate";
			case BACKQUOTE: "Backquote";
			case BACKSLASH: "Backslash";
			case BACKSPACE: "Backspace";
			case CAPS_LOCK: "Capslock";
			case COMMA: "Comma";
			case COMMAND: "Command";
			case CONTROL: "Control";
			case DELETE: "Delete";
			case DOWN: "Down arrow";
			case END: "End";
			case ENTER: "Enter";
			case EQUAL: "Equal";
			case ESCAPE: "Escape";
			case F1: "F1";
			case F2: "F2";
			case F3: "F3";
			case F4: "F4";
			case F5: "F5";
			case F6: "F6";
			case F7: "F7";
			case F8: "F8";
			case F9: "F9";
			case F10: "F10";
			case F11: "F11";
			case F12: "F12";
			case F13: "F13";
			case F14: "F14";
			case F15: "F15";
			case HOME: "Home";
			case INSERT: "Insert";
			case LEFT: "Left arrow";
			case LEFTBRACKET: "Left bracket";
			case MINUS: "Minus";
			case NUMBER_0: "Number 0";
			case NUMBER_1: "Number 1";
			case NUMBER_2: "Number 2";
			case NUMBER_3: "Number 3";
			case NUMBER_4: "Number 4";
			case NUMBER_5: "Number 5";
			case NUMBER_6: "Number 6";
			case NUMBER_7: "Number 7";
			case NUMBER_8: "Number 8";
			case NUMBER_9: "Number 9";
			case NUMLOCK: "Numlock";
			case NUMPAD: "Numpad";
			case NUMPAD_0: "Numpad 0";
			case NUMPAD_1: "Numpad 1";
			case NUMPAD_2: "Numpad 2";
			case NUMPAD_3: "Numpad 3";
			case NUMPAD_4: "Numpad 4";
			case NUMPAD_5: "Numpad 5";
			case NUMPAD_6: "Numpad 6";
			case NUMPAD_7: "Numpad 7";
			case NUMPAD_8: "Numpad 8";
			case NUMPAD_9: "Numpad 9";
			case NUMPAD_ADD: "Numpad Add";
			case NUMPAD_DECIMAL: "Numpad Decimal";
			case NUMPAD_DIVIDE: "Numpad Divide";
			case NUMPAD_ENTER: "Numpad Enter";
			case NUMPAD_MULTIPLY: "Numpad Multiply";
			case NUMPAD_SUBTRACT: "Numpad Subtract";
			case PAGE_DOWN: "Page Down";
			case PAGE_UP: "Page Up";
			case PERIOD: "Period";
			case QUOTE: "Quote";
			case RIGHT: "Right arrow";
			case RIGHTBRACKET: "Right Bracket";
			case SEMICOLON: "Semicolon";
			case SHIFT: "Shift";
			case SLASH: "Slash";
			case SPACE: "Space";
			case TAB: "Tab";
			case UP: "Up arrow";
			
			case A: "A";
			case B: "B";
			case C: "C";
			case D: "D";
			case E: "E";
			case F: "F";
			case G: "G";
			case H: "H";
			case I: "I";
			case J: "J";
			case K: "K";
			case L: "L";
			case M: "M";
			case N: "N";
			case O: "O";
			case P: "P";
			case Q: "Q";
			case R: "R";
			case S: "S";
			case T: "T";
			case U: "U";
			case V: "V";
			case W: "W";
			case X: "X";
			case Y: "Y";
			case Z: "Z";
			
			default: "Unknown";
		};
	}
	
	/**
	 * Returns a keycode for the given string representation. You can use
	 * getKeyName to revert the process.
	 * 
	 * @param	keyName	The string representation of the keycode you want.
	 * @return	The keycode of the key with the given name.
	 */
	public static function getKeyCode(keyName:String):Int {
		return switch(keyName) {
			case "Alternate": ALTERNATE;
			case "Backquote": BACKQUOTE;
			case "Backslash": BACKSLASH;
			case "Backspace": BACKSPACE;
			case "Capslock": CAPS_LOCK;
			case "Comma": COMMA;
			case "Command": COMMAND;
			case "Control": CONTROL;
			case "Delete": DELETE;
			case "Down arrow": DOWN;
			case "End": END;
			case "Enter": ENTER;
			case "Equal": EQUAL;
			case "Escape": ESCAPE;
			case "F1": F1;
			case "F2": F2;
			case "F3": F3;
			case "F4": F4;
			case "F5": F5;
			case "F6": F6;
			case "F7": F7;
			case "F8": F8;
			case "F9": F9;
			case "F10": F10;
			case "F11": F11;
			case "F12": F12;
			case "F13": F13;
			case "F14": F14;
			case "F15": F15;
			case "Home": HOME;
			case "Insert": INSERT;
			case "Left arrow": LEFT;
			case "Left bracket": LEFTBRACKET;
			case "Minus": MINUS;
			case "Number 0": NUMBER_0;
			case "Number 1": NUMBER_1;
			case "Number 2": NUMBER_2;
			case "Number 3": NUMBER_3;
			case "Number 4": NUMBER_4;
			case "Number 5": NUMBER_5;
			case "Number 6": NUMBER_6;
			case "Number 7": NUMBER_7;
			case "Number 8": NUMBER_8;
			case "Number 9": NUMBER_9;
			case "Numlock": NUMLOCK;
			case "Numpad": NUMPAD;
			case "Numpad 0": NUMPAD_0;
			case "Numpad 1": NUMPAD_1;
			case "Numpad 2": NUMPAD_2;
			case "Numpad 3": NUMPAD_3;
			case "Numpad 4": NUMPAD_4;
			case "Numpad 5": NUMPAD_5;
			case "Numpad 6": NUMPAD_6;
			case "Numpad 7": NUMPAD_7;
			case "Numpad 8": NUMPAD_8;
			case "Numpad 9": NUMPAD_9;
			case "Numpad Add": NUMPAD_ADD;
			case "Numpad Decimal": NUMPAD_DECIMAL;
			case "Numpad Divide": NUMPAD_DIVIDE;
			case "Numpad Enter": NUMPAD_ENTER;
			case "Numpad Multiply": NUMPAD_MULTIPLY;
			case "Numpad Subtract": NUMPAD_SUBTRACT;
			case "Page Down": PAGE_DOWN;
			case "Page Up": PAGE_UP;
			case "Period": PERIOD;
			case "Quote": QUOTE;
			case "Right arrow": RIGHT;
			case "Right Bracket": RIGHTBRACKET;
			case "Semicolon": SEMICOLON;
			case "Shift": SHIFT;
			case "Slash": SLASH;
			case "Space": SPACE;
			case "Tab": TAB;
			case "Up arrow": UP;
			
			case "A": A;
			case "B": B;
			case "C": C;
			case "D": D;
			case "E": E;
			case "F": F;
			case "G": G;
			case "H": H;
			case "I": I;
			case "J": J;
			case "K": K;
			case "L": L;
			case "M": M;
			case "N": N;
			case "O": O;
			case "P": P;
			case "Q": Q;
			case "R": R;
			case "S": S;
			case "T": T;
			case "U": U;
			case "V": V;
			case "W": W;
			case "X": X;
			case "Y": Y;
			case "Z": Z;
			
			default: UNKNOWN;
		};
	}
	
}