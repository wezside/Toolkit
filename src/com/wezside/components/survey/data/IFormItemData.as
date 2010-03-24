package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormItemData 
	{
		function get id():String;
		function set id( value:String ):void;	
				
		function get label():String;
		function set label( value:String ):void;			
				
		function get type():String;
		function set type( value:String ):void;			
	
	}
}
