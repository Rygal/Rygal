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
 * ...
 * @author Robert Böhm
 */

class Sound {
	
	private static var volume:Float = 1;
	
	private var sound:nme.media.Sound;
	
	public static function setVolume(volume:Float):Void {
		if (Sound.volume != volume) {
			Sound.volume = volume;
			SoundInstance.refreshVolumes();
		}
	}
	
	public static function getVolume():Float {
		return Sound.volume;
	}
	
	public static function fromAssets(id:String, alternatives:Array<String>=null):Sound {
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
	
	public function new(sound:nme.media.Sound) {
		this.sound = sound;
	}
	
	public function play(volume:Float=1, panning:Float=0, startTime:Float=0, loops:Int=0):SoundInstance {
		var st:SoundTransform = new SoundTransform(Sound.volume * volume, panning);
		var channel:SoundChannel = this.sound.play(startTime, loops, st);
		if (channel == null)
			return null;
		
		return new SoundInstance(channel, volume);
	}
	
}