// Copyright (C) 2011 Robert Böhm
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
	
	public var x:Float;
	public var y:Float;
	public var width:Int;
	public var height:Int;
	
	public var texture:RyTexture;
	
	public function new(texture:RyTexture) {
		this.texture = texture;
		
		this.width = texture.width;
		this.height = texture.height;
	}
	
	public function update(time:RyGameTime) {
	}
	
	public function draw(screen:RyCanvas) {
		screen.draw(texture, x, y);
	}
	
}
