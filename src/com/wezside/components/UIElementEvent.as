package com.wezside.components 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UIElementEvent extends Event 
	{
		
		public static const INIT:String = "initUIElement";
		public static const CREATION_COMPLETE:String = "uiCreationComplete";			
		
		
		public function UIElementEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}

		public override function clone():Event 
		{ 
			return new UIElementEvent( type, bubbles, cancelable );
		}	
	}
}
