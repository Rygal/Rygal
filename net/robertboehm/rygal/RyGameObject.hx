// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import net.robertboehm.rygal.graphic.RyCanvas;

/**
 * ...
 * @author Robert Böhm
 */

interface RyGameObject {
	
	public var x:Float;
	public var y:Float;
	
	public function update(time:RyGameTime):Void;
	
	public function draw(screen:RyCanvas):Void;
	
}
