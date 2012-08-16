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

import nme.errors.Error;
import nme.events.Event;
import nme.events.EventDispatcher;
import nme.events.IOErrorEvent;
import nme.events.ProgressEvent;
import nme.utils.ByteArray;
import org.rygal.graphic.Canvas;
import org.rygal.GameObject;
import org.rygal.GameTime;

#if flash
import flash.net.Socket;
#elseif cpp
import haxe.io.Bytes;
import sys.net.Socket;
import sys.net.Host;
import cpp.vm.Thread;
import cpp.vm.Mutex;
#end

/**
 * <h2>Description</h2>
 * <p>
 * 	An event-based TCP-Client for Flash and C++.
 * </p>
 * 
 * @author Robert Böhm
 */
class TcpClient extends EventDispatcher, implements GameObject {
	
	/** The x-coordinate of this object. */
	public var x:Float;
	
	/** The y-coordinate of this object. */
	public var y:Float;
	
	/** The parent of this object. */
	public var parent:GameObject;
	
	/** Determines whether or not this client is connected to any server. */
	public var connected(default, null):Bool;
	
	
	#if (cpp || flash)
	/** The socket this client is based on. */
	private var _socket:Socket;
	#end
	
	#if cpp
	/** The mutex used to synchronize any socket-related actions. */
	private var _socketMutex:Mutex;
	
	/** Determines if this client has just been disconnected. */
	private var _justDisconnected:Bool = false;
	
	/** Determines if this client has just been connected. */
	private var _justConnected:Bool = false;
	
	/** Determines an possible error the client just had. */
	private var _recentError:String = null;
	#end
	
	
	/**
	 * Creates a new TCP-Client.
	 */
	public function new() {
		super();
		
		connected = false;
		
		#if (cpp || flash)
		_socket = new Socket();
		#end
		
		#if flash
		_socket.addEventListener(Event.CONNECT, onConnect);
		_socket.addEventListener(Event.CLOSE, onDisconnect);
		_socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		_socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
		#elseif cpp
		_socketMutex = new Mutex();
		
		try {
			_socket.setFastSend(true);
		} catch(e:Dynamic) {}
		#end
	}
	
	
	/**
	 * Returns the absolute x-coordinate of this object.
	 * 
	 * @return	The absolute x-coordinate of this object.
	 */
	public function getAbsoluteX():Float {
		return parent != null ? this.x + parent.x : this.x;
	}
	
	/**
	 * Returns the absolute y-coordinate of this object.
	 * 
	 * @return	The absolute y-coordinate of this object.
	 */
	public function getAbsoluteY():Float {
		return parent != null ? this.y + parent.y : this.y;
	}
	
	/**
	 * Updates this object and executes game logic.
	 * 
	 * @param	time	The time elapsed since the last update.
	 */
	public function update(time:GameTime):Void {
		tick();
	}
	
	/**
	 * Draws this object on the given screen.
	 * 
	 * @param	screen	The screen this object will be drawn on.
	 */
	public function draw(screen:Canvas):Void {}
	
	/**
	 * Updates this TCP-Client, raises events and reads possible data.
	 */
	public function tick():Void {
		#if cpp
		if (_justConnected) {
			_justConnected = false;
			this.dispatchEvent(new NetworkEvent(NetworkEvent.CONNECTED));
		}
		if (_justDisconnected) {
			_justDisconnected = false;
			this.dispatchEvent(new NetworkEvent(NetworkEvent.DISCONNECTED));
		}
		if (_recentError != null) {
			this.dispatchEvent(
				new NetworkEvent(NetworkEvent.ERROR, _recentError));
			_recentError = null;
		}
		
		if (connected && _socketMutex.tryAcquire()) {
			try {
				var bytes:Bytes = _socket.input.readAll();
				if (bytes.length > 0) {
					var data:ByteArray = new ByteArray();
					for (i in 0...bytes.length) {
						data.writeByte(bytes.get(i));
					}
					this.dispatchEvent(
						new NetworkEvent(NetworkEvent.DATA, "", data));
				}
			} catch (e:Dynamic) {
				// To avoid recursions, just set the flag that an error occured:
				_recentError = NetworkEvent.REASON_READ_FAILED;
			}
			_socketMutex.release();
		}
		#end
	}
	
	/**
	 * Connects this client to the given end-point.
	 * 
	 * @param	host	The host to be connected to.
	 * @param	port	The port to be connected to.
	 */
	public function connect(host:String, port:Int):Void {
		#if flash
		if (!this.connected) {
			_socket.connect(host, port);
		}
		
		#elseif cpp
		var t:Thread = Thread.create(doConnect);
		t.sendMessage(host);
		t.sendMessage(port);
		
		#else
		this.dispatchEvent(new NetworkEvent(NetworkEvent.ERROR,
			NetworkEvent.REASON_UNSUPPORTED_PLATFORM));
		#end
	}
	
	/**
	 * Disconnects this client.
	 */
	public function disconnect():Void {
		#if flash
		if (this.connected) {
			_socket.close();
			onDisconnect();
		}
		
		#elseif cpp
		Thread.create(doDisconnect);
		
		#else
		this.dispatchEvent(new NetworkEvent(NetworkEvent.ERROR,
			NetworkEvent.REASON_UNSUPPORTED_PLATFORM));
		#end
	}
	
	/**
	 * Writes the specified data to the server.
	 * 
	 * @param	packet	The data to be sent.
	 * @param	offset	The offset of the data to be sent.
	 * @param	length	The length of the data to be sent.
	 */
	public function write(packet:ByteArray, offset:Int = 0,
			length:Int = 0):Void {
		
		if (!connected)
			return;
		
		#if flash
		
		_socket.writeBytes(packet, offset, length);
		_socket.flush();
		
		#elseif cpp
		
		_socketMutex.acquire();
		try {
			if (length == 0)
				length = packet.length - offset;
			
			packet.position = offset;
			
			var bytes:Bytes = Bytes.alloc(length);
			for (i in 0...length) {
				bytes.set(i, packet.readByte());
			}
			_socket.output.write(bytes);
			_socket.output.flush();
			
		} catch (e:Dynamic) {
			// To avoid recursions, just set the flag that an error occured:
			_recentError = NetworkEvent.REASON_WRITE_FAILED;
		}
		_socketMutex.release();
		
		#else
		this.dispatchEvent(new NetworkEvent(NetworkEvent.ERROR,
			NetworkEvent.REASON_UNSUPPORTED_PLATFORM));
		
		#end
	}
	
	
	#if flash
	
	/**
	 * An event that gets called whenever the underlying socket has been
	 * connected.
	 * 
	 * @param	?e	Event arguments.
	 */
	private function onConnect(?e:Event):Void {
		connected = true;
		this.dispatchEvent(new NetworkEvent(NetworkEvent.CONNECTED));
	}
	
	/**
	 * An event that gets called whenever the underlying socket has been
	 * disconnected.
	 * 
	 * @param	?e	Event arguments.
	 */
	private function onDisconnect(?e:Event):Void {
		connected = false;
		this.dispatchEvent(new NetworkEvent(NetworkEvent.DISCONNECTED));
	}
	
	/**
	 * An event that gets called whenever the underlying socket receives data.
	 * 
	 * @param	?e	Event arguments.
	 */
	private function onData(?e:ProgressEvent):Void {
		var data:ByteArray = new ByteArray();
		
		_socket.readBytes(data);
		
		this.dispatchEvent(new NetworkEvent(NetworkEvent.DATA, "", data));
	}
	
	/**
	 * An event that gets called whenever the underlying socket throws an error.
	 * 
	 * @param	?e	Event arguments.
	 */
	private function onError(e:IOErrorEvent):Void {
		// Only errors while connecting are known
		this.dispatchEvent(new NetworkEvent(NetworkEvent.ERROR,
			NetworkEvent.REASON_CONNECT_FAILED));
	}
	
	#elseif cpp
	
	/**
	 * Connects this client to a specified server.
	 */
	private function doConnect():Void {
		_socketMutex.acquire();
		if (!connected) {
			try {
				var host:String = Thread.readMessage(true);
				var port:Int = Thread.readMessage(true);
				
				_socket.connect(new Host(host), port);
				_socket.setBlocking(false);
				connected = true;
				_justConnected = true;
			} catch (e:Dynamic) {
				_recentError = NetworkEvent.REASON_CONNECT_FAILED;
			}
		}
		_socketMutex.release();
	}
	
	/**
	 * Disconnects this client.
	 */
	private function doDisconnect():Void {
		_socketMutex.acquire();
		if (connected) {
			try {
				_socket.close();
				_socket = new Socket();
				try {
					_socket.setFastSend(true);
				} catch(e:Dynamic) {}
				
				connected = false;
				_justDisconnected = true;
			} catch (e:Dynamic) {
				_recentError = NetworkEvent.REASON_DISCONNECT_FAILED;
			}
		}
		_socketMutex.release();
	}
	
	#end
	
}