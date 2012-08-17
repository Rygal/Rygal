// Copyright (C) 2012 Robert Böhm
// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

import org.rygal.GameTime;

/**
 * <h2>Description</h2>
 * <p>
 *  An animated sprite that is capable of playing animations.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 *  var spritesheet:Spritesheet = new Spritesheet(<br />
 *  &nbsp;&nbsp;Texture.fromAssets("assets/walkAnimation.png"), 4, 1);<br />
 *  <br />
 *  var sprite:AnimatedSprite = new AnimatedSprite();<br />
 *  sprite.registerAnimation("walk", Animation.fromSpritesheet(250, spritesheet));<br />
 *  sprite.loop("walk");
 * </code>
 * 
 * @author Robert Böhm
 */
class AnimatedSprite extends Sprite {
    
    /** A container for all registered animations. */
    private var _animations:Hash<Animation>;
    
    /** The name of the currently playing animation. */
    private var _currentAnimationName:String;
    
    /** The currently playing animation. */
    private var _currentAnimation:Animation;
    
    /** The sequence iterator for the currently playing animation. */
    private var _currentIterator:TextureSequenceIterator;
    
    /** The milliseconds left until the image gets changed again. */
    private var _elapsedMs:Int;
    
    
    /**
     * Creates a new animated sprite.
     * 
     * @param   x   The initial x-coordinate.
     * @param   y   The initial y-coordinate.
     */
    public function new(x:Float = 0, y:Float = 0) {
        super(null, x, y);
        
        _animations = new Hash<Animation>();
    }
    
    
    /**
     * Returns the name of the currently playing animation.
     * 
     * @return  The name of the currently playing animation.
     */
    public function getCurrentAnimation():String {
        return _currentAnimationName;
    }
    
    /**
     * Returns the animation with the given name.
     * 
     * @param   name    The name of the requested animation.
     * @return  The animation with the given name.
     */
    public function getAnimation(name:String):Animation {
        return _animations.get(name);
    }
    
    /**
     * Registers the animation with a given name.
     * 
     * @param   name        The name of the animation.
     * @param   animation   The animation to be registered.
     */
    public function registerAnimation(name:String, animation:Animation):Void {
        _animations.set(name, animation);
    }
    
    /**
     * Deregisters the animation with the given name.
     * 
     * @param   name    The name of the animation to be deregistered.
     */
    public function deregisterAnimation(name:String):Void {
        _animations.remove(name);
    }
    
    /**
     * Forces the given animation to play. This will replay the animation if it
     * is already playing.
     * 
     * @param   animation   The name of the animation to be played.
     * @param   repeatCount The amount of replays, use
     *                      TextureSequenceIterator.INFINITE_LOOP for an
     *                      infinite loop.
     */
    public function forcePlay(animation:String, repeatCount:Int = 0):Void {
        _elapsedMs = -1;
        _currentAnimationName = animation;
        _currentAnimation = _animations.get(animation);
        _currentIterator = _currentAnimation.sequence.getIterator(repeatCount);
    }
    
    /**
     * Plays the given animation. If the animation is already playing, it will
     * do nothing.
     * 
     * @param   animation   The name of the animation to be played.
     * @param   repeatCount The amount of replays, use
     *                      TextureSequenceIterator.INFINITE_LOOP for an
     *                      infinite loop.
     */
    public function play(animation:String, repeatCount:Int = 0):Void {
        if (_currentAnimationName == animation)
            return; // Nothing to do here!
        
        forcePlay(animation, repeatCount);
    }
    
    /**
     * Loops the given animation.
     * 
     * @param   animation   The name of the animation to be looped.
     */
    public function loop(animation:String):Void {
        play(animation, TextureSequenceIterator.INFINITE_LOOP);
    }
    
    /**
     * Updates this animated sprite, which means it continues playing.
     * 
     * @param   time    The time elapsed since the last update.
     */
    override public function update(time:GameTime):Void {
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
                    this.texture = _currentIterator.next();
                } else {
                    _currentIterator = null;
                    _currentAnimationName = null;
                    _currentAnimation = null;
                    break;
                }
            }
        }
    }
    
}
