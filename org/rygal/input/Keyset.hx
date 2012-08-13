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

/**
 * ...
 * @author Robert Böhm
 */
class Keyset {
	
	public static inline var NONE:Int = -1;
	
	public static inline var NORTH:Int = 0;
	public static inline var EAST:Int = 1;
	public static inline var SOUTH:Int = 2;
	public static inline var WEST:Int = 3;
	public static inline var NORTHEAST:Int = 4;
	public static inline var SOUTHEAST:Int = 5;
	public static inline var SOUTHWEST:Int = 6;
	public static inline var NORTHWEST:Int = 7;
	
	
	private var keyN:Int = NONE;
	private var keyE:Int = NONE;
	private var keyS:Int = NONE;
	private var keyW:Int = NONE;
	private var keyNE:Int = NONE;
	private var keySE:Int = NONE;
	private var keySW:Int = NONE;
	private var keyNW:Int = NONE;
	
	
	public function new() {
	}
	
	
	public static function getNumpad():Keyset {
		return new Keyset()
			.setKey(Keyset.NORTH, Keys.NUMPAD_8)
			.setKey(Keyset.NORTHEAST, Keys.NUMPAD_9)
			.setKey(Keyset.EAST, Keys.NUMPAD_6)
			.setKey(Keyset.SOUTHEAST, Keys.NUMPAD_3)
			.setKey(Keyset.SOUTH, Keys.NUMPAD_2)
			.setKey(Keyset.SOUTHWEST, Keys.NUMPAD_1)
			.setKey(Keyset.WEST, Keys.NUMPAD_4)
			.setKey(Keyset.NORTHWEST, Keys.NUMPAD_7);
	}
	
	public static function getWASD():Keyset {
		return new Keyset()
			.setKey(Keyset.NORTH, Keys.W)
			.setKey(Keyset.EAST, Keys.D)
			.setKey(Keyset.SOUTH, Keys.S)
			.setKey(Keyset.WEST, Keys.A);
	}
	
	public static function getIJKL():Keyset {
		return new Keyset()
			.setKey(Keyset.NORTH, Keys.I)
			.setKey(Keyset.EAST, Keys.J)
			.setKey(Keyset.SOUTH, Keys.K)
			.setKey(Keyset.WEST, Keys.L);
	}
	
	public static function getArrowKeys():Keyset {
		return new Keyset()
			.setKey(Keyset.NORTH, Keys.UP)
			.setKey(Keyset.EAST, Keys.RIGHT)
			.setKey(Keyset.SOUTH, Keys.DOWN)
			.setKey(Keyset.WEST, Keys.LEFT);
	}
	
	
	public function getKey(direction:Int):Int {
		return switch(direction) {
			case NORTH:		this.keyN;
			case EAST:		this.keyE;
			case SOUTH:		this.keyS;
			case WEST:		this.keyW;
			case NORTHEAST:	this.keyNE;
			case SOUTHEAST:	this.keySE;
			case SOUTHWEST:	this.keySW;
			case NORTHWEST:	this.keyNW;
			default:		Keyset.NONE;
		}
	}
	
	public function setKey(direction:Int, key:Int):Keyset {
		switch(direction) {
			case NORTH:		this.keyN = key;
			case EAST:		this.keyE = key;
			case SOUTH:		this.keyS = key;
			case WEST:		this.keyW = key;
			case NORTHEAST:	this.keyNE = key;
			case SOUTHEAST:	this.keySE = key;
			case SOUTHWEST:	this.keySW = key;
			case NORTHWEST:	this.keyNW = key;
		}
		return this;
	}
	
}