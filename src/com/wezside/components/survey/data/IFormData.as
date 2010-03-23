package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormData 
	{
		function get heading():String;
		function set heading( value:String ):void;		
		function get subheading():String;
		function set subheading( value:String ):void;		
		function get body():String;
		function set body( value:String ):void;		
		function get submit():String;
		function set submit( value:String ):void;		
		function get cta():String;
		function set cta( value:String ):void;				
	}
}
