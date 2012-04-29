// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.util;

#if !js
import nme.net.SharedObject;
#end

/**
 * <h2>Description</h2>
 * <p>
 * 	A class that manages data storage that is persistent over time, thus it can
 * 	be used for storing configuration data, savegames, etc.
 * </p>
 * 
 * <h2>Example (Writing)</h2>
 * <code>
 * 	var name:String = "John Doe";<br />
 * 	var settings:Storage = new Storage("settings");<br />
 * 	settings.put("name", name);<br />
 * 	settings.close();
 * </code>
 * 
 * <h2>Example (Reading)</h2>
 * <code>
 * 	var settings:Storage = new Storage("settings");<br />
 * 	var name:String = settings.get("name", "Anonymous");<br />
 * 	settings.close();
 * </code>
 * 
 * @author Robert Böhm
 */
class Storage {
	#if js
	
	// NME/HTML5 doesn't support SharedObject.
	public function new(name:String) {}
	public static function canStore():Bool { return false; }
	public function clear():Void {}
	public function isset(key:String):Bool { return false; }
	public function unset(key:String):Void {}
	public function put(key:String, data:Dynamic):Void {}
	public function get(key:String, defaultData:Dynamic = null):Dynamic {
		return defaultData;
	}
	public function close():Void {}
	
	#else
	
	/** The internal shared object this storage is based on. */
	private var _object:SharedObject;
	
	
	/**
	 * Creates a new Storage-object with the given name.
	 * 
	 * @param	name	The name of this storage-object. To regain access to
	 * 					this storage data, you have to use the identical name.
	 */
	public function new(name:String) {
		_object = SharedObject.getLocal(name);
	}
	
	/**
	 * Determines if this storage is able to hold data.
	 * 
	 * @return	True, except you're compiling for an unsupported platform.
	 */
	public static function canStore():Bool {
		return true;
	}
	
	/**
	 * Clears the data of this storage object.
	 */
	public function clear():Void {
		_object.clear();
		_object.flush();
	}
	
	/**
	 * Determines if the given value is already defined.
	 * 
	 * @param	key	The name of the value.
	 * @return	True if the value is already defined.
	 */
	public function isset(key:String):Bool {
		return Reflect.hasField(_object.data, key);
	}
	
	/**
	 * Undefines the given value.
	 * 
	 * @param	key	The name of the value.
	 */
	public function unset(key:String):Void {
		Reflect.deleteField(_object.data, key);
		_object.flush();
	}
	
	/**
	 * Fills the given value with the given data.
	 * 
	 * @param	key		The name of the value.
	 * @param	data	The data that will be stored.
	 */
	public function put(key:String, data:Dynamic):Void {
		Reflect.setField(_object.data, key, data);
		_object.flush();
	}
	
	/**
	 * Closes this storage object, which means you shouldn't modify the data
	 * unless you create a new storage object with the same name.
	 */
	public function close():Void {
		_object.close();
	}
	
	/**
	 * Returns the data of the given value.
	 * @param	key			The name of the value.
	 * @param	defaultData	The default data. (Will be returned in case the data
	 * 						isn't defined yet)
	 * @return	The stored data or the default data if necessary.
	 */
	public function get(key:String, defaultData:Dynamic=null):Dynamic {
		if (isset(key)) {
			return Reflect.field(_object.data, key);
		} else {
			return defaultData;
		}
	}
	
	#end
	
}