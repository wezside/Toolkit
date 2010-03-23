package com.wezside.components.container 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IContainer 
	{
		function update():void;
		function purge():void;
		function get styleName():String;
		function set styleName( value:String ):void;
	}
}
