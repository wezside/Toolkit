package com.wezside.components.combo 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ComboEvent extends Event 
	{
		public static const ITEM_SELECTED:String = "ITEM_SELECTED";

		public var item:ComboItem;

		public function ComboEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, item:ComboItem = null )
		{
			super( type, bubbles, cancelable );
			this.item = item;
		}
		
		override public function clone():Event 
		{
			return new ComboEvent( type, bubbles, cancelable, item );
		}
	}
}
