// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

/**
 * <h2>Description</h2>
 * <p>
 * 	A scene that besides basic game object container functionality also provides
 * 	methods for loading/unloading the scene. A scene can be added to a game that
 * 	then manages the method calling stuff.
 * </p>
 * 
 * @author Robert Böhm
 */
class Scene extends GameObjectContainer {
	
	/** The game this scene belongs to. */
	public var game:Game;
	
	
	/**
	 * Creates a new scene.
	 */
	public function new() {
		super();
	}
	
	/**
	 * Loads the scene. (Ressources, event listeners, etc.)
	 * 
	 * @param	game	The game this scene belongs to.
	 */
	public function load(game:Game) {
		this.game = game;
	}
	
	/**
	 * Unloads the scene. (Ressources, event listeners, etc.)
	 */
	public function unload() {
		this.removeChildren();
	}
	
}
