// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package net.robertboehm.rygal;

/**
 * ...
 * @author Robert Böhm
 */

class Error {
	
	private var message:String;
	
	public function new(?message:String) {
		this.message = message;
	}
	
	override public function toString():String {
		return Type.getClassName(Type.getClass(this)) + (message == null ? "" : ": " + message);
	}
	
}