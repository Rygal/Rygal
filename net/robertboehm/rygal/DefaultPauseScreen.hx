// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;
import net.robertboehm.rygal.graphic.Canvas;
import net.robertboehm.rygal.graphic.Sprite;
import net.robertboehm.rygal.input.MouseEvent;

/**
 * ...
 * @author Robert Böhm
 */

class DefaultPauseScreen extends Scene {

	public function new() {
		super();
	}
	
	override public function load(game:Game) {
		super.load(game);
		
		game.mouse.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		var c:Canvas = Canvas.create(game.width, game.height, true, 0x55000000);
		this.addChild(new Sprite(c.toTexture()));
	}
	
	override public function unload() {
		game.mouse.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		super.unload();
	}
	
	private function onMouseDown(e:MouseEvent):Void {
		game.unpause();
	}
	
	
}