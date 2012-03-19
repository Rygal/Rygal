// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyScene extends RyGameObjectContainer {
	
	public var game:RyGame;

	public function new() {
		super();
	}
	
	public function load(game:RyGame) {
		this.game = game;
	}
	
	public function unload() {
	}
	
}
