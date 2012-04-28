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
	
	
	/** The instance of the currently playing sound. */
	private var _currentSoundInstance:SoundInstance;
	
	/** The currently playing sound. */
	private var _currentSound:Sound;
	
	/** The index of the next sound. */
	private var _nextIndex:Int;
	
	/** The array with all _sounds. */
	private var _sounds:Array<Sound>;
	
	/** Determines if this jukebox is playing. */
	private var _running:Bool;
	
	
	/**
	 * Creates a new jukebox with the given playmode.
	 * 
	 * @param	mode	The playmode of this jukebox, by default it's looping.
	 */
	public function new(mode:Int = 0) {
		this.mode = mode;
		this._sounds = new Array<Sound>();
		this._nextIndex = 0;
	}
	
	/**
	 * Adds a sound to this jukebox.
	 * 
	 * @param	sound	The sound that will be added to the jukebox.
	 */
	public function addSound(sound:Sound):Void {
		if(sound != null)
			this._sounds.push(sound);
	}
	
	/**
	 * Removes a sound from this jukebox.
	 * 
	 * @param	sound	The sound that'll be removed.
	 */
	public function removeSound(sound:Sound):Void {
		this._sounds.remove(sound);
		if (_currentSound == sound) {
			nextSound();
		}
	}
	
	/**
	 * Forces the jukebox to play the next sound.
	 * Will be automatically called when a sound is played completely.
	 */
	public function nextSound():Void {
		if (this._sounds.length == 0) {
			stop();
		} else if (isRunning()) {
			if (mode == MODE_LOOP) {
				if (_nextIndex >= _sounds.length) {
					_nextIndex = 0;
				}
				_currentSound = _sounds[_nextIndex++];
				
			} else {
				_currentSound = _sounds[
						Std.int(Math.random() * _sounds.length)
					];
			}
			
			if (_currentSound != null) {
				_currentSoundInstance = _currentSound.play();
				if (_currentSoundInstance != null) {
					_currentSoundInstance.addEventListener(
						SoundEvent.SOUND_COMPLETE, onSoundComplete);
				} else {
					_running = false;
				}
			} else {
				_running = false;
			}
		}
	}
	
	/**
	 * Starts this jukebox.
	 */
	public function start():Void {
		if (!isRunning() && this._sounds.length > 0) {
			_running = true;
			this.nextSound();
		}
	}
	
	/**
	 * Stops this jukebox.
	 */
	public function stop():Void {
		if (isRunning()) {
			_running = false;
			if(_currentSoundInstance != null)
				_currentSoundInstance.stop();
			
			_currentSound = null;
			_currentSoundInstance = null;
			_nextIndex = 0;
		}
	}
	
	/**
	 * Determines if this jukebox is currently _running.
	 * 
	 * @return	True if this jukebox is _running.
	 */
	public function isRunning():Bool {
		return _running;
	}
	
	/**
	 * A callback that will be called as soon as the current sound has ended.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onSoundComplete(e:SoundEvent):Void {
		_currentSoundInstance.removeEventListener(SoundEvent.SOUND_COMPLETE,
			onSoundComplete);
		nextSound();
	}
	
}