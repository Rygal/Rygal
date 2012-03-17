package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class RyTextureSequenceIterator {
	
	private var _sequence:RyTextureSequence;
	private var _looping:Bool;
	private var _nextId:Int;
	
	public function new(sequence:RyTextureSequence, looping:Bool=false) {
		_sequence = sequence;
		_looping = looping;
		_nextId = 0;
	}
	
	public function next():RyTexture {
		if (_looping && _nextId >= _sequence.length)
			_nextId = 0;
		
		return _sequence.get(_nextId++);
	}
	
	public function hasNext():Bool {
		return _looping || _nextId < _sequence.length;
	}
	
}