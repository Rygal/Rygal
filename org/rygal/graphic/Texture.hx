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

import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.utils.ByteArray;

/**
 * <h2>Description</h2>
 * <p>
 *  A texture that can be drawn onto a canvas.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 *  var sprite:Sprite = new Sprite(Texture.fromAssets("assets/fire.png"));<br />
 *  this.addChild(sprite);
 * </code>
 * 
 * @author Robert Böhm
 */
class Texture {
    
    /** The width of this texture. */
    public var width(getWidth, never):Int;
    
    /** The height of this texture. */
    public var height(getHeight, never):Int;
    
    /** The bitmap data this texture is based on. */
    public var bitmapData(default, null):BitmapData;
    
    /** The area of the bitmap data this texture uses. */
    public var bitmapDataRect(default, null):Rectangle;
    
    
    /**
     * Creates a new texture based on the given bitmap data.
     * 
     * @param   bitmapData      The bitmap data this texture is based on.
     * @param   ?bitmapDataRect The area of the bitmap data that will be used.
     */
    public function new(bitmapData:BitmapData, ?bitmapDataRect:Rectangle) {
        this.bitmapData = bitmapData;
        if (bitmapDataRect == null)
            bitmapDataRect = bitmapData.rect;
        
        this.bitmapDataRect = bitmapDataRect;
    }
    
    
    /**
     * Loads a texture from the assets.
     * 
     * @param   name    The asset ID to be used.
     * @return  The loaded texture.
     */
    public static function fromAssets(name:String):Texture {
        return new Texture(Assets.getBitmapData(name));
    }
	
	/**
	 * Loads a texture from bytes.
	 * @param	name	The asset ID to be used.
	 * @return The loaded texture.
	 */
	public static function fromBytes(bytes:ByteArray):Texture {
		#if cpp
		return new Texture(BitmapData.loadFromBytes(bytes));
		#else
		return null; // TODO: throw error
		#end
	}
    
    /**
     * Creates a new texture containing a string. It basically creates a new
     * canvas where it writes the text on and returns the canvas converted into
     * a texture.
     * 
     * @param   font        The font to be used.
     * @param   text        The text to be drawn.
     * @param   color       The color of the text.
     * @param   width       The width of the new texture.
     * @param   height      The height of the new texture.
     * @param   alignment   The alignment, use the constants defined in the
     *                      Font-class.
     * @return  The new texture with the text on it.
     */
    public static function fromText(font:Font, text:String, color:Int,
            width:Int = 256, height:Int = 64, alignment:Int = 0):Texture {
        
        var x:Float = 0;
        if (alignment == Font.RIGHT) {
            x = width;
        } else if (alignment == Font.CENTER) {
            x = width / 2;
        }
        var canvas:Canvas = Canvas.create(width, height);
        canvas.drawString(font, text, color, x, 0, alignment);
        return canvas.toTexture();
    }
    
    
    /**
     * Returns a sliced version of this texture.
     * 
     * @param   x       The x-coordinate of the slice.
     * @param   y       The y-coordinate of the slice.
     * @param   width   The width of the slice.
     * @param   height  The height of the slice.
     * @return  The sliced version of this texture.
     */
    public function slice(x:Int, y:Int, width:Int, height:Int):Texture {
        var newRect:Rectangle = new Rectangle(bitmapDataRect.x + x,
                                              bitmapDataRect.y + y,
                                              width, height);
        
        return new Texture(bitmapData, newRect);
    }
    
    /**
     * Returns a canvas with the same bitmap data this texture is based on.
     * However, if you modify the new canvas, this texture won't change!
     * 
     * @return  A canvas with the same bitmap data as this texture.
     */
    public function toCanvas():Canvas {
        return new Canvas(this.clone().bitmapData);
    }
    
    /**
     * Duplicates this texture. Modifications on the new texture won't affect
     * this one and vice versa.
     * 
     * @return  The duplicated texture.
     */
    public function clone():Texture {
        #if js
        var data:BitmapData = new BitmapData(width, height);
        #else
        var data:BitmapData = new BitmapData(width, height,
            bitmapData.transparent);
        #end
        
        data.copyPixels(bitmapData, bitmapDataRect, new Point());
        return new Texture(data);
    }
    
    
    /**
     * Returns the width of this texture.
     * 
     * @return  The width of this texture.
     */
    private function getWidth():Int {
        return Std.int(bitmapDataRect.width);
    }
    
    /**
     * Returns the height of this texture.
     * 
     * @return  The height of this texture.
     */
    private function getHeight():Int {
        return Std.int(bitmapDataRect.height);
    }
    
}
