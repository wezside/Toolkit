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

		public function setObserveState( id:String, callback:Function = null ):void
		{
			_observeStates.addElement( id, { callback: callback });				
		}

		public function getObserveState( id:String ):Object
		{
			return _observeStates.getElement( id );
		}
	}
}
