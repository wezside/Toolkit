package com.wezside.utilities.file 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FileUploadEvent extends Event 
	{
		
		public static const SELECT:String = "fileUploadEventSelect";
		public static const PROGRESS:String = "fileUploadProgress";
		public static const COMPLETE:String = "fileUploadComplete";
		public static const DATA_COMPLETE:String = "fileUploadDataComplete";
		
		public var data:*;
		
		public function FileUploadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null)
		{
			super( type, bubbles, cancelable );
			this.data = data;
		}
	}
}
