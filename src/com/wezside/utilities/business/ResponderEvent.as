package com.wezside.utilities.business
{
	
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ResponderEvent extends Event 
	{
		
		
		public static const FAULT:String = "responderFault";
		public static const RESULT:String = "responderResult";		
		
		public var data:*;
		public var message:String;
		public var messageID:String;
		public var statusCode:int;
		public var asyncToken:Number;

		public function ResponderEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null, messageID:String = "", message:String = "", statusCode:int = 0, asyncToken:Number = 0 )
		{
			super( type, bubbles, cancelable );
			this.data = data;
			this.message = message;
			this.messageID = messageID;
			this.statusCode = statusCode;
			this.asyncToken = asyncToken;
		}
		
		override public function clone():Event 
		{ 
			return new ResponderEvent( type, bubbles, cancelable, data, messageID, message, statusCode, asyncToken );
		}
	}
}
