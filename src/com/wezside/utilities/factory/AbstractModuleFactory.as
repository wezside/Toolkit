package com.wezside.utilities.factory
{
	import com.wezside.data.collection.Collection;
	import com.wezside.utilities.observer.IObserver;
	
	/**
	 * @author Wesley.Swanepoel
	 */
	public class AbstractModuleFactory implements IFactory
	{
		
		protected var modules:Collection = new Collection();
		protected var module:ModuleResource;
		
		// Template method
		public function createModule( uri:String, dataID:String, serviceID:String = "" ):void
		{
			module = new ModuleResource();
			module.id = parseID( uri );
			module.uri = uri;
			module.dataID = dataID;
			module.serviceID = serviceID;
			module.qualifiedName = uri;
			modules.addElement( module );
		}
		
		public function create( resource:IModuleResource = null ):void
		{
			throw new Error( "Abstract Method" );
		}		
		
		public function registerObserver( observer:IObserver ):void
		{
			throw new Error( "Abstract Method" );
		}
		
		public function unregisterObserver( observer:IObserver ):void
		{
			throw new Error( "Abstract Method" );
		}
		
		public function purge():void
		{
			throw new Error( "Abstract Method" );			
		}
		
		public function parseID( uri:String ):String		
		{
			throw new Error( "Abstract Method" );
		}		
		
		public function parseDataID( uri:String ):String		
		{
			throw new Error( "Abstract Method" );
		}		
			
	}
}
