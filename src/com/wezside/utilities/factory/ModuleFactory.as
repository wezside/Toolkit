package com.wezside.utilities.factory
{
	import com.wezside.data.ItemData;
	import com.wezside.data.ModuleData;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.observer.INotifier;
	import com.wezside.utilities.observer.IObserver;
	import com.wezside.utilities.observer.ObserverDetail;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.getDefinitionByName;



	/**
	 * @author Wesley.Swanepoel
	 */
	public class ModuleFactory extends AbstractModuleFactory
	{
		public static const OPEN:String = "OPEN";
		public static const CLOSED:String = "CLOSED";
		public static const PROGRESS:String = "MODULE_FACTORY_PROGRESS";
		public static const MODULE_COMPLETE:String = "MODULE_COMPLETE";
		public static const MODULE_FACTORY_COMPLETE:String = "MODULE_FACTORY_COMPLETE";
		public static const MODULE_ADDED_TO_STAGE:String = "MODULE_ADDED_TO_STAGE";
		public static const MODULE_BUILD_COMPLETE:String = "MODULE_BUILD_COMPLETE";

		
		private var _data:*;
		private var _notifyData:*;
		private var _useLocalSecurityDomain:Boolean;
		private var _resources:ICollection;
//		private var _services:IDictionaryCollection;

		private var moduleIt:IIterator;
		private var states:StateManager;
		private var observers:ICollection;
		private var swfModuleParams:Object;

		
		public function ModuleFactory()
		{
			_useLocalSecurityDomain = true;
			states = new StateManager( );
			observers = new Collection( );
			modules = new Collection( );
			states.addState( OPEN );
			states.addState( CLOSED );
			states.addState( MODULE_COMPLETE );
			states.addState( MODULE_FACTORY_COMPLETE );
			states.addState( MODULE_ADDED_TO_STAGE );
			moduleIt = modules.iterator( );			
			_resources = new Collection( );
//			_services = new DictionaryCollection();
		}

		override public function create( resource:IModuleResource = null ):void
		{
			state = PROGRESS;
			if ( !resource )
			{
				if ( moduleIt.hasNext( ))
					resource = moduleIt.next( ) as IModuleResource;
				else 
					resource = modules.getElementAt( modules.length - 1 );
			}
			if ( resource.uri != "" && resource.uri.indexOf( ".swf" ) != -1 )
			{
				swfModuleParams = { id: resource.id, namespaceURI: resource.uri, resource: resource };
				var context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain, _useLocalSecurityDomain ? null : SecurityDomain.currentDomain );				
				var swfModuleLoader:Loader = new Loader( );
				swfModuleLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, swfModuleLoadComplete );
				swfModuleLoader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, loadProgress );
				swfModuleLoader.load( new URLRequest( resource.uri ), context );					
			}
			else
			{
				try
				{
					var clazz:Class = getDefinitionByName( resource.qualifiedName ) as Class;
					var module:IModule = new clazz( ) as IModule;
					module.id = resource.id + ( resource.dataID ? "-" + resource.dataID : "" );
					module.dataID = resource.dataID;
					module.data = _data;
					module.resources = getModuleResources( resource.id );
					module.addEventListener( Event.ADDED_TO_STAGE, moduleStageInit );
					if ( module is INotifier )
						INotifier( module ).registerObserver( observers.getElementAt( 0 ));
					resource.instance = module;
					loadComplete( );
				}
				catch ( error:ReferenceError ) {
					throw new Error( "Instantiating a Module '" + resource.qualifiedName + "' from a class requires the Class to be included by the compiler. To do this, simply call the class constructor on its own in the document class." );
				}
			}
			clazz = null;
		}

		private function swfModuleLoadComplete( event:Event ):void 
		{
			var resource:IModuleResource = swfModuleParams.resource;
			event.currentTarget.removeEventListener( Event.COMPLETE, loadComplete );
			var clazz:Class = event.currentTarget.applicationDomain.getDefinition( swfModuleParams.namespaceURI + "::" + swfModuleParams.id ) as Class;
			var module:IModule = new clazz( ) as IModule; 
			module.id = resource.id + ( resource.dataID ? "-" + resource.dataID : "" );
			module.dataID = resource.dataID;
			module.data = _data;
			module.resources = getModuleResources( resource.id );
			module.addEventListener( Event.ADDED_TO_STAGE, moduleStageInit );
			if ( module is INotifier )
				INotifier( module ).registerObserver( observers.getElementAt( 0 ));
			resource.instance = module;
			loadComplete( );
		}

		private function getModuleResources( id:String ):ICollection 
		{
			var collection:ICollection = new Collection( );
			if ( !_data )
				return null;
			var module:ModuleData = _data.module( id );
			if ( module )
			{
				var items:ICollection = _data.module( id ).items;
				var itemIt:IIterator = items ? items.iterator( ) : new NullIterator( );
				while ( itemIt.hasNext( ) )
				{
					var itemData:ItemData = itemIt.next( ) as ItemData;
					var resource:IResource = resources.find( "id", itemData.id ) as IResource;
					if ( resource )
						collection.addElement( resource );
				}
				itemIt.purge( );
				itemIt = null;
				module = null;
			}
			return collection;
		}

		/**
		 * Returns a copy collection of IModuleResources. 
		 */
		public function getModules():ICollection
		{
			var c:Collection = new Collection( );
			var it:IIterator = modules.iterator( );
			while ( it.hasNext( ))
				c.addElement( it.next( ).instance );
			it.purge( );
			it = null;
			return c;
		}

		public function hasModule( id:String ):Boolean
		{
			return modules.find( "id", id ) ? true : false; 
		}

		public function getModule( id:String ):IModule
		{
			var resource:IModuleResource = modules.find( "id", id ) as IModuleResource;
			return resource ? resource.instance as IModule : null;
		}

		/**
		 * This method will loop through the associate attribute in the config.xml
		 * descriptor and return the serviceID for the param moduleID. 
		 */
		public function getServiceID( moduleID:String ):String
		{
			var it:IIterator = _data.modules.iterator();
			var moduleData:ModuleData;
			while ( it.hasNext() )
			{
				moduleData = it.next() as ModuleData;
				if ( moduleData.id == moduleID )
					break;
			}
			it.purge();
			it = null;
			return moduleData.serviceID;
		}

		public function setModuleResources( getResources:ICollection ):void 
		{
		}

		public function purgeModule( id:String ):void
		{			
			modules.removeElement( "id", id );
		}

		override public function registerObserver( observer:IObserver ):void
		{
			observers.addElement( observer );
		}

		override public function unregisterObserver( observer:IObserver ):void
		{
			observers.removeElement( observer );
		}

		override public function purge():void
		{
			state = CLOSED;
			moduleIt.purge( );
			moduleIt = null;			
			module = null;
			observers.purge();
			observers = null;
			swfModuleParams = null;
			modules.purge();
			modules = null;
			states.purge();
			states = null;
			_resources.purge();
			_resources = null;		
		}

		public function set state( value:String ):void
		{
			states.stateKey = value;
			notifyObservers( _notifyData );
		}

		public function get state():String 
		{
			return states.stateKey;
		}		

		public function get useLocalSecurityDomain():Boolean
		{
			return _useLocalSecurityDomain;
		}

		public function set useLocalSecurityDomain( value:Boolean ):void
		{
			_useLocalSecurityDomain = value;
		}

		public function get resources():ICollection
		{
			return _resources;
		}

		public function set resources( value:ICollection ):void
		{
			_resources = value;
		}

		public function set data( value:* ):void
		{
			_data = value;
		}
		
		public function get notifyData():*
		{
			return _notifyData;
		}
		
		public function set notifyData( value:* ):void
		{
			_notifyData = value;
		}

		public function reset():void
		{
			modules.purge( );
			modules = new Collection( );
		}

		public function resize():void 
		{
			var it:IIterator = modules.iterator();
			var moduleResource:IModuleResource;
			while ( it.hasNext() )
			{
				moduleResource = it.next() as IModuleResource;
				if ( moduleResource.instance )
					moduleResource.instance.resize();
			}
			it.purge();
			it = null;
			module = null;
		}

		override public function parseID( uri:String ):String
		{
			var p:RegExp;
			if ( uri.indexOf( "-" ) != -1 )
			{
				p = new RegExp( /.[\w]+-/ig );
				var str:String = String( uri.match( p ) );
				return str.substring( str.charAt( 0 ) == "." ? 1 : 0, str.length - 1 );	
			}
			p = new RegExp( /[\w]+$/ig );
			return String( uri.match( p ) );
		}

		override public function parseDataID( uri:String ):String
		{
			if ( uri.indexOf( "-" ) == -1 ) return "";
			var pattern:RegExp = new RegExp( /[-|.][\w]+$/ig );
			return String( uri.match( pattern ) ).substr( 1 );
		}
		
		public function moduleResource( id:String ):IModuleResource
		{
			var it:IIterator = modules.iterator();
			var resource:IModuleResource;
			while ( it.hasNext() )
			{
				resource = it.next() as IModuleResource;
				if ( resource.id == id )
					break;
			}
			it.purge();
			it = null;
			return resource;
		}		

		public function toString():String 
		{
			var str:String = "";
			var module:IModuleResource;
			var it:IIterator = modules.iterator();
			while ( it.hasNext() )
			{
				module = it.next() as IModuleResource;
				if ( module.instance ) str += module.id + "\n";
			}
			it.purge();
			it = null;
			module = null;			
			return str;
		}

		private function loadProgress( event:ProgressEvent ):void
		{
		}

		private function loadComplete( event:Event = null ):void
		{
			state = MODULE_COMPLETE;
			if ( moduleIt.hasNext( ) ) create( moduleIt.next( ) as IModuleResource );
			else state = MODULE_FACTORY_COMPLETE;
		}

		private function notifyObservers( data:* = null ):void
		{
			// Notify all observers
			var observer:IObserver;
			var it:IIterator = observers.iterator( );			
			while ( it.hasNext( ) )
			{
				observer = it.next( ) as IObserver;

				// Only notify if the observer registered for this state
				if ( states.stateKey && observer.getObserveState( states.stateKey ))
					observer.notify( new ObserverDetail( this, states.state, data ) );
			}
			it.purge( );
			it = null;
		}

		
		private function moduleStageInit( event:Event ):void 
		{
			event.currentTarget.removeEventListener( Event.ADDED_TO_STAGE, moduleStageInit );
			_notifyData = event.currentTarget as IModule;
			state = MODULE_ADDED_TO_STAGE;			
		}


	}
}
