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


package org.rygal.net;

import nme.events.Event;
import nme.utils.ByteArray;

/**
 * <h2>Description</h2>
 * <p>
 *  An event related to networking.
 * </p>
 * 
 * @author Robert Böhm
 */
class NetworkEvent extends Event {
    
    /** An error that may be raised due to an unsupported platform. */
    public static inline var REASON_UNSUPPORTED_PLATFORM:String =
        "Unsupported platform";
    
    /** An error that may be raised when writing failed. */
    public static inline var REASON_WRITE_FAILED:String =
        "Write failed";
    
    /** An error that may be raised when reading failed. */
    public static inline var REASON_READ_FAILED:String =
        "Read failed";
    
    /** An error that may be raised when connecting failed. */
    public static inline var REASON_CONNECT_FAILED:String =
        "Connect failed";
    
    /** An error that may be raised when disconnecting failed. */
    public static inline var REASON_DISCONNECT_FAILED:String =
        "Disconnect failed";
    
    
    /** An event that will be called when a socket has been connected. */
    public static inline var CONNECTED:String = "connected";
    
    /** An event that will be called when a socket has been disconnected. */
    public static inline var DISCONNECTED:String = "disconnected";
    
    /** An event that will be called when data was received. */
    public static inline var DATA:String = "data";
    
    /** An event that will be called when an error occured. */
    public static inline var ERROR:String = "error";
    
    
    /** Received data. (Only available on NetworkEvent.DATA) */
    public var data(default, null):ByteArray;
    
    /** Error reason. (Only available on NetworkEvent.ERROR) */
    public var reason(default, null):String;
    
    
    /**
     * Creates a new NetworkEvent with the given properties.
     * 
     * @param   type    The type of this event. You may only use constants from
     *                  NetworkEvent, e.g. NetworkEvent.CONNECT.
     * @param   reason  The reason for an error. (Only available on
     *                  NetworkEvent.ERROR)
     * @param   ?data   Received data. (Only available on NetworkEvent.DATA)
     */
    public function new(type:String, reason:String = "", ?data:ByteArray) {
        super(type);
        
        this.reason = reason;
        this.data = data;
    }
    
}
