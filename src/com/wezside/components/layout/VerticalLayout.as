package com.wezside.components.layout 
{
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VerticalLayout extends Layout 
	{

		private var yOffset:int;
		private var xOffset:int;
		private var _decorated:IUIDecorator;

		public function VerticalLayout( decorated:IUIDecorator )
		{
			_decorated = decorated;
			this.decorated = decorated;
		}

		override public function arrange( event:UIElementEvent = null ):void
		{
			
			super.arrange();
			Tracer.output( true, " VerticalLayout.arrange(event)", toString() );
			var iterator:IIterator = _decorated.iterator( UIElement.ITERATOR_CHILDREN );
			
			if ( iterator.hasNext() )
			{
				var firstChild:DisplayObject = iterator.next() as DisplayObject;
				xOffset = firstChild.x;
				yOffset = firstChild.y;
			}
			iterator.reset();
			
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x = xOffset;
				child.y = yOffset;
				yOffset += child.height + verticalGap;
			}
		}

		override public function iterator( type:String = null ):IIterator
		{
			return _decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
	}
}