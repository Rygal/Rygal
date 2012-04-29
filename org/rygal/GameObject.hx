// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

import org.rygal.graphic.Canvas;

/**
 * <h2>Description</h2>
 * <p>
 * 	A game object. It provides functionality for drawing as well as game logic.
 * 	It also has a position, determined by the x and y coordinates.
 * </p>
 * 
 * @author Robert Böhm
 */
interface GameObject {
	
	/** The x-coordinate of this object. */
	public var x:Float;
	
	/** The y-coordinate of this object. */
	public var y:Float;
	
	
	/**
	 * Updates this object and executes game logic.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	public function update(time:GameTime):Void;
	
	/**
	 * Draws this object on the given screen.
	 * 
	 * @param	screen	The screen this object will be drawn on.
	 */
	public function draw(screen:Canvas):Void;
	
}
