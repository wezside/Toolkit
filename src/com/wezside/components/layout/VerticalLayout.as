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
	public class VerticalLayout extends Layout 
	{

		private var yOffset:int;


		public function VerticalLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function arrange( event:UIElementEvent = null ):void
		{
			super.arrange();
			
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );			
			if ( iterator.hasNext() )
			{
				var firstChild:DisplayObject = iterator.next() as DisplayObject;
				yOffset = firstChild.y;
			}
			iterator.reset();
			
			// Skip the background which is always the first child
			iterator.next();
			
			// Iterate over rest of the children and layout vertically
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.y = yOffset;
				yOffset += child.height;
				if ( iterator.hasNext() ) yOffset += verticalGap;
			}
			
			height = yOffset - verticalGap;
	 		width = decorated.width;
		}


		override public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
	}
}