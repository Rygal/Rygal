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
	
	public var direction(default, null):Float;
	
	
	public function new(game:Game, name:String) {
		super(game, name);
	}
	
	
	override public function update():Void {
		var targetX:Int;
		var targetY:Int;
		
		if (this._touch && game.touch.primaryTouch != null) {
			targetX = game.touch.primaryTouch.x;
			targetY = game.touch.primaryTouch.y;
		} else {
			targetX = game.mouse.x;
			targetY = game.mouse.y;
		}
		
		this.direction = Math.atan2(targetY - _originY, targetX - _originX);
	}
	
}