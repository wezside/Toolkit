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
		private var _defaultText:String = "";

		public function InputField()
		{
			super( );
			field.type = TextFieldType.INPUT;
		}
	
		override public function activate():void 
		{
			field.addEventListener( Event.CHANGE, changeHandler );			
			field.addEventListener( FocusEvent.FOCUS_IN, focusIn );
			field.addEventListener( FocusEvent.FOCUS_OUT, focusOut );			
		}

		override public function deactivate():void 
		{
			field.removeEventListener( Event.CHANGE, changeHandler );			
			field.removeEventListener( FocusEvent.FOCUS_IN, focusIn );			
			field.removeEventListener( FocusEvent.FOCUS_OUT, focusOut );
		}
		
		public function setFocus():void
		{
			if ( field && field.stage )
			{
				field.setSelection( 0, field.length );	
				if ( field.text == " " ) field.text = "";
				field.stage.focus = field;	
			}
		}		
			
		override public function get text():String
		{
			return field.text;
		}
		
		public function get defaultText():String
		{
			return _defaultText;
		}
		
		public function set defaultText( value:String ):void
		{
			_defaultText = value;
		}
		
		public function get editable():Boolean
		{
			return field.type == TextFieldType.INPUT;
		}
		
		public function set editable( value:Boolean ):void
		{
			field.type =  value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}

		protected function changeHandler( event:Event = null ):void 
		{
		}

		protected function focusIn( event:Event = null ):void 
		{
			if ( field.text == _defaultText ) field.text = " ";
			setFocus();			
		}	
		
		protected function focusOut(event:FocusEvent):void 
		{
			if ( field.text == "" || field.text == " " ) field.text = _defaultText;
		}		
	}
}
