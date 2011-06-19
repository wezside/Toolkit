package com.wezside.component.decorator.layout
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.UIElement;
	import com.wezside.data.iterator.IIterator;
	import flash.display.DisplayObject;


	/**
	 * @author Sean Lailvaux
	 */
	public class FlowLayout extends Layout {
		
		private var xOffset 	: int;		private var yOffset 	: int;
		
		public var maxWidth 	: int;
		
		
		public function FlowLayout( decorated : IUIDecorator ) {
			super( decorated );
		}
		
		/**
		 * Note: This is not meant to be chained with other Layout decorators
		 * This is purely just for one user case so padding is ignored
		 */
		override public function arrange() : void {
			
			xOffset = 0;
			yOffset = 0;
			
			var it : IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			var child : DisplayObject;
			
			while ( it.hasNext( )) {
				
				child = DisplayObject( it.next( ) );
				
				// if child won't fit
				if ( maxWidth > 0 && xOffset + child.width > maxWidth ) {
					xOffset = 0;
					yOffset += child.height + verticalGap;
				}
				
				child.x = xOffset;				child.y = yOffset;
				xOffset += child.width;
				
				if ( it.hasNext( ) ) xOffset += horizontalGap;
			}
			
			// Top and bottom properties will be zero if HorizontalLayout is the first decorator
			// however if it isn't then we need to update the width + height correctly with
			// the padding properties in case they were used
			width = xOffset + right;
			height = decorated.height + top + bottom;
			if ( it.length( ) > 1 ) width -= horizontalGap;
			
			it.purge();
			it = null;
			child = null;
			
			super.arrange();
		}
	}
}