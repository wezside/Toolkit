package com.wezside.utilities.observer
{
	import com.wezside.data.collection.ICollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IObserver
	{
		
		function get observeStates():ICollection;
		function set observeStates( value:ICollection ):void;
		
		function notify( detail:IObserverDetail ):void;
	}
}
