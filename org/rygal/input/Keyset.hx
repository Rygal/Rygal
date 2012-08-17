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

/**
 * <h2>Description</h2>
 * <p>
 *  Contains a set of keys that are associated with a direction.
 * </p>
 * 
 * @author Robert Böhm
 */
class Keyset {
    
    /** A constant that corresponds to an undefined key. */
    public static inline var NONE:Int = -1;
    
    // Various cardinal directions:
    public static inline var NORTH:Int = 0;
    public static inline var EAST:Int = 1;
    public static inline var SOUTH:Int = 2;
    public static inline var WEST:Int = 3;
    public static inline var NORTHEAST:Int = 4;
    public static inline var SOUTHEAST:Int = 5;
    public static inline var SOUTHWEST:Int = 6;
    public static inline var NORTHWEST:Int = 7;
    
    
    // The keys associated with the various cardinal directions:
    private var keyN:Int;
    private var keyE:Int;
    private var keyS:Int;
    private var keyW:Int;
    private var keyNE:Int;
    private var keySE:Int;
    private var keySW:Int;
    private var keyNW:Int;
    
    
    /**
     * Creates a new set of keys for various cardinal directions.
     * 
     * @param   keyN    The key for the north direction.
     * @param   keyE    The key for the east direction.
     * @param   keyS    The key for the south direction.
     * @param   keyW    The key for the west direction.
     * @param   keyNE   The key for the north-east direction.
     * @param   keySE   The key for the south-east direction.
     * @param   keySW   The key for the south-west direction.
     * @param   keyNW   The key for the north-west direction.
     */
    public function new(keyN:Int, keyE:Int, keyS:Int, keyW:Int,
            keyNE:Int = NONE, keySE:Int = NONE,
            keySW:Int = NONE, keyNW:Int = NONE) {
        
        this.keyN = keyN;
        this.keyE = keyE;
        this.keyS = keyS;
        this.keyW = keyW;
        this.keyNE = keyNE;
        this.keySE = keySE;
        this.keySW = keySW;
        this.keyNW = keyNW;
    }
    
    
    /**
     * Returns the predefined keyset for the numpad.
     * 
     * @return  The predefined keyset for the numpad.
     */
    public static function getNumpad():Keyset {
        return new Keyset(
            Keys.NUMPAD_8, Keys.NUMPAD_6, Keys.NUMPAD_2, Keys.NUMPAD_4,
            Keys.NUMPAD_9, Keys.NUMPAD_3, Keys.NUMPAD_1, Keys.NUMPAD_7);
    }
    
    /**
     * Returns the predefined keyset for the WASD-keys.
     * 
     * @return  The predefined keyset for the WASD-keys.
     */
    public static function getWASD():Keyset {
        return new Keyset(Keys.W, Keys.D, Keys.S, Keys.A);
    }
    
    /**
     * Returns the predefined keyset for the IJKL-keys.
     * 
     * @return  The predefined keyset for the IJKL-keys.
     */
    public static function getIJKL():Keyset {
        return new Keyset(Keys.I, Keys.J, Keys.K, Keys.L);
    }
    
    /**
     * Returns the predefined keyset for the arrow keys.
     * 
     * @return  The predefined keyset for the arrow keys.
     */
    public static function getArrowKeys():Keyset {
        return new Keyset(Keys.UP, Keys.RIGHT, Keys.DOWN, Keys.LEFT);
    }
    
    
    /**
     * Returns the key associated with the given direction.
     * 
     * @param   direction   The direction.
     * @return  The key associated with the given direction.
     */
    public function getKey(direction:Int):Int {
        return switch(direction) {
            case NORTH:     this.keyN;
            case EAST:      this.keyE;
            case SOUTH:     this.keyS;
            case WEST:      this.keyW;
            case NORTHEAST: this.keyNE;
            case SOUTHEAST: this.keySE;
            case SOUTHWEST: this.keySW;
            case NORTHWEST: this.keyNW;
            default:        Keyset.NONE;
        }
    }
    
}
