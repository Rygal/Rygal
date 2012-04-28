// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal.util;

#if !js
import nme.net.SharedObject;
#end

/**
 * ...
 * @author Robert Böhm
 */

class Storage {
	#if js
	
	public static function canStore():Bool { return false; }
	
	public function new(name:String) {}
	
	public function clear():Void {}
	
	public function isset(key:String):Bool { return false; }
	
	public function unset(key:String):Void {}
	
	public function put(key:String, data:Dynamic):Void {}
	
	public function get(key:String, defaultData:Dynamic = null):Dynamic { return defaultData; }
	
	public function close():Void {}
	
	#else
	
	private var object:SharedObject;
	
	public function canStore():Bool {
		return true;
	}
	
	public function new(name:String) {
		object = SharedObject.getLocal(name);
	}
	
	public function clear():Void {
		object.clear();
		object.flush();
	}
	
	public function isset(key:String):Bool {
		return Reflect.hasField(object.data, key);
	}
	
	public function unset(key:String):Void {
		Reflect.deleteField(object.data, key);
		object.flush();
	}
	
	public function put(key:String, data:Dynamic):Void {
		Reflect.setField(object.data, key, data);
		object.flush();
	}
	
	public function close():Void {
		object.close();
	}
	
	public function get(key:String, defaultData:Dynamic=null):Dynamic {
		if (isset(key)) {
			return Reflect.field(object.data, key);
		} else {
			return defaultData;
		}
	}
	
	#end
	
}