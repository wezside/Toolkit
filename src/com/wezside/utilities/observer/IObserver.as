package com.wezside.utilities.observer
{
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IObserver
	{
		function observeState( id:String, callback:Function = null ):Object;
		function notify( detail:IObserverDetail ):void;
	}
}
