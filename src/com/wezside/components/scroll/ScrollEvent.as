package com.wezside.components.scroll 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollEvent extends Event 
	{

		public var percent:Number;
		public static const CHANGE:String = "scrollValueChange"; 

		
		public function ScrollEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, percent:Number = 0 )
		{
			super( type, bubbles, cancelable );
			this.percent = percent;
		}
		
		override public function clone():Event 
		{
			return new ScrollEvent( type, false, false, percent );
		}
	}
}
