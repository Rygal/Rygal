// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;
import nme.events.Event;

/**
 * ...
 * @author Robert Böhm
 */

class SoundEvent extends Event {
	
	public static var SOUND_COMPLETE:String = "soundComplete";

	public function new(type:String) {
		super(type);
	}
	
}