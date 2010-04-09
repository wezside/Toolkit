package com.wezside.components 
{
	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIElementSkin 
	{
		function get up():DisplayObject;
		function set up( value:DisplayObject ):void;
		
		function get over():DisplayObject;
		function set over( value:DisplayObject ):void;
		
		function get down():DisplayObject;
		function set down( value:DisplayObject ):void;
		
		function get selected():DisplayObject;
		function set selected( value:DisplayObject ):void;
		
		function get invalid():DisplayObject;
		function set invalid( value:DisplayObject ):void;
		
		function get disabled():DisplayObject;
		function set disabled( value:DisplayObject ):void;
		
		function setSkin( visibleStates:Array ):void;
		function hasOwnProperty( V:* = undefined ):Boolean;

	}
}
