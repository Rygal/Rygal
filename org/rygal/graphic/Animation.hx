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
 * 	An animation that is based on a texture sequence and a specified delay
 * 	between frames.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	var tileset:Tileset = new Tileset(<br />
 * 	&nbsp;&nbsp;Texture.fromAssets("assets/walkAnimation.png"), 4, 1);<br />
 * 	var animation:Animation = Animation.fromTileset(250, tileset)<br />
 * 	<br />
 * 	var sprite:AnimatedSprite = new AnimatedSprite();<br />
 * 	sprite.registerAnimation("walk", animation);<br />
 * 	sprite.loop("walk");
 * </code>
 * 
 * @author Robert Böhm
 */
class Animation {
	
	/** The delay between multiple frames. */
	public var frameDelay:Int;
	
	/** The texture sequence this animation is based on. */
	public var sequence:TextureSequence;
	
	
	/**
	 * Creates a new animation based on a frame delay and a given texture
	 * sequence.
	 * 
	 * @param	frameDelay	The delay between frames in milliseconds.
	 * @param	sequence	The texture sequence this animation is based on.
	 */
	public function new(frameDelay:Int, sequence:TextureSequence) {
		this.frameDelay = frameDelay;
		this.sequence = sequence;
	}
	
	
	/**
	 * Creates a new animation based on a tileset.
	 * 
	 * @param	frameDelay	The delay between frames in milliseconds.
	 * @param	tileset		The tileset this animation is based on.
	 * @param	start		The first ID to use (Inclusive).
	 * @param	end			The last ID to use (Exclusive). Use -1 to make it
	 * 						last until the (inclusive) last tile.
	 * @param	loop		Shall the animation be looping? (Forward and at the
	 * 						end reverse direction)
	 * @return	The new animation based on the given parameters.
	 */
	public static function fromTileset(frameDelay:Int, tileset:Tileset,
			start:Int = 0, end:Int = -1, loop:Bool = false):Animation {
		
		return new Animation(frameDelay,
			TextureSequence.fromTileset(tileset, start, end, loop));
	}
	
	/**
	 * Creates a new animation based on a TextureAtlas.
	 * 
	 * @param	frameDelay	The delay between frames in milliseconds.
	 * @param	TextureAtlas	The TextureAtlas this animation is based on.
	 * @param	names		The names of the sprites this animation will use.
	 * @return	The new animation based on the given parameters.
	 */
	public static function fromTextureAtlas(frameDelay:Int,
			TextureAtlas:TextureAtlas, names:Array<String>):Animation {
		
		return new Animation(frameDelay,
			TextureSequence.fromTextureAtlas(TextureAtlas, names));
	}
	
}