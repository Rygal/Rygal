// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;
import net.robertboehm.rygal.RyGameObject;
import net.robertboehm.rygal.RyGameTime;
import nme.geom.Point;

/**
 * ...
 * @author Robert Böhm
 */

class RySprite implements RyGameObject {
	
	public var x:Float;
	public var y:Float;
	public var width:Int;
	public var height:Int;
	
	public var texture:RyTexture;
	
	public function new(texture:RyTexture, x:Float=0, y:Float=0) {
		setTexture(texture);
		this.x = x;
		this.y = y;
	}
	
	public function setTexture(texture:RyTexture):Void {
		this.texture = texture;
		
		if (texture != null) {
			this.width = texture.width;
			this.height = texture.height;
		} else {
			this.width = 0;
			this.height = 0;
		}
	}
	
	public function update(time:RyGameTime):Void {
	}
	
	public function draw(screen:RyCanvas):Void {
		if(texture != null)
			screen.draw(texture, x, y);
	}
	
}
