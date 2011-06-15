package com.wezside.utilities.observer
{
	import com.wezside.utilities.manager.state.IState;
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IObserverDetail
	{
		
		function get resourceID():String;
		function set resourceID( value:String ):void;
		
		function get state():IState;
		function set state( value:IState ):void;

		function get data():*;
		function set data( value:* ):void;
		
		function get origin():*;
		function set origin( value:* ):void;
	}
}
