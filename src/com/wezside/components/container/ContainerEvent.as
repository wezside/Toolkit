package com.wezside.components.container 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ContainerEvent extends Event 
	{
		
		public static const CREATION_COMPLETE:String = "containerCreationComplete";
				
		
		public function ContainerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
	}
}
