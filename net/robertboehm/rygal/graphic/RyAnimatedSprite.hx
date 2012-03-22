package net.robertboehm.rygal.graphic;
import net.robertboehm.rygal.RyGameObject;
import net.robertboehm.rygal.RyGameTime;

/**
 * ...
 * @author Robert Böhm
 */

class RyAnimatedSprite extends RySprite {
	
	private var _animations:Hash<RyAnimation>;
	private var _currentAnimationName:String;
	private var _currentAnimation:RyAnimation;
	private var _currentIterator:RyTextureSequenceIterator;
	private var _elapsedMs:Int;

	public function new(x:Float=0, y:Float=0) {
		super(null, x, y);
		
		_animations = new Hash<RyAnimation>();
	}
	
	public function getCurrentAnimation():String {
		return _currentAnimationName;
	}
	
	public function getAnimation(name:String):RyAnimation {
		return _animations.get(name);
	}
	
	public function deregisterAnimation(name:String):Void {
		_animations.remove(name);
	}
	
	public function registerAnimation(name:String, animation:RyAnimation):Void {
		_animations.set(name, animation);
	}
	
	public function replay(animation:String, repeatCount:Int = 0):Void {
		_elapsedMs = -1;
		_currentAnimationName = animation;
		_currentAnimation = _animations.get(animation);
		_currentIterator = _currentAnimation.sequence.getIterator(repeatCount);
	}
	
	public function play(animation:String, repeatCount:Int=0):Void {
		if (_currentAnimationName == animation)
			return; // Nothing to do here!
		
		replay(animation, repeatCount);
	}
	
	public function loop(animation:String):Void {
		play(animation, RyTextureSequenceIterator.INFINITE_LOOP);
	}
	
	override public function update(time:RyGameTime):Void {
		super.update(time);
		
		if (_currentAnimation != null) {
			if (_elapsedMs < 0) {
				_elapsedMs = _currentAnimation.frameDelay;
			} else {
				_elapsedMs += time.elapsedMs;
			}
			
			while (_elapsedMs >= _currentAnimation.frameDelay) {
				_elapsedMs -= _currentAnimation.frameDelay;
				if (_currentIterator != null && _currentIterator.hasNext()) {
					setTexture(_currentIterator.next());
				} else {
					_currentIterator = null;
					_currentAnimationName = null;
					_currentAnimation = null;
				}
			}
		}
	}
	
}