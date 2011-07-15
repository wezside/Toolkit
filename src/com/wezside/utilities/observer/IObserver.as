package com.wezside.utilities.observer
{
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IObserver
	{
		function setObserveState( id:String, callback:Function = null ):void;
		function getObserveState( id:String ):Object;
		function notify( detail:IObserverDetail = null ):void;
	}
}
