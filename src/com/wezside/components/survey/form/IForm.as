package com.wezside.components.survey.form 
{
	import com.wezside.components.IUIElement;
	import flash.events.Event;
	
	import com.wezside.components.survey.data.IFormData;
	
	public interface IForm extends IUIElement
	{
		 function get data():IFormData;
		
		 function set data(value:IFormData):void;

		 function get state():String;
		
		 function set state(value:String):void;	}
}
