// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.graphic;

/**
 * ...
 * @author Robert Böhm
 */

class TextureSequenceIterator {
	
	public static var NO_LOOP:Int = 0;
	public static var INFINITE_LOOP:Int = -1;
	
	private var _sequence:TextureSequence;
	private var _repeatCount:Int;
	private var _nextId:Int;
	
	/**
	 * 
	 * @param	sequence
	 * @param	loopCount	Amount of times this animation is repeated. Use -1 for infinite loop.
	 */
	public function new(sequence:TextureSequence, repeatCount:Int=0) {
		_sequence = sequence;
		_repeatCount = repeatCount;
		_nextId = 0;
	}
	
	public static function fromSingleTexture(texture:Texture, repeatCount:Int=0) {
		return new TextureSequenceIterator(new TextureSequence([texture]), repeatCount);
	}
	
	public function next():Texture {
		if (_repeatCount != 0 && _nextId >= _sequence.length) {
			_nextId = 0;
			if(_repeatCount > 0)
				_repeatCount--;
		}
		
		return _sequence.get(_nextId++);
	}
	
	public function hasNext():Bool {
		return _repeatCount != 0 || _nextId < _sequence.length;
	}
	
}