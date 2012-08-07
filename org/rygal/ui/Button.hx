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
import nme.events.Event;
import nme.events.IEventDispatcher;
import org.rygal.BasicGameObject;
import org.rygal.Game;
import org.rygal.graphic.Canvas;
import org.rygal.graphic.Font;
import org.rygal.input.MouseEvent;
import org.rygal.physics.Rectangle;

/**
 * <h2>Description</h2>
 * <p>
 * 	A simple button that reacts on mouse clicks.<br />
 * 	<b>IMPORTANT:</b> You have to call the method dispose() of a button prior
 * 	to removing it from the game, else it will still react to mouse clicks!
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	private var button:Button;<br />
 * 	<br />
 * 	override public function load(game:Game):Void {<br />
 * 	&nbsp;&nbsp;super.load(game);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;this.button = new Button(game, 52, 12, font, "Press me!",<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;0x333333, 0xCCCCCC, 0x555555, 0xEEEEEE,<br />
 * 	&nbsp;&nbsp;&nbsp;&nbsp;0x111111, 0xAAAAAA);<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;this.addChild(this.button);<br />
 * 	}<br />
 * 	<br />
 * 	override public function unload():Void {<br />
 * 	&nbsp;&nbsp;super.unload();<br />
 * 	&nbsp;&nbsp;<br />
 * 	&nbsp;&nbsp;this.button.dispose(); // Important!<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Button extends BasicGameObject {
	
	/** The width of this button. */
	public var width(getWidth, setWidth):Float;
	
	/** The height of this button. */
	public var height(getHeight, setHeight):Float;
	
	/** The bounding box of this button. */
	public var bounds(getBounds, never):Rectangle;
	
	/** The bounding box of this button. (Absolute coordinates) */
	public var absoluteBounds(getAbsoluteBounds, never):Rectangle;
	
	/** The font for the caption of this button. */
	public var font(getFont, setFont):Font;
	
	/** The caption of this button. */
	public var text(getText, setText):String;
	
	/** The color for the caption of this button. */
	public var textColor:Int;
	
	/** The color for the caption of this button when this button is
	 * 	hovered. */
	public var hoverTextColor:Int;
	
	/** The color for the caption of this button when this button is active. */
	public var activeTextColor:Int;
	
	/** The background color of this button. */
	public var color:Int;
	
	/** The background color of this button when this button is hovered. */
	public var hoverColor:Int;
	
	/** The background color of this button when this button is active. */
	public var activeColor:Int;
	
	
	/** The metrics of this button. */
	private var _metrics:Rectangle;
	
	/** The game this button belongs to. */
	private var _game:Game;
	
	/** The label used to display the caption of this button. */
	private var _label:Label;
	
	/** Determines if the mouse was pressed down on this button. */
	private var _mouseDown:Bool;

	
	/**
	 * Creates a new button with the given properties.
	 * 
	 * @param	game			The game this button belongs to.
	 * @param	width			The width of this button.
	 * @param	height			The height of this button.
	 * @param	font			The font used for the caption of this button.
	 * @param	caption			The caption of this button.
	 * @param	textColor		The color for the caption of this button.
	 * @param	color			The background color of this button.
	 * @param	hoverTextColor	The color for the caption of this button when
	 * 							this button is hovered.
	 * @param	hoverColor		The background color of this button when this
	 * 							button is hovered.
	 * @param	activeTextColor	The color for the caption of this button when
	 * 							this button is active.
	 * @param	activeColor		The background color of this button when this
	 * 							button is active.
	 * @param	x				The x-coordinate of this button.
	 * @param	y				The y-coordinate of this button.
	 */
	public function new(game:Game, width:Float, height:Float, font:Font,
			caption:String, textColor:Int, color:Int, hoverTextColor:Int, hoverColor:Int, activeTextColor:Int, activeColor:Int, x:Float = 0,
			y:Float = 0) {
		
		super(x, y);
		
		this.color = color | 0xFF000000;
		this.hoverColor = hoverColor | 0xFF000000;
		this.activeColor = activeColor | 0xFF000000;
		
		this.textColor = textColor;
		this.hoverTextColor = hoverTextColor;
		this.activeTextColor = activeTextColor;
		
		this._game = game;
		
		this._metrics = new Rectangle(0, 0, width, height);
		
		this._label = new Label(font, caption, Font.CENTER, textColor, 1,
			this.width / 2, 0);
		
		this._game.mouse.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		this._game.mouse.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	
	/**
	 * Removes any event listeners registered by this button.
	 */
	public function dispose():Void {
		this._game.mouse.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		this._game.mouse.removeEventListener(MouseEvent.MOUSE_DOWN,
			onMouseDown);
		
	}
	
	/**
	 * Draws this button on the given screen.
	 * 
	 * @param	screen	The screen this button should be drawn to.
	 */
	override public function draw(screen:Canvas):Void {
		super.draw(screen);
		
		screen.push();
		screen.translate(x, y);
		
		if (this.absoluteBounds.contains(
				this._game.mouse.x, this._game.mouse.y)) {
			
			if (this._mouseDown) {
				this._label.color = activeTextColor;
				screen.fillRect(activeColor, 0, 0, width, height);
			} else {
				this._label.color = hoverTextColor;
				screen.fillRect(hoverColor, 0, 0, width, height);
			}
			
		} else {
			this._label.color = textColor;
			screen.fillRect(color, 0, 0, width, height);
		}
		this._label.draw(screen);
		
		screen.pop();
	}
	
	
	/**
	 * Will be called when the left mouse button is pressed down.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onMouseDown(e:MouseEvent):Void {
		if (this.absoluteBounds.contains(e.x, e.y)) {
			_mouseDown = true;
		} else {
			_mouseDown = false;
		}
	}
	
	/**
	 * Will be called when the left mouse button is released.
	 * 
	 * @param	e	Event arguments.
	 */
	private function onMouseUp(e:MouseEvent):Void {
		if (this.absoluteBounds.contains(e.x, e.y) && _mouseDown) {
			this.dispatchEvent(new ButtonEvent(ButtonEvent.CLICKED));
		}
		_mouseDown = false;
	}
	
	/**
	 * Returns the font used for the caption of this button.
	 * 
	 * @return	The font used for the caption of this button.
	 */
	private function getFont():Font {
		return this._label.font;
	}
	
	/**
	 * Defines the font used for the caption of this button.
	 * 
	 * @param	font	The font used for the caption of this button.
	 * @return	The new font.
	 */
	private function setFont(font:Font):Font {
		return this._label.font = font;
	}
	
	/**
	 * Returns the caption of this button.
	 * 
	 * @return	The caption of this button.
	 */
	private function getText():String {
		return this._label.text;
	}
	
	/**
	 * Defines the caption of this button.
	 * 
	 * @param	text	The caption of this button.
	 * @return	The new caption.
	 */
	private function setText(text:String):String {
		return this._label.text = text;
	}
	
	/**
	 * Returns the width of this button.
	 * 
	 * @return	The width of this button.
	 */
	private function getWidth():Float {
		return this._metrics.width;
	}
	
	/**
	 * Defines the width of this button.
	 * 
	 * @param	width	The width of this button.
	 * @return	The new width.
	 */
	private function setWidth(width:Float):Float {
		this._metrics = new Rectangle(0, 0, width, this._metrics.height);
		return this._metrics.width;
	}
	
	/**
	 * Returns the height of this button.
	 * 
	 * @return	The height of this button.
	 */
	private function getHeight():Float {
		return this._metrics.height;
	}
	
	/**
	 * Defines the height of this button.
	 * 
	 * @param	height	The height of this button.
	 * @return	The new height.
	 */
	private function setHeight(height:Float):Float {
		this._metrics = new Rectangle(0, 0, this._metrics.width, height);
		return this._metrics.height;
	}
	
	/**
	 * Returns the bounding box of this button.
	 * 
	 * @return	The bounding box of this button.
	 */
	private function getBounds():Rectangle {
		return new Rectangle(this.x, this.y, this.width, this.height);
	}
	
	/**
	 * Returns the absolute bounding box of this button.
	 * 
	 * @return	The bounding box of this button. (Absolute coordinates)
	 */
	private function getAbsoluteBounds():Rectangle {
		return new Rectangle(this.getAbsoluteX(), this.getAbsoluteY(),
			this.width, this.height);
	}
	
}