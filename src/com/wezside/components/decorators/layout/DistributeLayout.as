package com.wezside.components.decorators.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class DistributeLayout extends Layout 
	{
				
		public static const DISTRIBUTE_H:int = 0;
		public static const DISTRIBUTE_V:int = 1;
		public static const DISTRIBUTE_HV:int = 3;
		
		private var _distribute:int = DISTRIBUTE_H;

		public function DistributeLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}
		
		override public function arrange():void 
		{			
			var it:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			var object:DisplayObject;
			while ( it.hasNext() )
			{
				object = it.next() as DisplayObject;
				if ( distribute == DISTRIBUTE_H )
				{
					object.x = ( width - object.width ) * 0.5;
				}
				if ( distribute == DISTRIBUTE_V )
				{
					object.y = ( height - object.height ) * 0.5;
				}
				if ( distribute == DISTRIBUTE_HV )
				{
					object.x = ( width - object.width ) * 0.5;
					object.y = ( height - object.height ) * 0.5;
				}
			}
			it.purge();
			it = null;
			object = null;
			
			super.arrange( );
		}
		
		public function get distribute():int
		{
			return _distribute;
		}
		
		public function set distribute( value:int ):void
		{
			_distribute = value;
		}
	}
}
