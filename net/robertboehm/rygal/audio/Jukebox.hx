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
class Jukebox {
	
	/** Looping playmode. */
	public static var MODE_LOOP:Int = 0;
	
	/** Random playmode. */
	public static var MODE_RANDOM:Int = 1;
	
	/** Current playmode. */
	public var mode:Int;
	private var currentSoundInstance:SoundInstance;
	private var currentSound:Sound;
	private var nextIndex:Int;
	private var sounds:Array<Sound>;
	private var running:Bool;
	
	public function new(mode:Int=0) {
		this.mode = mode;
		this.sounds = new Array<Sound>();
		this.nextIndex = 0;
	}
	
	public function addSound(sound:Sound):Void {
		if(sound != null)
			this.sounds.push(sound);
	}
	
	public function removeSound(sound:Sound):Void {
		this.sounds.remove(sound);
		if (currentSound == sound) {
			nextSound();
		}
	}
	
	private function onSoundComplete(e:SoundEvent):Void {
		currentSoundInstance.removeEventListener(SoundEvent.SOUND_COMPLETE, onSoundComplete);
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
					currentSoundInstance.addEventListener(SoundEvent.SOUND_COMPLETE, onSoundComplete);
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