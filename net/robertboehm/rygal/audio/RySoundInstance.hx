// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.audio;
import nme.events.Event;
import nme.events.EventDispatcher;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * ...
 * @author Robert Böhm
 */

class RySoundInstance extends EventDispatcher {
	
	private static var instances:Array<RySoundInstance> = new Array<RySoundInstance>();
	
	private var channel:SoundChannel;
	private var volume:Float;
	
	public static function refreshVolumes():Void {
		for (instance in instances) {
			instance.refreshVolume();
		}
	}
	
	public function new(channel:SoundChannel, volume:Float) {
		super();
		
		instances.push(this);
		this.channel = channel;
		if (this.channel.soundTransform == null)
			this.channel.soundTransform = new SoundTransform();
		
		this.channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		this.setVolume(volume);
	}
	
	private function onSoundComplete(e:Event):Void {
		this.channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		this.dispatchEvent(new RySoundEvent(RySoundEvent.SOUND_COMPLETE));
		instances.remove(this);
	}
	
	public function setVolume(volume:Float):Void {
		this.volume = volume;
		this.refreshVolume();
	}
	
	public function refreshVolume():Void {
		this.channel.soundTransform = new SoundTransform(this.volume * RySound.getVolume(), this.channel.soundTransform.pan);
	}
	
	public function getVolume():Float {
		return this.volume;
	}
	
	public function stop():Void {
		this.channel.dispatchEvent(new Event(Event.SOUND_COMPLETE));
		this.channel.stop();
	}
	
}