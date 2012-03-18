// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import nme.geom.Point;

/**
 * ...
 * @author Robert Böhm
 */

class RySprite implements RyGameObject {
	
	public var position:RyVector;
	public var width:Int;
	public var height:Int;
	
	public var texture:RyTexture;
	
	public function new(texture:RyTexture, x:Int=0, y:Int=0) {
		setTexture(texture);
		this.position = new RyVector(x, y);
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
			screen.draw(texture, position.x, position.y);
	}
	
}
