package com.wezside.utilities.factory
{
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.parser.IParser;
	import com.wezside.utilities.observer.IObserver;

	import flash.system.LoaderContext;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AbstractResourceFactory implements IFactory
	{
		
		
		protected var uri:String;
		protected var resource:IResource;
		protected var resources:ICollection;
	
		
		// Template method
		public function createResource( uri:String, parser:IParser = null, context:LoaderContext = null ):void
		{			
			resource = new Resource();
			resource.id = parseID( uri );
			resource.type = parseType( uri );
			resource.uri = uri;
			resource.parser = parser;
			resource.context = context;
			resources.addElement( resource );
		}
		
		public function registerObserver( observer:IObserver ):void
		{
			throw new Error( "Abstract Method" );
		}
		
		public function unregisterObserver( observer:IObserver ):void
		{
			throw new Error( "Abstract Method" );
		}
		
		public function create():void
		{
			throw new Error( "Abstract Method" );
		}

		public function purge():void
		{
			throw new Error( "Abstract Method" );			
		}

		protected function parseType( uri:String ):int
		{
			throw new Error( "Abstract Method" );
		}
		
		protected function parseID( uri:String ):String		
		{
			throw new Error( "Abstract Method" );
		}
	
	}
}
