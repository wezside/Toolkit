package com.wezside.components.survey.form 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormEvent extends Event 
	{
		
		public static const CREATION_COMPLETE:String = "formCreationComplete";
		
		public function FormEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
	}
}
