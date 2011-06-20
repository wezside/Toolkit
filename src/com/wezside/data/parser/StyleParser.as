package com.wezside.data.parser
{
	import com.wezside.data.StyleData;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.IDictionaryCollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.manager.style.IStyleManager;
	import com.wezside.utilities.observer.IObserver;
	import com.wezside.utilities.observer.ObserverDetail;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class StyleParser extends EventDispatcher implements IParser
	{

		private var _type:int;
		private var _raw:*;
		private var _data:*;
		private var _locale:String;
		private var _resourceID:String;
		private var _appDomain:ApplicationDomain;
		private var _namespaces:IDictionaryCollection = new DictionaryCollection();
		private var _observers:ICollection = new Collection( );
		private var _states:StateManager = new StateManager( );		
		private var _styles:ICollection = new Collection();

		
		public static const PARSER_COMPLETE:String = "STYLE_PARSER_COMPLETE";

		public function StyleParser() 
		{
			_states.addState( PARSER_COMPLETE );				
		}

		/**
		 * TODO: Add checks to see if styles has a value.
		 */
		public function parse():void
		{
			var stylesIt:IIterator = _styles.iterator( );
			while( stylesIt.hasNext( ) )
			{
				var style:StyleData = stylesIt.next( ) as StyleData;		
				var styleCodeIt:IIterator = style.codeIterator( );
				 
				while ( styleCodeIt.hasNext( ) )
				{
					var code:String = styleCodeIt.next( ) as String;
					if ( code == locale )
					{
						var Styles:Class = _appDomain.getDefinition( _namespaces.getElement( "style" ) + "::" + style.id ) as Class;
						_data = new Styles( ) as IStyleManager;
						IStyleManager( _data ).addEventListener( Event.COMPLETE, styleReady );
						break;			 
					}
				}				
				styleCodeIt.purge( );
				styleCodeIt = null;						
			}
			stylesIt.purge( );
			stylesIt = null;
		}


		public function get raw():*
		{
			return _raw;
		}

		public function get data():*
		{
			return _data;
		}

		public function set data( value:* ):void
		{
			_data = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set raw( value:* ):void
		{
			_raw = value;
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

		public function set styles( value:ICollection ):void
		{
			_styles = value;
		}

		public function set namespaces( value:IDictionaryCollection ):void
		{
			_namespaces = value;
		}

		public function get appDomain():ApplicationDomain
		{
			return _appDomain;
		}

		public function set appDomain( value:ApplicationDomain ):void
		{
			_appDomain = value;
		}

		public function get observers():ICollection
		{
			return _observers;
		}

		public function set observers( value:ICollection ):void
		{
			_observers = value;			
		}

		public function notifyObservers( data:* = null ):void
		{
			// Notify all observers
			var it:IIterator = _observers.iterator( );
			while ( it.hasNext( ) )
			{
				var observer:IObserver = it.next( ) as IObserver;
				var observeState:Object = observer.getObserveState( _states.stateKey );
				
				// Only notify if the observer registered for this state				
				if ( _states.stateKey && observeState )
				{
					if ( observeState.callback ) observeState.callback( new ObserverDetail( this, _states.state, data ) );
					else observer.notify( new ObserverDetail( this, _states.state, data ) );
				}
			}
			it.purge( );
			it = null;
		}

		public function get resourceID():String
		{
			return _resourceID;
		}

		public function set resourceID( value:String ):void
		{
			_resourceID = value;
		}			

		private function styleReady( event:Event ):void
		{
			event.stopImmediatePropagation();
			_states.stateKey = PARSER_COMPLETE;
			dispatchEvent( event );
		}

	}
}
