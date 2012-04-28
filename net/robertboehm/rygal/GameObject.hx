// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import net.robertboehm.rygal.graphic.Canvas;

/**
 * ...
 * @author Robert Böhm
 */

interface GameObject {
	
	public var x:Float;
	public var y:Float;
	
	public function update(time:GameTime):Void;
	
	public function draw(screen:Canvas):Void;
	
}
