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

class RyInvalidArgumentError extends RyError {

	public function new(?message:String) {
		super(message);
	}
	
}