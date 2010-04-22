package com.wezside.components.layout 
{
	import com.wezside.utilities.logging.Tracer;
	import flash.display.DisplayObject;
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class HorizontalLayout extends Layout 
	{
		
		private var xOffset:int;
		private var _decorated:IUIDecorator;

		public function HorizontalLayout( decorated:IUIDecorator )
		{
			_decorated = decorated;
			this.decorated = decorated;
		}

		override public function arrange( event:UIElementEvent = null ):void
		{
			super.arrange();
			Tracer.output( true, " HorizontalLayout.arrange(event)", toString() );
			var iterator:IIterator = _decorated.iterator( UIElement.ITERATOR_CHILDREN );
			if ( iterator.hasNext() )
				xOffset = DisplayObject( iterator.next() ).x;
			iterator.reset();
			
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x = xOffset;
				xOffset += child.width + horizontalGap;
			}			
		}
	
				
		override public function iterator( type:String = null ):IIterator
		{
			return _decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
	
	}
}