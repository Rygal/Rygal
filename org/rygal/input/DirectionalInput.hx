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


package org.rygal.input;

import org.rygal.Game;
import org.rygal.util.Storage;

/**
 * ...
 * @author Robert Böhm
 */
class DirectionalInput extends Input {
	
	// = Math.sin(Math.PI / 4)
	private var DIRECTIONAL_MOVEMENT:Float = 0.707106781;
	private var STAIGHT_MOVEMENT:Float = 1;
	
	public var direction(default, null):Float;
	public var hasDirection(default, null):Bool;
	
	
	public function new(game:Game, name:String) {
		super(game, name);
	}
	
	
	override public function update():Void {
		if (this._touch || this._mouse) {
			var targetX:Float;
			var targetY:Float;
			
			if (this._touch && game.touch.primaryTouch != null) {
				targetX = game.touch.primaryTouch.x;
				targetY = game.touch.primaryTouch.y;
			} else {
				targetX = game.mouse.x;
				targetY = game.mouse.y;
			}
			
			this.direction = Math.atan2(targetY - _originY, targetX - _originX);
			this.hasDirection = true;
			
		} else if (this._keySets.length > 0) {
			var kb:Keyboard = game.keyboard;
			var xOffset:Float = 0;
			var yOffset:Float = 0;
			this.direction = 0;
			this.hasDirection = false;
			
			for (keyset in _keySets) {
				if (kb.isKeyPressed(keyset.getKey(Keyset.NORTHEAST))) {
					xOffset += DIRECTIONAL_MOVEMENT;
					yOffset -= DIRECTIONAL_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.SOUTHEAST))) {
					xOffset += DIRECTIONAL_MOVEMENT;
					yOffset += DIRECTIONAL_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.SOUTHWEST))) {
					xOffset -= DIRECTIONAL_MOVEMENT;
					yOffset += DIRECTIONAL_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.NORTHWEST))) {
					xOffset -= DIRECTIONAL_MOVEMENT;
					yOffset -= DIRECTIONAL_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.NORTH))) {
					yOffset -= STAIGHT_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.EAST))) {
					xOffset += STAIGHT_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.SOUTH))) {
					yOffset += STAIGHT_MOVEMENT;
				}
				if (kb.isKeyPressed(keyset.getKey(Keyset.WEST))) {
					xOffset -= STAIGHT_MOVEMENT;
				}
				
				if (xOffset != 0 || yOffset != 0) {
					this.direction = Math.atan2(yOffset, xOffset);
					this.hasDirection = true;
					break;
				}
			}
		}
	}
	
}