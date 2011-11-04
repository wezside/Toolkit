package com.wezside.data.sort
{
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ISort
	{
		
		function get property():String;
		function set property( value:String ):void;
		
		function get type():String;
		function set type( value:String ):void;
		
		function run():Array;
		function elapsed():Number;
		
	}
}
