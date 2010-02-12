package com.wezside.components.accordion 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionEvent extends Event 
	{
		public static const HEADER_CLICK:String = "headerClick";
		public static const CONTENT_CLICK:String = "contentClick";
		public static const SHOW_COMPLETE:String = "showComplete";
		public var data:*;
		public var selectedItem:uint;

		public function AccordionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, selectedItem:uint = 0, data:* = null )
		{
			super( type, bubbles, cancelable );
			this.data = data;
			this.selectedItem = selectedItem;
		}
		
		override public function clone():Event
		{
			return new AccordionEvent( type, bubbles, cancelable, selectedItem, data );
		}
	}
}
