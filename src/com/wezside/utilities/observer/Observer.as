package com.wezside.utilities.observer
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class Observer implements IObserver
	{
		private var _observeStates:ICollection;

		public function Observer() 
		{
			_observeStates = new Collection();	
		}

		public function get observeStates():ICollection
		{
			return _observeStates;
		}

		public function set observeStates( value:ICollection ):void
		{
			_observeStates = value;
		}

		public function notify( detail:IObserverDetail ):void
		{
			throw new Error( "Abstract class" );
		}
	}
}
