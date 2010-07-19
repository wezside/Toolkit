package com.wezside.components.survey.form 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormEvent extends Event 
	{
	
		public static const FORM_VALIDATION_CHECK:String = "FORM_VALIDATION_CHECK";
		public static const FORM_STATE_CHANGE:String = "FORM_STATE_CHANGE";
		public static const TEXT_INPUT:String = "TEXT_INPUT";
		public static const FORM_FOCUS_IN:String = "FOCUS_IN";
		public static const FORM_FOCUS_OUT:String = "FOCUS_OUT";		
		private var _data : *;
				
		public function FormEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null )
		{
			super( type, bubbles, cancelable );
		}
		
		override public function clone():Event 
		{
			return new FormEvent( type, bubbles, cancelable, data );
		}		
		
		public function set data( value : * ) : void
		{
		 	_data = value;
		}
		
		public function get data() : *
		{
			return _data;
		}		
	}
}
