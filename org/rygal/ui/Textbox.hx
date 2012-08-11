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


package org.rygal.ui;

import org.rygal.BasicGameObject;
import org.rygal.Game;
import org.rygal.GameTime;
import org.rygal.graphic.BitmapFont;
import org.rygal.graphic.Canvas;
import org.rygal.graphic.Color;
import org.rygal.graphic.Font;
import org.rygal.input.KeyboardEvent;
import org.rygal.input.Keys;
import org.rygal.input.MouseEvent;
import org.rygal.physics.Rectangle;

/**
 * <h2>Description</h2>
 * <p>
 * 	A textbox that can be used to receive user input.<br />
 * 	<b>IMPORTANT:</b> You have to call the method dispose() of a textbox prior
 * 	to removing it from the game, else it will still react to mouse clicks!
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	private var textbox:Textbox;<br />
 * 	<br />
 * 	override public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;this.textbox = new Textbox(game, 60, 12, font);<br />
 * 	&nbsp;&nbsp;this.addChild(this.textbox);<br />
 * 	}<br />
 * 	<br />
 * 	override public function unload():Void {<br />
 * 	&nbsp;&nbsp;super.unload();<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;this.textbox.dispose(); // Important!<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Textbox extends BasicGameObject {
	
	/** The delay for the caret blinking. */
	private static inline var CARET_BLINKING_DELAY:Int = 650;
	
	
	/** The width of this textbox. */
	public var width(getWidth, setWidth):Float;
	
	/** The height of this textbox. */
	public var height(getHeight, setHeight):Float;
	
	/** The bounding box of this textbox. */
	public var bounds(getBounds, never):Rectangle;
	
	/** The bounding box of this textbox. (Absolute coordinates) */
	public var absoluteBounds(getAbsoluteBounds, never):Rectangle;
	
	/** The font for the text of this textbox. */
	public var font(getFont, setFont):Font;
	
	/** The text of this textbox. */
	public var text(getText, setText):String;
	
	/** The color for the text of the textbox. */
	public var foregroundColor:Int;
	
	/** The color of the textbox. */
	public var backgroundColor:Int;
	
	/** Determines if this textbox is focused. */
	public var focused:Bool;
	
	/** The position of the caret. */
	public var caretPosition(getCaretPosition, setCaretPosition):Int;
	
	
	/** The drawing offset. */
	private var _offset:Float;
	
	/** The position of the caret. */
	private var _caretPosition:Int;
	
	/** Determines if the caret is currently visible. */
	private var _caretVisible:Bool;
	
	/** The time until the next blink of the caret. */
	private var _nextCaretBlink:Int;
	
	/** The metrics of this textbox. */
	private var _metrics:Rectangle;
	
	/** The game this textbox belongs to. */
	private var _game:Game;
	
	/** The label used to display the text of this textbox. */
	private var _label:Label;
	
	/** Determines if the mouse was pressed down in this textbox. */
	private var _mouseDown:Bool;
	
	
	/**
	 * Creates a new textbox with the given attributes.
	 * 
	 * @param	game			The game this textbox belongs to.
	 * @param	width			The width of this textbox.
	 * @param	height			The height of this textbox.
	 * @param	font			The font for the text of this textbox.
	 * @param	foregroundColor	The foreground color of this textbox.
	 * @param	backgroundColor	The background color of this textbox.
	 * @param	defaultText		The default text of this textbox.
	 * @param	x				The x-coordinate of this textbox.
	 * @param	y				The y-coordinate of this textbox.
	 */
	public function new(game:Game, width:Float, height:Float, font:Font,
			defaultText:String = "", foregroundColor:Int = Color.BLACK,
			backgroundColor:Int = Color.WHITE, x:Float = 0, y:Float = 0) {
		
		super(x, y);
		
		this.foregroundColor = foregroundColor | 0xFF000000;
		this.backgroundColor = backgroundColor | 0xFF000000;
		
		this._caretPosition = 0;
		this._offset = 0;
		
		this._game = game;
		
		this._metrics = new Rectangle(0, 0, width, height);
		
		this._label = new Label(font, defaultText, Font.LEFT,
			foregroundColor, 1, 0, 0);
		
		this._game.mouse.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		this._game.mouse.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		this._game.keyboard.addEventListener(KeyboardEvent.KEY_TYPED,
			onKeyTyped);
		this._game.keyboard.addEventListener(KeyboardEvent.CHAR_TYPED,
			onCharTyped);
	}
	
	
	/**
	 * Removes any event listeners registered by this textbox.
	 */
	public function dispose():Void {
		this._game.mouse.removeEventListener(MouseEvent.MOUSE_UP,
			onMouseUp);
		this._game.mouse.removeEventListener(MouseEvent.MOUSE_DOWN,
			onMouseDown);
		this._game.keyboard.removeEventListener(KeyboardEvent.KEY_TYPED,
			onKeyTyped);
		this._game.keyboard.removeEventListener(KeyboardEvent.CHAR_TYPED,
			onCharTyped);
		
	}
	
	/**
	 * Updates this textbox. (Used for caret blinking and mouse selection)
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	override public function update(time:GameTime):Void {
		super.update(time);
		
		if (this.focused) {
			this._nextCaretBlink -= time.elapsedMs;
			if (this._nextCaretBlink < 0) {
				this._caretVisible = !this._caretVisible;
				this._nextCaretBlink = CARET_BLINKING_DELAY;
			}
		}
		
		if (_mouseDown) {
			resetCaretBlinking();
			var mouseX:Int = this._game.mouse.x - Std.int(this.getAbsoluteX());
			if (mouseX < 0) {
				caretPosition--;
			} else if (mouseX > this.width) {
				caretPosition++;
			} else {
				mouseX += Std.int(_offset);
				var i:Int = 0;
				while (mouseX > font.getTextMetrics(text.substr(0, i)).width) {
					if (i++ >= text.length)
						break;
				}
				caretPosition = i - 1;
			}
		}
	}
	
	/**
	 * Draws this textbox on the given screen.
	 * 
	 * @param	screen	The screen this textbox should be drawn to.
	 */
	override public function draw(screen:Canvas):Void {
		super.draw(screen);
		
		this._label.color = foregroundColor;
		
		var previousX:Float = font.getTextMetrics(this.text.substr(0,
			Std.int(Math.max(0, caretPosition - 1)))).width + 1;
		
		var caretX:Float =
			font.getTextMetrics(this.text.substr(0, caretPosition)).width + 1;
		
		var nextX:Float = font.getTextMetrics(this.text.substr(0,
			Std.int(Math.min(text.length, caretPosition + 1)))).width + 1;
		
		if (previousX - 1 <= _offset) {
			_offset = previousX;
		} else if (nextX > _offset + width - 3) {
			_offset = nextX - width + 3;
		}
		
		screen.push();
		screen.translate(x, y);
		
		screen.fillRect(backgroundColor, 0, 0, width, height);
		
		screen.translate(1 - _offset, 0);
		this._label.drawClipped(screen,
			new Rectangle(0 + _offset, 0, width - 2, height));
		
		if (this.focused && this._caretVisible) {
			screen.fillRect(foregroundColor, caretX, 1, 1, height - 2);
		}
		
		screen.pop();
	}
	
	
	/**
	 * Resets the caret blinking timer.
	 */
	private function resetCaretBlinking():Void {
		_caretVisible = true;
		_nextCaretBlink = CARET_BLINKING_DELAY;
	}
	
	/**
	 * Will be called when the left mouse button is pressed down.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onMouseDown(e:MouseEvent):Void {
		if (this.absoluteBounds.contains(e.x, e.y)) {
			_mouseDown = true;
			focused = true;
			resetCaretBlinking();
		} else {
			_mouseDown = false;
			focused = false;
		}
	}
	
	/**
	 * Will be called when the left mouse button is released.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onMouseUp(e:MouseEvent):Void {
		_mouseDown = false;
	}
	
	/**
	 * Will be called when a key is typed.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onKeyTyped(e:KeyboardEvent):Void {
		if (this.focused) {
			if (e.keyCode == Keys.LEFT) {
				caretPosition--;
				resetCaretBlinking();
			} else if (e.keyCode == Keys.RIGHT) {
				caretPosition++;
				resetCaretBlinking();
			}
		}
	}
	
	/**
	 * Will be called when a character is typed.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onCharTyped(e:KeyboardEvent):Void {
		if (this.focused) {
			if (e.keyCode == Keys.BACKSPACE) {
				resetCaretBlinking();
				
				if (this.caretPosition == this.text.length) {
					this.text = this.text.substr(0, caretPosition - 1);
				} else if (this.caretPosition > 0) {
					this.text = this.text.substr(0, caretPosition - 1) +
						this.text.substr(caretPosition);
					caretPosition--;
				}
			} else if (e.keyCode == Keys.DELETE) {
				resetCaretBlinking();
				
				if (this.caretPosition < this.text.length) {
					this.text = this.text.substr(0, caretPosition) +
						this.text.substr(caretPosition + 1);
				}
			} else if (e.keyCode != Keys.RETURN &&
					e.keyCode != Keys.NUMPAD_ENTER) {
				
				resetCaretBlinking();
				
				if (e.charString != " " && Std.is(font, BitmapFont)) {
					var bitmapFont:BitmapFont = cast(font, BitmapFont);
					if (!bitmapFont.hasCharacterTexture(e.charString)) {
						return;
					}
				}
				this.text = this.text.substr(0, caretPosition) + e.charString +
					this.text.substr(caretPosition);
				caretPosition++;
			}
		}
	}
	
	/**
	 * Returns the font used for the text of this textbox.
	 * 
	 * @return	The font used for the text of this textbox.
	 */
	private function getFont():Font {
		return this._label.font;
	}
	
	/**
	 * Defines the font used for the text of this textbox.
	 * 
	 * @param	font	The font used for the text of this textbox.
	 * @return	The new font.
	 */
	private function setFont(font:Font):Font {
		return this._label.font = font;
	}
	
	/**
	 * Returns the text of this textbox.
	 * 
	 * @return	The text of this textbox.
	 */
	private function getText():String {
		return this._label.text;
	}
	
	/**
	 * Defines the text of this textbox.
	 * 
	 * @param	text	The text of this textbox.
	 * @return	The new text.
	 */
	private function setText(text:String):String {
		return this._label.text = text;
	}
	
	/**
	 * Returns the width of this textbox.
	 * 
	 * @return	The width of this textbox.
	 */
	private function getWidth():Float {
		return this._metrics.width;
	}
	
	/**
	 * Defines the width of this textbox.
	 * 
	 * @param	width	The width of this textbox.
	 * @return	The new width.
	 */
	private function setWidth(width:Float):Float {
		this._metrics = new Rectangle(0, 0, width, this._metrics.height);
		return this._metrics.width;
	}
	
	/**
	 * Returns the height of this textbox.
	 * 
	 * @return	The height of this textbox.
	 */
	private function getHeight():Float {
		return this._metrics.height;
	}
	
	/**
	 * Defines the height of this textbox.
	 * 
	 * @param	height	The height of this textbox.
	 * @return	The new height.
	 */
	private function setHeight(height:Float):Float {
		this._metrics = new Rectangle(0, 0, this._metrics.width, height);
		return this._metrics.height;
	}
	
	/**
	 * Returns the bounding box of this textbox.
	 * 
	 * @return	The bounding box of this textbox.
	 */
	private function getBounds():Rectangle {
		return new Rectangle(this.x, this.y, this.width, this.height);
	}
	
	/**
	 * Returns the absolute bounding box of this textbox.
	 * 
	 * @return	The bounding box of this textbox. (Absolute coordinates)
	 */
	private function getAbsoluteBounds():Rectangle {
		return new Rectangle(this.getAbsoluteX(), this.getAbsoluteY(),
			this.width, this.height);
	}
	
	/**
	 * Returns the caret position.
	 * 
	 * @return	The caret position.
	 */
	private function getCaretPosition():Int {
		if (this._caretPosition > text.length) {
			this._caretPosition = text.length;
		}
		return this._caretPosition;
	}
	
	/**
	 * Defines the caret position.
	 * 
	 * @param	font	The caret position.
	 * @return	The new caret position.
	 */
	private function setCaretPosition(caretPosition:Int):Int {
		return this._caretPosition =
			Std.int(Math.max(0, Math.min(caretPosition, text.length)));
	}
	
}