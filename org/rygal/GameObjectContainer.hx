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
 * 	A container for game objects as well as a game object itself, thus multiple
 * 	game object containers can be nested. Besides the functionality of having
 * 	children, it also automatically updates and draws them.
 * </p>
 * 
 * @author Robert Böhm
 */
class GameObjectContainer implements GameObject {
	
	/** The x-coordinate of this container. */
	public var x:Float;
	
	/** The y-coordinate of this container. */
	public var y:Float;
	
	/** The array with all children of this container. */
	private var _children:Array<GameObject>;
	
	
	/**
	 * Creates a new game object container.
	 */
	public function new() {
		this.x = 0;
		this.y = 0;
		_children = new Array<GameObject>();
	}
	
	/**
	 * Inserts a child at the given index.
	 * 
	 * @param	child	The game object to be inserted.
	 * @param	index	The index.
	 */
	public function addChildAt(child:GameObject, index:Int):Void {
		_children.insert(index, child);
	}
	
	/**
	 * Adds a child to this container.
	 * 
	 * @param	child	The game object to be added.
	 */
	public function addChild(child:GameObject):Void {
		_children.push(child);
	}
	
	/**
	 * Removes all children.
	 */
	public function removeChildren():Void {
		_children.splice(0, _children.length);
	}
	
	/**
	 * Removes the given child.
	 * 
	 * @param	child	The game object to be removed.
	 */
	public function removeChild(child:GameObject):Void {
		_children.remove(child);
	}
	
	/**
	 * Determines if the given game object is a child of this container.
	 * 
	 * @param	child	The game object to be checked if it's a child.
	 * @return	True if the given game object is a child of this container.
	 */
	public function isChild(child:GameObject):Bool {
		for (c in _children) {
			if (c == child) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Returns an array with all children of this container.
	 * 
	 * @return	An array with all children of this container.
	 */
	public function getChildren():Array<GameObject> {
		return _children;
	}
	
	/**
	 * Updates all children of this container.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	public function update(time:GameTime):Void {
		for (child in _children) {
			child.update(time);
		}
	}
	
	/**
	 * Draws all children of this container onto the given screen.
	 * 
	 * @param	screen	The screen the children get drawn to.
	 */
	public function draw(screen:Canvas):Void {
		screen.push();
		screen.translate(this.x, this.y);
		for (child in _children) {
			child.draw(screen);
		}
		screen.pop();
	}
	
}
