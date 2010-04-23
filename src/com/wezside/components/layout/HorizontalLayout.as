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
	public class HorizontalLayout extends Layout 
	{
		
		private var xOffset:int;

		public function HorizontalLayout( decorated:IUIDecorator )
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
				xOffset = firstChild.x;
			}
			iterator.reset();
			
			// Skip the background which is always the first child
			iterator.next();				
						
			// Iterate over rest of the children and layout horizontally
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x = xOffset;
				xOffset += child.width;
				if ( iterator.hasNext() ) xOffset += horizontalGap;
			}			
			
			width = xOffset - horizontalGap;
	 		height = decorated.height;			
		}	

		override public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
	
	}
}