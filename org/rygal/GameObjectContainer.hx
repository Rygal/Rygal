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

/**
 * <h2>Description</h2>
 * <p>
 *  A container for game objects as well as a game object itself, thus multiple
 *  game object containers can be nested. Besides the functionality of having
 *  children, it also automatically updates and draws them.
 * </p>
 * 
 * @author Robert Böhm
 */
class GameObjectContainer implements GameObject {
    
    /** The x-coordinate of this container. */
    public var x:Float;
    
    /** The y-coordinate of this container. */
    public var y:Float;
    
    /** The parent of this object. */
    public var parent:GameObject;
    
    
    /** The array with all children of this container. */
    private var _children:Array<GameObject>;
    
    
    /**
     * Creates a new game object container.
     */
    public function new() {
        this.x = 0;
        this.y = 0;
        _children = new Array<GameObject>();
    }
    
    
    /**
     * Returns the absolute x-coordinate of this object.
     * 
     * @return  The absolute x-coordinate of this object.
     */
    public function getAbsoluteX():Float {
        return parent != null ? this.x + parent.x : this.x;
    }
    
    /**
     * Returns the absolute y-coordinate of this object.
     * 
     * @return  The absolute y-coordinate of this object.
     */
    public function getAbsoluteY():Float {
        return parent != null ? this.y + parent.y : this.y;
    }
    
    /**
     * Inserts a child at the given index.
     * 
     * @param   child   The game object to be inserted.
     * @param   index   The index.
     */
    public function addChildAt(child:GameObject, index:Int):Void {
        child.parent = this;
        _children.insert(index, child);
    }
    
    /**
     * Adds a child to this container.
     * 
     * @param   child   The game object to be added.
     */
    public function addChild(child:GameObject):Void {
        child.parent = this;
        _children.push(child);
    }
    
    /**
     * Removes all children.
     */
    public function removeChildren():Void {
        for (child in _children) {
            child.parent = null;
        }
        _children.splice(0, _children.length);
    }
    
    /**
     * Removes the given child.
     * 
     * @param   child   The game object to be removed.
     */
    public function removeChild(child:GameObject):Void {
        child.parent = null;
        _children.remove(child);
    }
    
    /**
     * Determines if the given game object is a child of this container.
     * 
     * @param   child   The game object to be checked if it's a child.
     * @return  True if the given game object is a child of this container.
     */
    public function isChild(child:GameObject):Bool {
        for (c in _children) {
            if (c == child) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Returns an array with all children of this container.
     * 
     * @return  An array with all children of this container.
     */
    public function getChildren():Array<GameObject> {
        return _children;
    }
    
    /**
     * Updates all children of this container.
     * 
     * @param   time    The time elapsed since the last update.
     */
    public function update(time:GameTime):Void {
        for (child in _children) {
            child.update(time);
        }
    }
    
    /**
     * Draws all children of this container onto the given screen.
     * 
     * @param   screen  The screen the children get drawn to.
     */
    public function draw(screen:Canvas):Void {
        screen.push();
        screen.translate(this.x, this.y);
        for (child in _children) {
            child.draw(screen);
        }
        screen.pop();
    }
    
}
