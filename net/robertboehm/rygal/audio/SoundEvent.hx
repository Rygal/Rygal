// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;

import nme.events.Event;

/**
 * <h2>Description</h2>
 * <p>
 * 	A sound event.
 * </p>
 * 
 * @author Robert Böhm
 */
class SoundEvent extends Event {
	
	/** An event that will be called when the sound is complete. */
	public static var SOUND_COMPLETE:String = "soundComplete";
	
	/**
	 * Creates a new sound event.
	 * 
	 * @param	type	The type of this event.
	 */
	public function new(type:String) {
		super(type);
	}
	
}