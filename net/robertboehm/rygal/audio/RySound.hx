// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;
import nme.Assets;
import nme.media.Sound;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * ...
 * @author Robert Böhm
 */

class RySound {
	
	private static var volume:Float = 1;
	
	private var sound:Sound;
	
	public static function setVolume(volume:Float):Void {
		if (RySound.volume != volume) {
			RySound.volume = volume;
			RySoundInstance.refreshVolumes();
		}
	}
	
	public static function getVolume():Float {
		return RySound.volume;
	}
	
	public static function fromAssets(id:String, alternatives:Array<String>=null):RySound {
		var s:Sound;
		
		try {
			s = Assets.getSound(id);
			if (s != null) {
				return new RySound(s);
			} else {
				throw "Wrong asset.";
			}
		} catch (e:Dynamic) {
			if (alternatives != null) {
				for (a in alternatives) {
					try {
						s = Assets.getSound(a);
						if (s != null) {
							return new RySound(s);
						} else {
							throw "Wrong asset.";
						}
					} catch (e:Dynamic) {}
				}
			}
		}
		
		return null;
	}
	
	public function new(sound:Sound) {
		this.sound = sound;
	}
	
	public function play(volume:Float=1, panning:Float=0, startTime:Float=0, loops:Int=0):RySoundInstance {
		var st:SoundTransform = new SoundTransform(RySound.volume * volume, panning);
		return new RySoundInstance(this.sound.play(startTime, loops, st), volume);
	}
	
}