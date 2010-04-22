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
	public class VerticalLayout extends Layout 
	{

		private var yOffset:int;
		private var xOffset:int;
		private var _verticalGap:int = 0;

		public function VerticalLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function arrange( event:UIElementEvent = null ):void
		{
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
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
				yOffset += child.height + _verticalGap;
			}
			
			super.arrange();
		}
				
		override public function get horizontalGap():int
		{
			return _verticalGap;
		}
		
		override public function set horizontalGap( value:int ):void
		{
			_verticalGap = value;
		}
	}
}