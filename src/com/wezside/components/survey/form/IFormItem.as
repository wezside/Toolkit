package com.wezside.components.survey.form 
{
	import com.wezside.components.survey.data.IFormItemData;
	import com.wezside.components.IUIElement;

	/**
	 * @author DaSmith
	 */
	public interface IFormItem extends IUIElement
	{


		function get id():String;

		function get type():String;

		function get value():String;

		function set value( value:String ):void;

		function get selected():Boolean;

		function set selected( value:Boolean ):void;

		function get data():IFormItemData;

		function set data( value:IFormItemData ):void;

		function get parentGroup():IFormGroup;			// TODO: Remove this - UGLY way to lookup the chain

		function set parentGroup( value:IFormGroup ):void;

		function get state():String;

		function set state( value:String ):void;

		function get debug():Boolean;

		function set debug( value:Boolean ):void;

		function get isValid():Boolean;

		function set isValid( value:Boolean ):void;

		function showValid( value:Boolean ):void;
	}
}
