package net.robertboehm.rygal.util;
import nme.net.SharedObject;

/**
 * ...
 * @author Robert Böhm
 */

class RyStorage {
	
	private var object:SharedObject;
	
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
	
	public function get(key:String, defaultData:Dynamic=null):Dynamic {
		if (isset(key)) {
			return Reflect.field(object.data, key);
		} else {
			return defaultData;
		}
	}
	
}