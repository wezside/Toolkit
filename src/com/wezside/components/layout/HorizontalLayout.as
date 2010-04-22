package com.wezside.components.layout 
{
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
		private var _horizontalGap:int = 0;


		public function HorizontalLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function arrange( event:UIElementEvent = null ):void
		{
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			if ( iterator.hasNext() )
				xOffset = DisplayObject( iterator.next() ).x;
			iterator.reset();
			
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				child.x = xOffset;
				xOffset += child.width + _horizontalGap;
			}
			
			super.arrange();
		}
				
		override public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		override public function set horizontalGap( value:int ):void
		{
			_horizontalGap = value;
		}
	}
}