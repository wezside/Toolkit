package com.wezside.utilities.binding 
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Binding extends EventDispatcher
	{

		private var collection:BindingCollection;
		private var map:BindingMap;

		public function Binding() 
		{
			collection = new BindingCollection();	
		}
		
		public function bind( src:Object, srcProp:String, target:Object, targetProp:String ):void 
		{
			map = new BindingMap();
			map.src = src;
			map.srcProp = srcProp;
			map.target = target;
			map.targetProp = targetProp;
			map.listen();
			collection.addElement( map );			
		}
		
		public function unBindAll():void
		{
			var iterator:IBindingIterator = collection.iterator();
			while ( iterator.hasNext() )
				BindingMap( iterator.next() ).purge();
		}

		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
	}
}
