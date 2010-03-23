package com.wezside.components.survey.form 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormLayout 
	{
		
		function get rowLayout():String;
		function set rowLayout( value:String ):void;
				
		function arrange():void;
		function addItem( item:IFormItem ):void;
		
	}
}
