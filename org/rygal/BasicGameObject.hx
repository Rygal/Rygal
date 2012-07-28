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
 * 	A class that implements the basic functionality to be a game object.
 * </p>
 * 
 * @author Robert Böhm
 */
class BasicGameObject implements GameObject {
	
	/** The x-coordinate of this object. */
	public var x:Float;
	
	/** The y-coordinate of this object. */
	public var y:Float;
	
	/** The parent of this object. */
	public var parent:GameObject;
	
	
	/**
	 * Creates a new basic game object.
	 */
	private function new(x:Float = 0, y:Float = 0) {
		this.x = x;
		this.y = y;
		this.parent = null;
	}
	
	/**
	 * Returns the absolute x-coordinate of this object.
	 * 
	 * @return	The absolute x-coordinate of this object.
	 */
	public function getAbsoluteX():Float {
		return parent != null ? this.x + parent.x : this.x;
	}
	
	/**
	 * Returns the absolute y-coordinate of this object.
	 * 
	 * @return	The absolute y-coordinate of this object.
	 */
	public function getAbsoluteY():Float {
		return parent != null ? this.y + parent.y : this.y;
	}
	
	/**
	 * Updates this object and executes game logic.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	public function update(time:GameTime):Void {}
	
	/**
	 * Draws this object on the given screen.
	 * 
	 * @param	screen	The screen this object will be drawn on.
	 */
	public function draw(screen:Canvas):Void {}
	
}