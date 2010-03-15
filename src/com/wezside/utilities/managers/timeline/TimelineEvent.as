package com.wezside.utilities.managers.timeline 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TimelineEvent extends Event 
	{
		
		public static const COMPLETE:String = "timelineAnimationComplete";
		public static const SEQUENTIAL_COMPLETE:String = "timelineSequentialAnimationComplete";

		public var id:String;
		public var index:int;
		
		public function TimelineEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, id:String = "", index:int = -1 )
		{
			super( type, bubbles, cancelable );
			this.id = id;
			this.index = index;
		}
				
		override public function clone():Event
		{
			return new TimelineEvent( type, bubbles, cancelable, id, index );
		}		
	}
}
