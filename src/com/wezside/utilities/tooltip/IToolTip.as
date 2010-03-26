package com.wezside.utilities.tooltip 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IToolTip 
	{
		
		function get data():Object;
		function set data( value:Object ):void;
		
		function get currentState():String;
		function set currentState( value:String ):void;
		
		function get x():Number;
		function set x( value:Number ):void;
		
		function get y():Number;
		function set y( value:Number ):void;
		
		function get visible():Boolean;
		function set visible( value:Boolean ):void;
		
	}
}
