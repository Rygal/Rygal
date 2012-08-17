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

/**
 * <h2>Description</h2>
 * <p>
 *  A scene that besides basic game object container functionality also provides
 *  methods for loading/unloading the scene. A scene can be added to a game that
 *  then manages the method calling stuff.
 * </p>
 * 
 * @author Robert Böhm
 */
class Scene extends GameObjectContainer {
    
    /** The game this scene belongs to. */
    public var game(default, null):Game;
    
    
    /**
     * Creates a new scene.
     */
    public function new() {
        super();
    }
    
    
    /**
     * Loads the scene. (Ressources, event listeners, etc.)
     * Will be called everytime this scene gets active.
     * 
     * @param   game    The game this scene belongs to.
     */
    public function load(game:Game) {
        this.game = game;
    }
    
    /**
     * Unloads the scene. (Ressources, event listeners, etc.)
     * Will be called everytime this scene gets inactive (= Game changes to
     * another scene).
     */
    public function unload() {
        this.removeChildren();
    }
    
}
