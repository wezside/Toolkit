package com.wezside.components.scrollbar 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollEvent extends Event 
	{

		public static const CHANGE:String = "scrollValueChange"; 

		private var percent:Number;
		
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
