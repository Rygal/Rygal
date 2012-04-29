// Copyright (C) 2012 Robert Böhm
// This file is part of Rygal.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal;

/**
 * <h2>Description</h2>
 * <p>
 * 	An error to be thrown whenever the arguments were invalid.
 * </p>
 * <p>
 * 	Note: The error system is not implemented yet!
 * </p>
 * 
 * @author Robert Böhm
 */
class InvalidArgumentError extends Error {
	
	/**
	 * Creates a new InvalidArgumentError with the given message.
	 * 
	 * @param	?message	A message for this error.
	 */
	public function new(?message:String) {
		super(message);
	}
	
}