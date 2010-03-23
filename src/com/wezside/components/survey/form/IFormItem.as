package com.wezside.components.survey.form
{
	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormItem 
	{
		
		function get id():String;
		function set id( value:String ):void;
		
		function get value():String;
		function set value( value:String ):void;
		
		function get skin():IFormItemSkin;
		function set skin( value:IFormItemSkin ):void;
		
		function get state():String;
		function set state( value:String ):void;
		
		function get group():IFormGroup;
		function set group( value:IFormGroup ):void;
		
		function get label():IFormLabel;
		function set label( value:IFormLabel ):void;
		
		function get labelPlacement():String;
		function set labelPlacement( value:String ):void;
		
		function get regexValidation():String;
		function set regexValidation( value:String ):void;
		
		function get icon():DisplayObject;
		function set icon( value:DisplayObject ):void;
		
		function get iconPlacement():String;
		function set iconPlacement( value:String ):void;
						
		function get maxRowLabelWidth():int;
		function set maxRowLabelWidth( value:int ):void;		
		
		function purge():void;
	}
}
