package com.wezside.utilities.observer
{
		
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface INotifier
	{
		function registerObserver( observer:IObserver ):void
		function unregisterObserver( observer:IObserver ):void		
		function notifyObservers( data:* = null ):void;
	}
}
