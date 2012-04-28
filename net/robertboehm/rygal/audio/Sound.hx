// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;
import nme.Assets;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * <h2>Description</h2>
 * <p>
 * 	One Sound object contains a sound that can be played. Besides that, the
 * 	class also controls the global volume.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	var sound:Sound = Sound.fromAssets("assets/music.wav");<br />
 * 	sound.play();
 * </code>
 * 
 * @author Robert Böhm
 */
class Sound {
	
	/** The global volume. */
	private static var _volume:Float = 1;
	
	/** The internal nme.media.Sound object. */
	private var _sound:nme.media.Sound;
	
	
	/**
	 * Creates a new Sound based on a NME sound.
	 * 
	 * @param	sound	The NME sound.
	 */
	public function new(sound:nme.media.Sound) {
		this._sound = sound;
	}
	
	/**
	 * Sets the global volume.
	 * 
	 * @param	volume	The global volume. (0 = Silence, 1 = Full volume)
	 */
	public static function setVolume(volume:Float):Void {
		if (Sound._volume != volume) {
			Sound._volume = volume;
			SoundInstance.refreshVolumes();
		}
	}
	
	/**
	 * Returns the global volume.
	 * 
	 * @return	The global volume. (0 = Silence, 1 = Full volume)
	 */
	public static function getVolume():Float {
		return Sound._volume;
	}
	
	/**
	 * Returns a Sound object based on one or multiple asset IDs.
	 * You can use the parameter "alternatives" for alternative asset IDs, this
	 * function will then try to use one of these when the original one wouldn't
	 * work. This is due to format type restrictions on specific platforms.
	 * 
	 * @param	id				The asset ID to be used.
	 * @param	alternatives	Alternative asset IDs to be used if
	 * 							necessary.
	 * @return	A sound object based on the given asset IDs.
	 */
	public static function fromAssets(id:String,
			alternatives:Array<String> = null):Sound {
		
		var s:nme.media.Sound;
		
		try {
			s = Assets.getSound(id);
			if (s != null) {
				return new Sound(s);
			} else {
				throw "Wrong asset.";
			}
		} catch (e:Dynamic) {
			if (alternatives != null) {
				for (a in alternatives) {
					try {
						s = Assets.getSound(a);
						if (s != null) {
							return new Sound(s);
						} else {
							throw "Wrong asset.";
						}
					} catch (e:Dynamic) {}
				}
			}
		}
		
		return null;
	}
	
	/**
	 * Plays this sound.
	 * 
	 * @param	volume		The volume for this sound. Will automatically be
	 * 						merged with the global volume.
	 * 						(0 = Silence, 1 = Full volume)
	 * @param	panning		The panning for this sound.
	 * @param	startTime	The time where this sound shall start.
	 * @param	loops		The amount of loops this sound should perform.
	 * @return	A sound instance that can be used to - for instance - stop the
	 * 			sound.
	 */
	public function play(volume:Float = 1, panning:Float = 0,
			startTime:Float = 0, loops:Int = 0):SoundInstance {
		
		var st:SoundTransform =
			new SoundTransform(Sound._volume * volume, panning);
		
		var channel:SoundChannel = this._sound.play(startTime, loops, st);
		if (channel == null)
			return null;
		
		return new SoundInstance(channel, volume);
	}
	
}