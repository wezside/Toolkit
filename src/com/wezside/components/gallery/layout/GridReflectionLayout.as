package com.wezside.components.gallery.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.layout.Layout;
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

		private var _rows:int;
		private var _columns:int;
		private var _largestItemHeight:int;
		private var _largestItemWidth:int;
		private var _reflectionHeightInRows:int;

		
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
						
			startX = 0;
			currentRow = 0;
			xOffset = 0;
			yOffset = 0;
			
			while ( iterator.hasNext() )
			{
				item = iterator.next() as DisplayObject;
				item.x += xOffset; 
				item.y += yOffset;
				
				if ( reflectionHeightInRows > 0 )
				{
					reflection = iterator.next() as DisplayObject;
					reflection.x += xOffset;
					var posY:int = ( _rows - currentRow ) * ( item.height + verticalGap ) * 2 - item.height;
					reflection.y += posY + yOffset - verticalGap;
				}
				
				if (( int( item.name ) + 1 ) % ( _columns ) == 0  )
				{
					++currentRow;
					yOffset += _largestItemHeight + verticalGap;
					xOffset = startX;
				}
				else
				{
					xOffset += _largestItemWidth + horizontalGap;
				}
				

					
			}
			
			dispatchEvent( new UIElementEvent( UIElementEvent.ARRANGE_COMPLETE ));
		}
		
		public function get rows():int
		{
			return _rows;
		}
		
		public function set rows( value:int ):void
		{
			_rows = value;
		}
		
		public function get columns():int
		{
			return _columns;
		}
		
		public function set columns( value:int ):void
		{
			_columns = value;
		}
		
		public function get largestItemHeight():int
		{
			return _largestItemHeight;
		}
		
		public function set largestItemHeight( value:int ):void
		{
			_largestItemHeight = value;
		} 		
		
		public function get largestItemWidth():int
		{
			return _largestItemWidth;
		}
		
		public function set largestItemWidth( value:int ):void
		{
			_largestItemWidth = value;
		}
		
		public function get reflectionHeightInRows():int
		{
			return _reflectionHeightInRows;
		}
		
		public function set reflectionHeightInRows( value:int ):void
		{
			_reflectionHeightInRows = value;
		}
	}
}
