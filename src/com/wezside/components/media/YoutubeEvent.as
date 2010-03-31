package com.wezside.components.media 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class YoutubeEvent extends Event 
	{
		
		public static const VIDEO_CUED:String = "videoCued";
		public static const VIDEO_HELP:String = "videoHelp";
		public static const VIDEO_PLAYBACK_COMPLETE:String = "videoPlaybackComplete";

		public var data:*;

		public function YoutubeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null)
		{
			super( type, bubbles, cancelable);
			this.data = data;
		}
	}
}
