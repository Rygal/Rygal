// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import net.robertboehm.rygal.physics.PhysicalObject;
import net.robertboehm.rygal.physics.Primitive;
import net.robertboehm.rygal.physics.Rectangle;
import net.robertboehm.rygal.GameObject;
import net.robertboehm.rygal.GameTime;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Robert Böhm
 */

class Sprite implements GameObject, implements PhysicalObject {
	
	public var boundOffsets:Rectangle;
	
	public var x:Float;
	public var y:Float;
	public var width:Int;
	public var height:Int;
	
	public var texture:Texture;
	
	public function new(texture:Texture, x:Float=0, y:Float=0, boundOffsets:Rectangle=null) {
		this.x = x;
		this.y = y;
		this.boundOffsets = boundOffsets;
		setTexture(texture);
	}
	
	public function setTexture(texture:Texture):Void {
		this.texture = texture;
		
		if (texture != null) {
			this.width = texture.width;
			this.height = texture.height;
		} else {
			this.width = 0;
			this.height = 0;
		}
	}
	
	public function update(time:GameTime):Void {
	}
	
	public function draw(screen:Canvas):Void {
		if(texture != null)
			screen.draw(texture, x, y);
	}
	
	public function getPrimitive():Primitive {
		if (boundOffsets != null) {
			return new Rectangle(x + boundOffsets.x, y + boundOffsets.y, width - boundOffsets.width - boundOffsets.x, height - boundOffsets.height - boundOffsets.y);
		} else {
			return new Rectangle(x, y, width, height);
		}
	}
	
	public function collides(object:PhysicalObject):Bool {
		return this.getPrimitive().collides(object.getPrimitive());
	}
	
}
