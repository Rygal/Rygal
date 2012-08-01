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
 * 	A spritesheet that can contain multiple named textures. It currently
 * 	supports a loader for the generic XML format used by
 * 	<a href="http://www.texturepacker.com/" target="_blank">TexturePacker</a>.
 * </p>
 * 
 * <h2>Example <i>(Inside a scene)</i></h2>
 * <code>
 * 	var spritesheet:Spritesheet = Spritesheet.fromGenericXmlAsset(<br />
 * 	&nbsp;&nbsp;"assets/spritesheet.xml");<br />
 * 	var sprite:Sprite = new Sprite(spritesheet.getTexture("fire"));<br />
 * 	this.addChild(sprite);
 * </code>
 * 
 * @author Robert Böhm
 */
class Spritesheet {
	
	/** The textures that are in this spritesheet. */
	private var _textures:Hash<Texture>;
	
	
	/**
	 * Creates a new spritesheet based on the given textures. You shouldn't
	 * create a spritesheet directly, use one of the static fromXYZ-methods.
	 * 
	 * @param	textures	The textures.
	 */
	public function new(textures:Hash<Texture>) {
		this._textures = textures;
	}
	
	
	/**
	 * Loads a generic XML spritesheet from an asset.
	 * 
	 * @param	id	The asset ID of the spritesheet's XML file.
	 * @return	The spritesheet.
	 */
	public static function fromGenericXmlAsset(id:String):Spritesheet {
		return fromGenericXml(
				Assets.getText(id),
				id.substr(0, id.lastIndexOf("/"))
			);
	}
	
	/**
	 * Interprets a generic XML spritesheet.
	 * 
	 * @param	xml				The XML code.
	 * @param	?imageFolder	The folder where the spritesheet's image is
	 * 							located in.
	 * @return	The spritesheet.
	 */
	public static function fromGenericXml(xml:String,
			?imageFolder:String):Spritesheet {
		
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
		for (sprite in textureAtlas) {
			if (sprite.nodeType == Xml.Element && sprite.nodeName == "sprite") {
				x = Std.parseInt(sprite.get("x"));
				y = Std.parseInt(sprite.get("y"));
				w = Std.parseInt(sprite.get("w"));
				h = Std.parseInt(sprite.get("h"));
				textures.set(sprite.get("n"), texture.slice(x, y, w, h));
			}
		}
		return new Spritesheet(textures);
	}
	
	
	/**
	 * Returns the texture with the given name.
	 * 
	 * @param	name	The name of the requested texture.
	 * @return	The texture with the given name.
	 */
	public function getTexture(name:String):Texture {
		return _textures.get(name);
	}
	
}