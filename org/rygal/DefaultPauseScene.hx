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


package org.rygal;

import org.rygal.graphic.Canvas;
import org.rygal.graphic.Sprite;
import org.rygal.input.MouseEvent;

/**
 * <h2>Description</h2>
 * <p>
 * 	The default pause scene. It's current functionality is very restricted as it
 * 	only darkens the screen and unpauses as soon as the mouse is pressed.
 * </p>
 * 
 * @author Robert Böhm
 */
class DefaultPauseScene extends Scene {
	
	/**
	 * Creates a new pause scene.
	 */
	public function new() {
		super();
	}
	
	/**
	 * Loads the scene. (Ressources, event listeners, etc.)
	 * 
	 * @param	game	The game this scene belongs to.
	 */
	override public function load(game:Game) {
		super.load(game);
		
		game.mouse.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		var c:Canvas = Canvas.create(game.width, game.height, true, 0x55000000);
		this.addChild(new Sprite(c.toTexture()));
	}
	
	/**
	 * Unloads the scene. (Ressources, event listeners, etc.)
	 */
	override public function unload() {
		game.mouse.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		super.unload();
	}
	
	/**
	 * A callback that will be called when the mouse button is pressed.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onMouseDown(e:MouseEvent):Void {
		game.unpause();
	}
	
	
}