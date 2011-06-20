package com.wezside.utilities.factory
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.IDictionaryCollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.parser.IParser;
	import com.wezside.utilities.business.IResponder;
	import com.wezside.utilities.business.ResponderEvent;
	import com.wezside.utilities.business.rpc.IService;
	import com.wezside.utilities.factory.business.IServiceResource;
	import com.wezside.utilities.factory.business.ServiceResource;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.observer.IObserver;
	import com.wezside.utilities.observer.ObserverDetail;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class ServiceFactory implements IFactory,IResponder 
	{
		
		public static const OPEN:String = "OPEN";
		public static const CLOSED:String = "CLOSED";
		public static const PROGRESS:String = "SERVICE_FACTORY_PROGRESS";
		public static const SERVICE_FACTORY_COMPLETE:String = "SERVICE_FACTORY_COMPLETE";
		public static const HTTP_SERVICE:int = 0;
		public static const SOAP_SERVICE:int = 1;
		public static const RESULT:String = "RESULT";
		public static const FAULT:String = "FAULT";

		private var data:*;
		private var serviceIt:IIterator;
		private var states:StateManager;
		private var observers:ICollection;		
		private var resourceID:String;
		private var singleRequest:Boolean;

		protected var uri:String;
		protected var services:IDictionaryCollection;
		protected var activeServices:IDictionaryCollection;

		
		public function ServiceFactory() 
		{
			observers = new Collection();
			services = new DictionaryCollection();
			activeServices = new DictionaryCollection();
			states = new StateManager();
			states.addState( OPEN );
			states.addState( CLOSED );
			states.addState( PROGRESS );
			states.addState( RESULT );
			states.addState( FAULT );
			states.addState( SERVICE_FACTORY_COMPLETE );
			serviceIt = services.iterator();
			state = CLOSED;
		}
		
		/**
		 *  Template method.  
		 *  @param uri Expects the fully qualified class name.
		 */
		public function createService( id:String, uri:String, qualifiedName:String, method:String = "get", dormant:Boolean = false, parser:IParser = null, params:Object = null, requestHeaders:Array = null ):void
		{			
			var serviceResource:IServiceResource = new ServiceResource(); 
			serviceResource.id = id;
			serviceResource.uri = uri;
			serviceResource.type = parseType( uri );
			serviceResource.qualifiedName = qualifiedName;
			serviceResource.dormant = dormant;
			serviceResource.parser = parser;
			serviceResource.method = method;
			serviceResource.params = params;
			serviceResource.requestHeaders = requestHeaders;
			if ( serviceResource.type == ServiceFactory.HTTP_SERVICE )
			{
				serviceResource.qualifiedName += "HTTPService";
			}
			if ( serviceResource.type == ServiceFactory.SOAP_SERVICE )
			{
				serviceResource.qualifiedName += "Webservice";
			}
			services.addElement( serviceResource.id, serviceResource );		
		}
		
		public function registerObserver( observer:IObserver ):void
		{
			observers.addElement( observer );
		}
		
		public function unregisterObserver( observer:IObserver ):void
		{
			observers.removeElement( observer );
		}
		
		public function create( resourceID:String = null, moduleID:String = "" ):void
		{
			data = 0;
			state = PROGRESS;			
			var serviceResource:IServiceResource = new ServiceResource(); 
			if ( !resourceID )
			{
				if ( serviceIt.hasNext() )
				{
					singleRequest = false;
					var key:String = serviceIt.next() as String;
					if ( IServiceResource( services.getElement( key )).dormant )
					{
						loadNext();
						return;
					}
					else
					{
						serviceResource = services.getElement( key );
						invokeService( serviceResource );
					}	
				}
				else
					return;
			}
			else
			{
				singleRequest = true;
				serviceResource = services.getElement( resourceID );
				serviceResource.associateID = moduleID;
				invokeService( serviceResource );
			}
			serviceResource = null;
		}

		private function invokeService( resource:IServiceResource ):void
		{
			var clazz:Class = getDefinitionByName( resource.qualifiedName ) as Class;
			var service:IService = new clazz() as IService;		
			service.id = resource.id;
			service.method = resource.method;
			service.asyncToken = Math.random();
			resource.asyncToken = service.asyncToken;
			service.url = resource.uri;
			service.addEventListener( ResponderEvent.RESULT, result );
			service.addEventListener( ResponderEvent.FAULT, fault );
			service.addEventListener( ProgressEvent.PROGRESS, progress );
			service.send( resource.params, resource.operationID );		
			activeServices.addElement( service.asyncToken.toString(), {id: resource.associateID, parser: resource.parser });			
		}

		public function set state( value:String ):void
		{
			states.stateKey = value;
			notifyObservers( data );
		}
		
		public function get state():String
		{
			return states.stateKey;			
		}

		public function fault( event:ResponderEvent ):void
		{
			resourceID = event.data.id;
			data = event.data.content;
			state = FAULT;
			if ( !singleRequest ) loadNext();
		}
		
		public function result( event:ResponderEvent ):void
		{	
			resourceID = event.data.id;
			var associateID:String = activeServices.getElement( String( event.data.token )).id;
			var parser:IParser = activeServices.getElement( String( event.data.token )).parser as IParser;
			if ( parser )
			{
				parser.raw = event.data.content;
			 	parser.appDomain = ApplicationDomain.currentDomain;
			 	parser.resourceID = resourceID;
				parser.observers = observers;
				parser.parse();	
				data = { parserData: parser.data, id: associateID, raw: event.data };
				parser.notifyObservers( data );
			}
			else
				data = { raw: event.data, id: associateID };
				
				
			activeServices.removeElement( String( event.data.token ));
			state = RESULT;
			if ( !singleRequest ) loadNext();
		}

		public function parseAssociateID( id:String ):String
		{
			var associateID:String = id.indexOf( "::" ) == -1 ? "" : id.substr( id.indexOf( "::" ) + 2 );  
			return associateID;			
		}

		public function hasServices():Boolean 
		{
			return services.length > 0;
		}
		
		public function hasService( serviceID:String ):Boolean 
		{
			return services.getElement( serviceID ) ? true : false;
		}
		
		public function willTrigger():Boolean
		{
			var willTrigger:Boolean = false;
			var it:IIterator = services.iterator();
			var key:String;
			while ( it.hasNext() )
			{
				key = it.next() as String;
				willTrigger = IService( services.getElement( key )).willTrigger( Event.COMPLETE );
				if ( willTrigger ) break;
			}
			it.purge();
			it = null;
			key = null;
			return willTrigger;	
		}
		
		public function addParams( key:String, params:Object ):void
		{
			ServiceResource( services.getElement( key )).params = params;
		}

		public function getServiceResource( serviceID:String ):IServiceResource
		{
			return services.getElement( serviceID );
		}

		public function purge():void
		{
			observers.purge( );
			observers = null;
			services.purge( );
			services = null;
			states.purge();
			states = null;
		}
		
		public function notifyObservers( data:* = null ):void
		{
			// Notify all observers
			var it:IIterator = observers.iterator();
			while ( it.hasNext() )
			{
				var observer:IObserver = it.next() as IObserver;
				var observeState:Object = observer.observeState( states.stateKey );
				// Only notify if the observer registered for this state				
				if ( states.stateKey && observeState )
				{
					if ( observeState.callback ) observeState.callback( new ObserverDetail( this, states.state, data, resourceID ));
					else observer.notify( new ObserverDetail( this, states.state, data, resourceID ));
				}
			}
			it.purge();
			it = null;
		}	

		protected function loadNext():void
		{
			if ( serviceIt.hasNext() ) create();
			else state = SERVICE_FACTORY_COMPLETE;
		}

		protected function parseType( uri:String ):int
		{
			if ( uri.indexOf( "wsdl" ) != -1 )
				return SOAP_SERVICE;
			return HTTP_SERVICE;			
		}
		
		protected function parseID( uri:String ):String		
		{
			var p:RegExp;
			if ( uri.indexOf( "-" ) != -1 )
			{
				p = new RegExp( /.[\w]+-/ig );
				var str:String = String( uri.match( p ) );
				return str.substring( str.charAt( 0 ) == "." ? 1 : 0, str.length - 1 );	
			}
			p = new RegExp( /[\w]+$/ig );
			return String( uri.match( p ));
		}
							
		private function progress( event:ProgressEvent ):void
		{
			var percent:int = Math.round( event.bytesLoaded / event.bytesTotal * 100 );
			notifyObservers( percent );			
		}

	}
}
