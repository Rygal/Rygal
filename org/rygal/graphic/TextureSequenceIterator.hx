// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

/**
 * <h2>Description</h2>
 * <p>
 * 	An iterator that iterates through a texture sequence.
 * </p>
 * 
 * @author Robert Böhm
 */
class TextureSequenceIterator {
	
	/** Don't loop through a texture sequence. */
	public static var NO_LOOP:Int = 0;
	
	/** Infinitely loop through a texture sequence. */
	public static var INFINITE_LOOP:Int = -1;
	
	/** The sequence this iterator iterates through. */
	private var _sequence:TextureSequence;
	
	/** The amount of times this iterator iterates through the sequence. */
	private var _repeatCount:Int;
	
	/** The next ID of the sequence that will be used. */
	private var _nextId:Int;
	
	
	/**
	 * Creates a new iterator that iterates through the given sequence.
	 * 
	 * @param	sequence	The sequence the iterator will iterate through.
	 * @param	repeatCount	Amount of times the iterator will repeat iterating
	 * 						through the sequence. Use
	 * 						TextureSequenceIterator.INFINITE_LOOP for an
	 * 						infinite loop.
	 */
	public function new(sequence:TextureSequence, repeatCount:Int = 0) {
		_sequence = sequence;
		_repeatCount = repeatCount;
		_nextId = 0;
	}
	
	/**
	 * A dummy iterator that will basically only iterate through a single
	 * texture.
	 * 
	 * @param	texture		The texture this iterator will be using.
	 * @param	repeatCount	Amount of times the iterator will use the texture.
	 * 						Use TextureSequenceIterator.INFINITE_LOOP for an
	 * 						infinite loop.
	 */
	public static function fromSingleTexture(texture:Texture,
			repeatCount:Int = 0) {
		
		return new TextureSequenceIterator(new TextureSequence([texture]), repeatCount);
	}
	
	/**
	 * Returns the next texture in the sequence.
	 * 
	 * @return	The next texture in the sequence.
	 */
	public function next():Texture {
		if (_repeatCount != 0 && _nextId >= _sequence.length) {
			_nextId = 0;
			if(_repeatCount > 0)
				_repeatCount--;
		}
		
		return _sequence.get(_nextId++);
	}
	
	/**
	 * Determines if there's at least one texture left to iterate through.
	 * 
	 * @return	True if there's at least one texture left.
	 */
	public function hasNext():Bool {
		return _repeatCount != 0 || _nextId < _sequence.length;
	}
	
}