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
 * <h2>Description</h2>
 * <p>
 *  A directional input for the controller. It can be used for inputs like
 *  character movement or aiming.
 * </p>
 * 
 * @author Robert Böhm
 */
class DirectionalInput extends Input {
    
    /** The distance per axis traveled with directional movement.<br />
     *  Equals: <b>Math.sin(Math.PI / 4)</b> */
    private var DIRECTIONAL_MOVEMENT:Float = 0.707106781;
    
    /** The distance per axis traveled with straight movement. */
    private var STAIGHT_MOVEMENT:Float = 1;
    
    
    /** The direction of this input. */
    public var direction(default, null):Float;
    
    /** Determines if this input has any direction. */
    public var hasDirection(default, null):Bool;
    
    
    /**
     * Creates a new directional input for the given game and with the given
     * name.
     * 
     * @param   game    The game this input will be bound to.
     * @param   name    The name of this input.
     */
    public function new(game:Game, name:String) {
        super(game, name);
    }
    
    
    /**
     * Updates this directional input.
     */
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
