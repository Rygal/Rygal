// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;

/**
 * A jukebox that plays music in the background.
 * 
 * @author Robert Böhm
 */

class RyJukebox {
	
	/**
	 * Looping playmode.
	 * 
	 * @see mode
	 */
	public static var MODE_LOOP:Int = 0;
	
	/**
	 * Random playmode.
	 * 
	 * @see mode
	 */
	public static var MODE_RANDOM:Int = 1;
	
	/**
	 * Current playmode.
	 * 
	 * @see MODE_LOOP
	 * @see MODE_RANDOM
	 */
	public var mode:Int;
	private var currentSoundInstance:RySoundInstance;
	private var currentSound:RySound;
	private var nextIndex:Int;
	private var sounds:Array<RySound>;
	private var running:Bool;
	
	public function new(mode:Int=0) {
		this.mode = mode;
		this.sounds = new Array<RySound>();
		this.nextIndex = 0;
	}
	
	public function addSound(sound:RySound):Void {
		if(sound != null)
			this.sounds.push(sound);
	}
	
	public function removeSound(sound:RySound):Void {
		this.sounds.remove(sound);
		if (currentSound == sound) {
			nextSound();
		}
	}
	
	private function onSoundComplete(e:RySoundEvent):Void {
		currentSoundInstance.removeEventListener(RySoundEvent.SOUND_COMPLETE, onSoundComplete);
		nextSound();
	}
	
	public function nextSound():Void {
		if (this.sounds.length == 0) {
			stop();
		} else if (isRunning()) {
			if (mode == MODE_LOOP) {
				if (nextIndex >= sounds.length) {
					nextIndex = 0;
				}
				currentSound = sounds[nextIndex++];
				
			} else {
				currentSound = sounds[Std.int(Math.random() * sounds.length)];
			}
			
			if (currentSound != null) {
				currentSoundInstance = currentSound.play();
				if (currentSoundInstance != null) {
					currentSoundInstance.addEventListener(RySoundEvent.SOUND_COMPLETE, onSoundComplete);
				} else {
					running = false;
				}
			} else {
				running = false;
			}
		}
	}
	
	public function start():Void {
		if (!isRunning() && this.sounds.length > 0) {
			running = true;
			this.nextSound();
		}
	}
	
	public function stop():Void {
		if (isRunning()) {
			running = false;
			if(currentSoundInstance != null)
				currentSoundInstance.stop();
			
			currentSound = null;
			currentSoundInstance = null;
			nextIndex = 0;
		}
	}
	
	public function isRunning():Bool {
		return running;
	}
	
}