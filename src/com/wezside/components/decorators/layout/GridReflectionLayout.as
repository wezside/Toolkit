package com.wezside.components.decorators.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class GridReflectionLayout extends Layout 
	{
		private var xOffset:Number;
		private var yOffset:Number;
		private var currentRow:int;
		private var startX:Number;

		private var _hasReflections:Boolean = false;

		
		public function GridReflectionLayout( decorated:IUIDecorator )
		{
			super( decorated );
			this.decorated = decorated;
		}


		/**
		 * Lay the items out in the specified columns and rows including the reflections with their alpha 
		 * settings. 
		*/
		override public function arrange():void
		{
		
			var item:DisplayObject;
			var reflection:DisplayObject;
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			var counter:int = 0;
						
			startX = 0;
			xOffset = 0;
			yOffset = 0;
			currentRow = 0;
			
			while ( iterator.hasNext() )
			{
				item = iterator.next() as DisplayObject;				
				item.x += xOffset; 
				item.y += yOffset;
				++counter;

				if ( _hasReflections )
				{
					reflection = iterator.next() as DisplayObject;
					reflection.x += xOffset;
					var posY:int = ( rows - currentRow ) * ( item.height + verticalGap ) * 2 - item.height;
					reflection.y += posY + yOffset - verticalGap;
				}

				if ( counter % columns == 0  )
				{
					++currentRow;
					yOffset += height + verticalGap;
					xOffset = startX;
				}
				else
				{
					xOffset += width + horizontalGap;
				}
			}
			
			iterator.purge();
			iterator = null;
			
	 		width = decorated.width + left + right;
			height = decorated.height + top + bottom;
			super.arrange();
		}
		
		public function get hasReflections():Boolean
		{
			return _hasReflections;
		}
		
		public function set hasReflections( value:Boolean ):void
		{
			_hasReflections = value;
		}
	}
}
