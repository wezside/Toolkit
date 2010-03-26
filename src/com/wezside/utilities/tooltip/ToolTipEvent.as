package com.wezside.utilities.tooltip 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ToolTipEvent extends Event 
	{
	
		public static const SHOW:String = "showTooltip";	
		public static const HIDE:String = "hideTooltip";	
		
		public function ToolTipEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
	}
}
