// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

/**
 * <h2>Description</h2>
 * <p>
 * 	A generic error class.
 * </p>
 * <p>
 * 	Note: The error system is not implemented yet!
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * 	try {<br />
 * 	&nbsp;&nbsp;throw new Error("Something happened!");<br />
 * 	} catch(e:Error) {<br />
 * 	&nbsp;&nbsp;// You're screwed!<br />
 * 	}
 * </code>
 * 
 * @author Robert Böhm
 */
class Error {
	
	/** The message of this error. */
	private var _message:String;
	
	
	/**
	 * Creates a new error.
	 * 
	 * @param	?message	A message for this error.
	 */
	public function new(?message:String) {
		this._message = message;
	}
	
	/**
	 * Returns this error, formatted as a string.
	 * 
	 * @return	This error as a string.
	 */
	public function toString():String {
		return Type.getClassName(Type.getClass(this)) +
			(_message == null ? "" : ": " + _message);
	}
	
}