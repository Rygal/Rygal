// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.audio;

import nme.events.Event;
import nme.events.EventDispatcher;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * <h2>Description</h2>
 * <p>
 * 	An instance of a sound. Will be created by the method "play" of the class
 * 	Sound.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	function onSoundComplete(e:SoundEvent):Void {<br />
 * 	&nbsp;&nbsp;trace("Sound completed!");<br />
 * 	}<br />
 * 	<br />
 * 	function init():Void {<br />
 * 	&nbsp;&nbsp;var sound:Sound = Sound.fromAssets("assets/music.wav");<br />
 * 	&nbsp;&nbsp;var soundInstance:SoundInstance = sound.play();<br />
 * 	&nbsp;&nbsp;soundInstance.addEventListener(SoundEvent.SOUND_COMPLETE,
 * 					onSoundComplete);<br />
 * 	&nbsp;&nbsp;soundInstance.stop();<br />
 * 	}
 * </code>
 * 
 * 
 * @author Robert Böhm
 */
class SoundInstance extends EventDispatcher {
	
	/** An array with all currently playing sound instances. */
	private static var _instances:Array<SoundInstance> =
		new Array<SoundInstance>();
	
	
	/** The sound channel this sound instance is based on. */
	private var _channel:SoundChannel;
	
	/** The volume of this instance. (0 = Silence, 1 = Full volume) */
	private var _volume:Float;
	
	
	/**
	 * Creates a new sound instance, based on the given channel and with the
	 * given volume.
	 * 
	 * @param	channel	The sound channel this sound instance is based on.
	 * @param	volume	The volume of this instance.
	 */
	public function new(channel:SoundChannel, volume:Float) {
		super();
		
		_instances.push(this);
		this._channel = channel;
		if (this._channel.soundTransform == null)
			this._channel.soundTransform = new SoundTransform();
		
		this._channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		this.setVolume(volume);
	}
	
	/**
	 * Refreshes the volumes of all currently playing sound instances.
	 */
	public static function refreshVolumes():Void {
		for (instance in _instances) {
			instance.refreshVolume();
		}
	}
	
	/**
	 * Defines the volume of this sound instance.
	 * 
	 * @param	volume	The volume of this sound instance.
	 * 					(0 = Silence, 1 = Full volume)
	 */
	public function setVolume(volume:Float):Void {
		this._volume = volume;
		this.refreshVolume();
	}
	
	/**
	 * Returns the volume of this sound instance.
	 * 
	 * @return	The volume of this sound instance.
	 * 			(0 = Silence, 1 = Full volume)
	 */
	public function getVolume():Float {
		return this._volume;
	}
	
	/**
	 * Stops this sound instance, you cannot resume playing!
	 */
	public function stop():Void {
		this._channel.dispatchEvent(new Event(Event.SOUND_COMPLETE));
		this._channel.stop();
	}
	
	/**
	 * Refreshes the volume of this sound instance.
	 * This includes merging the local volume with the global volume.
	 */
	private function refreshVolume():Void {
		this._channel.soundTransform = new SoundTransform(
			this._volume * Sound.getVolume(), this._channel.soundTransform.pan);
	}
	
	/**
	 * A callback that will be called as soon as this sound has ended.
	 * 
	 * @param	e	Event parameters.
	 */
	private function onSoundComplete(e:Event):Void {
		this._channel.removeEventListener(Event.SOUND_COMPLETE,
			onSoundComplete);
		
		this.dispatchEvent(new SoundEvent(SoundEvent.SOUND_COMPLETE));
		_instances.remove(this);
	}
	
}