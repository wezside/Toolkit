package com.wezside.components.media 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MediaEvent extends Event 
	{
				
		
		public static const LOAD_INIT:String = "loadInit";
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const IMAGE_THUMB_CLICK:String = "imageThumbClick";
		public static const YOUTUBE_THUMB_CLICK:String = "youtubeThumbClick";
		public static const POPOUT_VIDEO:String = "popoutVideo";
		
		public var data:*;
		public var youtubeID:String;
				
		public function MediaEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null, youtubeID:String = "" )
		{
			super( type, bubbles, cancelable );
			this.data = data;
			this.youtubeID = youtubeID;
		}
		
		override public function clone():Event
		{
			return  new MediaEvent( type, bubbles, cancelable, data, youtubeID );
		}
	}
}
