package com.wezside.components.text 
{
	import flash.text.TextFieldType;
	import flash.events.Event;
	import flash.events.FocusEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class InputField extends Label
	{
		
		public function InputField()
		{
			super( );
			field.type = TextFieldType.INPUT;
		}
	
		override public function activate():void 
		{
			super.activate( );
			field.addEventListener( Event.CHANGE, changeHandler );			
			field.addEventListener( FocusEvent.FOCUS_IN, focusIn );
			field.addEventListener( FocusEvent.FOCUS_OUT, focusOut );			
		}

		override public function deactivate():void 
		{
			super.deactivate( );
			field.removeEventListener( Event.CHANGE, changeHandler );			
			field.removeEventListener( FocusEvent.FOCUS_IN, focusIn );			
			field.removeEventListener( FocusEvent.FOCUS_OUT, focusOut );
		}
		
		public function setFocus():void
		{
			if ( field && field.stage )
			{
				if ( field.text == " " ) field.text = "";
				field.stage.focus = field;
				field.setSelection( 0, 0 );				
			}
		}		
		
		protected function changeHandler( event:Event = null ):void 
		{
			dispatchEvent( event );
		}

		protected function focusIn( event:Event = null ):void 
		{
			dispatchEvent( event );
		}	
		
		protected function focusOut(event:FocusEvent):void 
		{
			dispatchEvent( event );
		}
	}
}
