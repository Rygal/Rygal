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

/**
 * <h2>Description</h2>
 * <p>
 *  A TextureAtlas that can contain multiple named textures. It currently
 *  supports a loader for the generic XML format used by
 *  <a href="http://www.texturepacker.com/" target="_blank">TexturePacker</a>.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 *  var textureAtlas:TextureAtlas = TextureAtlas.fromGenericXmlAsset(<br />
 *  &nbsp;&nbsp;"assets/TextureAtlas.xml");<br />
 *  var sprite:Sprite = new Sprite(textureAtlas.getTexture("fire"));<br />
 *  this.addChild(sprite);
 * </code>
 * 
 * @author Robert Böhm
 */
class TextureAtlas {
    
    /** The textures that are in this TextureAtlas. */
    private var _textures:Hash<Texture>;
    
    
    /**
     * Creates a new TextureAtlas based on the given textures. You shouldn't
     * create a TextureAtlas directly, use one of the static fromXYZ-methods.
     * 
     * @param   textures    The textures.
     */
    public function new(textures:Hash<Texture>) {
        this._textures = textures;
    }
    
    
    /**
     * Loads a generic XML TextureAtlas from an asset.
     * 
     * @param   id  The asset ID of the TextureAtlas's XML file.
     * @return  The TextureAtlas.
     */
    public static function fromGenericXmlAsset(id:String):TextureAtlas {
        return fromGenericXml(
                Assets.getText(id),
                id.substr(0, id.lastIndexOf("/"))
            );
    }
    
    /**
     * Interprets a generic XML TextureAtlas.
     * 
     * @param   xml             The XML code.
     * @param   ?imageFolder    The folder where the TextureAtlas's image is
     *                          located in.
     * @return  The TextureAtlas.
     */
    public static function fromGenericXml(xml:String,
            ?imageFolder:String):TextureAtlas {
        
        if (imageFolder == null) {
            imageFolder = ".";
        }
        
        var lastChar:String = imageFolder.charAt(imageFolder.length - 1);
        if (lastChar != "/") {
            imageFolder += "/";
        }
        
        var textureAtlas:Xml = Xml.parse(xml).firstElement();
        var texture:Texture = Texture.fromAssets(
                imageFolder + textureAtlas.get("imagePath")
            );
        
        var textures:Hash<Texture> = new Hash<Texture>();
        var x:Int;
        var y:Int;
        var w:Int;
        var h:Int;
        for (textureData in textureAtlas) {
            if (textureData.nodeType == Xml.Element &&
                    textureData.nodeName == "sprite") {
                
                x = Std.parseInt(textureData.get("x"));
                y = Std.parseInt(textureData.get("y"));
                w = Std.parseInt(textureData.get("w"));
                h = Std.parseInt(textureData.get("h"));
                textures.set(textureData.get("n"), texture.slice(x, y, w, h));
            }
        }
        return new TextureAtlas(textures);
    }
    
    
    /**
     * Returns the texture with the given name.
     * 
     * @param   name    The name of the requested texture.
     * @return  The texture with the given name.
     */
    public function getTexture(name:String):Texture {
        return _textures.get(name);
    }
    
}
