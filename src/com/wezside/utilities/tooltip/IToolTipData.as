package com.wezside.utilities.tooltip 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IToolTipData 
	{
		function get title():String;
		function set title( value:String ):void;
				
		function get subtitle():String;
		function set subtitle( value:String ):void;
				
		function get body():String;
		function set body( value:String ):void;		
	}
}
