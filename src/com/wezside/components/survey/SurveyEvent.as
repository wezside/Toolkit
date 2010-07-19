package com.wezside.components.survey 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyEvent extends Event 
	{
		public static const FORM_VALIDATION:String = "formValidation";
		public static const PARSER_COMPLETE:String = "PARSER_COMPLETE";
		public var data:*;

		public function SurveyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null )
		{
			super( type, bubbles, cancelable );
			this.data = data;
		}
		
		override public function clone():Event 
		{
			return new SurveyEvent( type, bubbles, cancelable, data );
		}
	}
}
