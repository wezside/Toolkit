package com.wezside.utilities.observer
{
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.data.collection.IDictionaryCollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class Observer implements IObserver
	{
		
		private var _observeStates:IDictionaryCollection;

		public function Observer() 
		{
			_observeStates = new DictionaryCollection();	
		}

		public function notify( detail:IObserverDetail ):void
		{
			throw new Error( "Abstract class" );
		}

		public function observeState( id:String, callback:Function = null ):Object
		{
			if ( !_observeStates.hasElement( id ))
				_observeStates.addElement( id, { callback: callback });				
			return _observeStates.getElement( id );
		}
	}
}
