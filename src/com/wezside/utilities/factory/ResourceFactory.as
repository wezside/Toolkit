package com.wezside.utilities.factory
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.observer.IObserver;
	import com.wezside.utilities.observer.ObserverDetail;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;


	/**
	 * @author Wesley.Swanepoel
	 * 
	 * A subject in the Observer pattern. Observers want to be notify of the factory's process and events.
	 */
	public class ResourceFactory extends AbstractResourceFactory
	{
		
		private var _locale:String;
		private var states:StateManager;
		private var observers:Collection;		
		private var resourcesIt:IIterator;
		private var loader:Loader;
		private var urlLoader:URLLoader;
		private var initialized:Boolean = false;
		private var currentIndex:int = 0;
		private var data:*;
		
		public static const OPEN:String = "OPEN";
		public static const CLOSED:String = "CLOSED";
		public static const PROGRESS:String = "RESOURCE_FACTORY_PROGRESS";
		public static const RESOURCE_COMPLETE:String = "RESOURCE_COMPLETE";
		public static const RESOURCE_FACTORY_COMPLETE:String = "RESOURCE_FACTORY_COMPLETE";
		
		public function ResourceFactory()
		{
			observers = new Collection();
			resources = new Collection();
			states = new StateManager();
			states.addState( OPEN );
			states.addState( CLOSED );
			states.addState( PROGRESS );
			states.addState( RESOURCE_COMPLETE );
			states.addState( RESOURCE_FACTORY_COMPLETE );
		}

		override public function registerObserver( observer:IObserver ):void
		{
			observers.addElement( observer );
		}

		override public function unregisterObserver( observer:IObserver ) : void
		{
			observers.removeElement( observer );
		}

		override public function create():void
		{
			data = 0;
			state = PROGRESS;
			if ( !initialized )
			{
				initialized = true;
				resourcesIt = resources.iterator();
				
				while ( resourcesIt.index() < currentIndex )
					this.resource = resourcesIt.next() as IResource;
	
				resource = currentIndex == 0 ? resourcesIt.next() as IResource : this.resource;
			}
			else
			{	
				this.resource = resourcesIt.next() as IResource;
			}	
			
			if ( resource.type == Resource.TXT || resource.type == Resource.XMLFILE )
			{
				urlLoader = new URLLoader();
				urlLoader.addEventListener( Event.COMPLETE, complete );
				urlLoader.addEventListener( ProgressEvent.PROGRESS, progress );
				urlLoader.addEventListener( IOErrorEvent.IO_ERROR, error );
				urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, error );
				urlLoader.load( new URLRequest( resource.uri ));
			}
			else
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete );
				loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progress );
				loader.addEventListener( IOErrorEvent.IO_ERROR, error );
				loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, error );
				loader.load( new URLRequest( resource.uri ), resource.context );		
			}
		}

		public function reset():void
		{
			resources.purge();
			resources = new Collection();
		}

		override public function purge():void
		{
			state = CLOSED;
			resourcesIt.purge();
			resourcesIt = null;			
		}
		
		public function findResource( id:String ):IResource
		{
			return resources.find( "id", id ) as IResource;
		}

		public function set state( value:String ):void
		{
			states.stateKey = value;
			notifyObservers( data );
		}
		
		public function getResources():ICollection
		{
			return resources;	
		}
		
		public function get state():String 
		{
			return states.stateKey;
		}
		
		public function get locale():String
		{
			return _locale;
		}
		
		public function set locale( value:String ):void
		{
			_locale = value;
		}		
		
		override protected function parseType( uri:String ):int
		{
			state = OPEN;			
			var pattern:RegExp = /\.[\w]+/gi;
			var ext:Array = uri.match( pattern );
			var type:int = 0;
			var fileString : String = ext.length == 0 ? "" : ext[ext.length-1];
			switch ( fileString.toLowerCase() )
			{
				case ".xml":
					type = Resource.XMLFILE;
					break;
				case ".txt":
					type = Resource.TXT;
					break;
				case ".swf":
					type = Resource.SWF;
					break;
				case ".bmp": 
				case ".jpg": 
				case ".jpeg": 
				case ".gif":
				case ".png":
					type = Resource.IMAGE;
					break;
				case ".flv":
					type = Resource.VIDEO;
					break;
				default: break;
			}
			return type;
		}
		
		override protected function parseID( uri:String ):String
		{
			var pattern:RegExp = /[^\/][\w-]+\.[\w]+/gi;
			var ext:Array = uri.match( pattern );
			return ext.length == 0 ? "" : ext[ext.length-1];
		}
		
		private function error( event:ErrorEvent ):void
		{
			trace( "error", event.text );
		}

		private function progress( event:ProgressEvent ):void
		{
			var percent:int = Math.round( event.bytesLoaded / event.bytesTotal * 100 );
			notifyObservers( percent );
		}

		private function complete( event:Event ):void
		{
			event.currentTarget.removeEventListener( Event.COMPLETE, complete );
			event.currentTarget.removeEventListener( ProgressEvent.PROGRESS, progress );
			event.currentTarget.removeEventListener( IOErrorEvent.IO_ERROR, error );
			event.currentTarget.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, error );
			
			switch ( resource.type )
			{
				case Resource.XMLFILE:
					if ( resource.parser )
					{
						resource.parser.raw = XML( event.target.data );
						resource.parser.resourceID = resource.id;
						resource.parser.observers = observers;
						resource.parser.parse(); 
						resource.data = resource.parser.data;
						resource.parser.notifyObservers( resource.data );
					}
					else
					{
						resource.data = XML( event.target.data );
					}	
					state = RESOURCE_COMPLETE;					
					loadNext();
					break;
					
				case Resource.TXT: 
					break;
					
				case Resource.SWF:
				case Resource.IMAGE: 					
					if ( resource.parser )
					{
					 	resource.parser.raw = DisplayObject( event.target.content );;
					 	resource.parser.addEventListener( Event.COMPLETE, parseComplete );
					 	resource.parser.appDomain = event.currentTarget.applicationDomain;
					 	resource.parser.resourceID = resource.id;
						resource.parser.locale = _locale;
						resource.parser.observers = observers;
					 	resource.parser.parse();						
					}
					else
					{
						resource.data = DisplayObject( event.target.content );
						state = RESOURCE_COMPLETE;
						loadNext();
					}					
					break;
				default: break;
			}						

		}

		private function parseComplete( event:Event ):void
		{
			resource.data = resource.parser.data;
			resource.parser.notifyObservers( resource.data );			
			state = RESOURCE_COMPLETE;			
			loadNext();
		}
		
		private function loadNext():void
		{
			if ( resourcesIt.hasNext() ) create();
			else
			{
				initialized = false;
				currentIndex = resourcesIt.index();
				state = RESOURCE_FACTORY_COMPLETE;
			}
		}

		private function notifyObservers( data:* = null ):void
		{
			// Notify all observers
			var observer:IObserver;
			var observeState:Object;
			var it:IIterator = observers.iterator();
			while ( it.hasNext() )
			{
				observer = it.next() as IObserver;
				observeState = observer.observeState( states.stateKey );
				
				// Only notify if the observer registered for this state				
				if ( states.stateKey && observeState )
				{
					if ( observeState.callback ) observeState.callback( new ObserverDetail( this, states.state, data ));
					else observer.notify( new ObserverDetail( this, states.state, data ));
				}
			}
			it.purge();
			it = null;
			observeState = null;
			observer = null;
		}
	}
}
