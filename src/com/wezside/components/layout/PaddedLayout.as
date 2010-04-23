package com.wezside.components.layout 
{
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

		
		public function PaddedLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}

		
		override public function arrange( event:UIElementEvent = null ):void
		{
			super.arrange();

			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			iterator.next();
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x += left;
				child.y += top;
			}
	
			if ( decorated is ILayout )
			{
				width = ILayout( decorated ).width;
				height = ILayout( decorated ).height;
			}
		}

		override public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}

	}
}
