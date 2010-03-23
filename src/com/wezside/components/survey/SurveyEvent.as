package com.wezside.components.survey 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyEvent extends Event 
	{
		
		public static const CREATION_COMPLETE:String = "surveyCreationComplete";
		
		public function SurveyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
	}
}
