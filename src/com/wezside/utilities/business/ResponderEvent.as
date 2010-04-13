package com.wezside.utilities.business
{
	import mx.rpc.Fault;
	import mx.messaging.messages.IMessage;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ResponderEvent extends Event 
	{
		
		
		public static const FAULT:String = "responderFault";
		public static const RESULT:String = "responderResult";		
		
		public var data:*;
		public var message:IMessage;
		public var messageID:String;
		public var statusCode:int;
		public var fault:Fault;

		public function ResponderEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null, messageID:String = "", message:IMessage = null, statusCode:int = 0, fault:Fault = null )
		{
			super( type, bubbles, cancelable );
			this.data = data;
			this.message = message;
			this.messageID = messageID;
			this.statusCode = statusCode;
			this.fault = fault;
		}
		
		override public function clone():Event 
		{ 
			return new ResponderEvent( type, bubbles, cancelable, data, messageID, message, statusCode, fault );
		}
	}
}
