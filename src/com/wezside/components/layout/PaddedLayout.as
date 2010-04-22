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
	public class PaddedLayout extends Layout 
	{
		private var _decorated:IUIDecorator;

		
		public function PaddedLayout( decorated:IUIDecorator )
		{
			_decorated = decorated;
			this.decorated = decorated;
		}

		
		override public function arrange( event:UIElementEvent = null ):void
		{
			super.arrange();
			Tracer.output( true, " PaddedLayout.arrange(event)", toString() );
			var iterator:IIterator = _decorated.iterator( UIElement.ITERATOR_CHILDREN );
			
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x += left;
				child.y += top;
			}
		}


		override public function iterator( type:String = null ):IIterator
		{
			return _decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}

	}
}
