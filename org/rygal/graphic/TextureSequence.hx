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


package org.rygal.graphic;

/**
 * <h2>Description</h2>
 * <p>
 *  A sequence of multiple textures. You usually don't have to worry about this
 *  class, as you can use the class Animation that wraps the constructing
 *  methods of the texture sequences.
 * </p>
 * 
 * @author Robert Böhm
 */
class TextureSequence {
    
    /** The length of this sequence. */
    public var length(getLength, never):Int;
    
    
    /** An array with all textures of this sequence. */
    private var _textures:Array<Texture>;
    
    
    /**
     * Creates a new texture sequence based on the given textures.
     * 
     * @param   textures    The textures this sequence will be based on.
     */
    public function new(textures:Array<Texture>) {
        this._textures = textures;
    }
    
    
    /**
     * Creates a new texture sequence based on a spritesheet with the given tile ID
     * range.
     * 
     * @param   spritesheet The spritesheet this sequence is based on.
     * @param   start   The first ID to use (Inclusive).
     * @param   end     The last ID to use (Exclusive). Use -1 to make it last
     *                  until the (inclusive) last tile.
     * @param   loop    Shall the animation be looping? (Forward and at the end
     *                  reverse direction)
     * @return  The new texture sequence.
     */
    public static function fromSpritesheet(spritesheet:Spritesheet, start:Int = 0,
            end:Int = -1, loop:Bool = false):TextureSequence {
        
        if (end < 0)
            end = spritesheet.length;
        
        var textures:Array<Texture> = new Array<Texture>();
        for (i in start...end) {
            textures.push(spritesheet.getTextureById(i));
        }
        if (loop) {
            var i:Int = end - 1;
            while (--i > start) {
                textures.push(spritesheet.getTextureById(i));
            }
        }
        return new TextureSequence(textures);
    }
    
    
    /**
     * Creates a new texture sequence based on a TextureAtlas.
     * 
     * @param   textureAtlas    The TextureAtlas this sequence is based on.
     * @param   names       The names of the sprites this sequence will use.
     * @return  The new texture sequence.
     */
    public static function fromTextureAtlas(textureAtlas:TextureAtlas,
            names:Array<String>):TextureSequence {
        
        var textures:Array<Texture> = new Array<Texture>();
        for (name in names) {
            textures.push(textureAtlas.getTexture(name));
        }
        return new TextureSequence(textures);
    }
    
    
    /**
     * Returns the texture with the given index.
     * 
     * @param   id  The index of the requested texture.
     */
    public function get(id:Int) {
        return _textures[id];
    }
    
    /**
     * Returns an iterator that iterates through all elements of this sequence
     * once.
     * 
     * @return  An iterator that iterates through this sequence once.
     */
    public function iterator():TextureSequenceIterator {
        return new TextureSequenceIterator(this);
    }
    
    /**
     * Returns an iterator that goes through all elements of this sequence a
     * specified amount of times.
     * 
     * @param   repeatCount The amount of times the iterator will repeat
     *                      iterating through this sequence. Use
     *                      TextureSequenceIterator.INFINITE_LOOP to let the
     *                      iterator loop through this sequence an infinite
     *                      amount of times.
     * @return  An iterator that iterates through this sequence.
     */
    public function getIterator(repeatCount:Int=0):TextureSequenceIterator {
        return new TextureSequenceIterator(this, repeatCount);
    }
    
    
    /**
     * Returns the length of this sequence.
     * 
     * @return  The length of this sequence.
     */
    private function getLength():Int {
        return _textures.length;
    }
    
}
