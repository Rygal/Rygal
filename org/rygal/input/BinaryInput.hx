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


package org.rygal.input;

import org.rygal.Game;
import org.rygal.util.Storage;

/**
 * ...
 * @author Robert Böhm
 */
class BinaryInput extends Input {
	
	private var keyBindings:List<Int>;
	private var mouseBindings:List<Int>;
	
	public function new(game:Game, name:String) {
		super(game, name);
		
		this.keyBindings = new List<Int>();
		this.mouseBindings = new List<Int>();
	}
	
	
	public function bindMousebutton(key:Int):Void {
		this.mouseBindings.push(key);
	}
	
	public function bindKey(key:Int):Void {
		this.keyBindings.push(key);
	}
	
	public function reset():Void {
		this.keyBindings.clear();
		this.mouseBindings.clear();
	}
	
	override public function connect(storage:Storage):Void {
		super.connect(storage);
		
		
	}
	
}