package com.wezside.data.parser
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.mapping.XMLDataMapper;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.observer.IObserver;
	import com.wezside.utilities.observer.ObserverDetail;

	import flash.events.Event;
	import flash.system.ApplicationDomain;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataMapperParser extends XMLDataMapper implements IParser
	{
		
		private var _raw:*;
		private var _type:int;
		private var _locale:String;
		private var _resourceID:String;
		private var _appDomain:ApplicationDomain;
		private var _additionalResources:ICollection;
		private var _observers:ICollection = new Collection();
		private var _states:StateManager = new StateManager();
		
					
		public static const PARSER_COMPLETE:String = "DATA_PARSER_COMPLETE";


		public function XMLDataMapperParser() 
		{
			_additionalResources = new Collection();
			_states.addState( PARSER_COMPLETE );				
		}

		public function parse():void
		{
			// Map all XML nodes to Data objects
			deserialize( XML( _raw ));
			
			// Set the state to notify the observers
			_states.stateKey = PARSER_COMPLETE;
		}
		
		public function get raw():*
		{
			return _raw;
		}
		
		public function set raw( value:* ):void
		{
			_raw = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type( value:int ):void
		{
			_type = value;
		}
		
		public function get locale():String
		{
			return _locale;
		}
		
		public function set locale( value:String ):void
		{
			_locale = value;
		}
		
		public function get appDomain():ApplicationDomain
		{
			return _appDomain;
		}
		
		public function set appDomain( value:ApplicationDomain ):void
		{
			_appDomain = value;
		}
		
		public function get states():StateManager
		{
			return _states;
		}
		
		public function set states( value:StateManager ):void
		{
			_states = value;
		}
		
		public function get observers():ICollection
		{
			return _observers;
		}
		
		public function set observers( value:ICollection ):void
		{
			_observers = value;
		}
		
		public function get resourceID() : String
		{
			return _resourceID;
		}

		public function set resourceID( value:String ):void
		{
			_resourceID = value;
			id = _resourceID;
		}			

		public function get additionalResources():ICollection
		{
			return _additionalResources;
		}
		
		public function set additionalResources( value:ICollection ):void
		{
			_additionalResources = value;
		}
		
		public function notifyObservers( data:* = null ):void
		{
			// Notify all observers
			var it:IIterator = _observers.iterator();
			while ( it.hasNext() )
			{
				var observer:IObserver = it.next() as IObserver;
				var observeState:Object = observer.getObserveState( _states.stateKey );
				// Only notify if the observer registered for this state				
				if ( _states.stateKey && observeState )
				{
					if ( observeState.callback ) observeState.callback( new ObserverDetail( this, _states.state, data, _resourceID ));
					else observer.notify( new ObserverDetail( this, _states.state, data, _resourceID ));
				}
			}
			it.purge();
			it = null;
		}

		public function hasRoot():Boolean
		{
			return length > 0;
		}

		public function dispatchEvent( event:Event ):Boolean
		{
			return false;
		}

		public function hasEventListener( type:String ):Boolean
		{
			return false;
		}

		public function willTrigger( type:String ):Boolean
		{
			return false;
		}

		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
		{
		}

		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
		}
	}
}
