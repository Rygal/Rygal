// Copyright (C) 2012 Robert Böhm, Christopher Kaster
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
import nme.display.DisplayObject;
import nme.events.EventDispatcher;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;

/**
 * <h2>Description</h2>
 * <p>
 *  A touch handler. It will automatically be created by the Game-class.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 *  if (game.touch.x >= enemy.x && game.touch.x <= enemy.width) {<br />
 *  &nbsp;&nbsp;// touch point is under or above the enemy<br />
 *  }
 * </code>
 * 
 * @author Christopher Kaster
 * @author Robert Böhm
 */
class Touch extends InputDevice {
    
    /** The x-coordinate of the touch pointer. */
    public var x(default, null):Int;
    
    /** The y-coordinate of the touch pointer. */
    public var y(default, null):Int;
    
    /** Determines the ID of the touch pointer. */
    public var touchPointID(default, null):Int;
    
    /** Determines if this is the primary touch point, in other words when
     *  multiple touches occur, only the first one is the primary one. */
    public var isPrimaryTouchPoint(default, null):Bool;
    
    /** The pressure on the touch pointer. */
    public var pressure(default, null):Float;
    
    
    /** The game this touchpoint is based on */
    private var _game:Game;
    
    
    /**
     * Creates a new touch for the given DisplayObject.
     * 
     * @param   game            The Game this touch pointer will be created for.
     * @param   touchPointID    The touch point ID of this touch.
     */
    public function new(game:Game, touchPointID:Int) {
        super();
        
        this.touchPointID = touchPointID;
        this._game = game;
    }
    
    
    /**
     * Updates the touch pointer's coordinates and other attributes.
     * 
     * @param   e   Event parameters used to obtain the new values.
     */
    public function updateFromEvent(e:nme.events.TouchEvent):Void {
        var localX:Float = e.localX - _game.getDisplayObject().x;
        var localY:Float = e.localY - _game.getDisplayObject().y;
        this.x = Std.int(localX / _game.zoom) + _game.cameraX;
        this.y = Std.int(localY / _game.zoom) + _game.cameraY;
        
        this.isPrimaryTouchPoint = e.isPrimaryTouchPoint;
        
        // pressure seems not to work in NME 3.4
        this.pressure = 1.0;
    }
    
}
