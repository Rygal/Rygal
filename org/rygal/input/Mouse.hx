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
 * <h2>Description</h2>
 * <p>
 * 	A single-button mouse. It will automatically be created by the Game-class.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	if (this.game.mouse.isPressed) {<br />
 * 	&nbsp;&nbsp;// Let the player shoot<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Mouse extends EventDispatcher {
	
	/** The x-coordinate of the mouse. */
	public var x:Int;
	
	/** The y-coordinate of the mouse. */
	public var y:Int;
	
	/** Determines whether this mouse is pressed or not. */
	public var isPressed:Bool;
	
	/** The absolute x-coordinate of the mouse. */
	private var _absoluteX:Int;
	
	/** The absolute y-coordinate of the mouse. */
	private var _absoluteY:Int;
	
	/** The game this mouse is based on. */
	private var _game:Game;
	
	#if (js || cpp)
	// Mouse events in HTML5/C++ don't work on sprites, but they do on the stage
	private var _handler:DisplayObject;
	#end
	
	
	/**
	 * Creates a new mouse for the given DisplayObject and Game.
	 * 
	 * @param	handler	The DisplayObject this mouse will be created for.
	 * @param	game	The Game this mouse will be created for.
	 */
	public function new(handler:DisplayObject, game:Game) {
		super();
		
		_game = game;
		#if (js || cpp)
		_handler = handler;
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_MOVE,
			onMouseMove);
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_DOWN,
			onMouseDown);
		handler.stage.addEventListener(nme.events.MouseEvent.MOUSE_UP,
			onMouseUp);
		#else
		handler.addEventListener(nme.events.MouseEvent.MOUSE_MOVE, onMouseMove);
		handler.addEventListener(nme.events.MouseEvent.MOUSE_DOWN, onMouseDown);
		handler.addEventListener(nme.events.MouseEvent.MOUSE_UP, onMouseUp);
		#end
	}
	
	/**
	 * Displays the system cursor.
	 */
	public function show() {
		nme.ui.Mouse.show();
	}
	
	/**
	 * Hides the system cursor.
	 */
	public function hide() {
		nme.ui.Mouse.hide();
	}
	
	/**
	 * A callback that will be called whenever the mouse is pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseDown(e:nme.events.MouseEvent):Void {
		isPressed = true;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, this));
	}
	
	/**
	 * A callback that will be called whenever the mouse is released.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseUp(e:nme.events.MouseEvent):Void {
		isPressed = false;
		this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, this));
	}
	
	/**
	 * A callback that will be called whenever the mouse is moved.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseMove(e:nme.events.MouseEvent):Void {
		var prevX:Int = this._absoluteX;
		var prevY:Int = this._absoluteY;
		#if js
		this._absoluteX = Std.int((e.stageX - _handler.x) / _game.zoom);
		this._absoluteY = Std.int((e.stageY - _handler.y) / _game.zoom);
		#else
		this._absoluteX = Std.int(e.localX / _game.zoom);
		this._absoluteY = Std.int(e.localY / _game.zoom);
		#end
		prevX += _game.cameraX;
		prevY += _game.cameraY;
		this.x = _absoluteX + _game.cameraX;
		this.y = _absoluteY + _game.cameraY;
		this.dispatchEvent(
				new MouseMoveEvent(MouseEvent.MOUSE_MOVE, this, prevX, prevY)
			);
	}
	
}
