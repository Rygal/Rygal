// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import net.robertboehm.rygal.graphic.RyCanvas;
import net.robertboehm.rygal.graphic.RySprite;
import net.robertboehm.rygal.input.RyMouseEvent;

/**
 * ...
 * @author Robert Böhm
 */

class RyDefaultPauseScreen extends RyScene {

	public function new() {
		super();
	}
	
	override public function load(game:RyGame) {
		super.load(game);
		
		game.mouse.addEventListener(RyMouseEvent.MOUSE_DOWN, onMouseDown);
		
		var c:RyCanvas = RyCanvas.create(game.width, game.height, true, 0x55000000);
		this.addChild(new RySprite(c.toTexture()));
	}
	
	override public function unload() {
		game.mouse.removeEventListener(RyMouseEvent.MOUSE_DOWN, onMouseDown);
		
		super.unload();
	}
	
	private function onMouseDown(e:RyMouseEvent):Void {
		game.unpause();
	}
	
	
}