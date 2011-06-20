package com.wezside.component.decorator.layout
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.UIElement;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;


	/**
	 * @author Sean Lailvaux
	 */
	public class FillLayout extends Layout {
		
		public var horizontalFill 	: Boolean;
		public var verticalFill 	: Boolean;
		public var widthRatio 		: Number;
		public var heightRatio 		: Number;
		public var baseWidth 		: Number;		public var baseHeight 		: Number;
		
		private var _prevWidth 		: Number;		private var _prevHeight 	: Number;
		
		
		public function FillLayout( decorated:IUIDecorator ) {
			super( decorated );
		}
		
		override public function arrange() : void {
			
			var it : IIterator;
			var child : DisplayObject;
			var target : DisplayObject;
			var updated : Boolean = false;
			
			if ( horizontalFill ) {
				
				// Test for % use in width or fixedWidth
				if ( ( widthRatio > 0 && baseWidth > 0 ) || _prevWidth != width ) {
					
					_prevWidth = width;
					
					it = decorated.iterator( UIElement.ITERATOR_CHILDREN );
					
					var totalFixedWidth : Number = 0;
					
					while ( it.hasNext()) {
						
						child = DisplayObject( it.next() );
						
						if ( !target ) {
							target = child;
						}
						else if ( target && sameRow( child, target ) ) {
							totalFixedWidth += child.width;
							if ( it.hasNext() ) totalFixedWidth += horizontalGap;
						}
					}
					
					width = widthRatio > 0 ? ( baseWidth - left - right ) * widthRatio : _prevWidth;
					
					if ( target ) {
						target.width = width - totalFixedWidth - horizontalGap;
					}
					
					it.purge();
					it = null;
					child = null;
					target = null;					
					updated = true;
				}
			}
			
			if ( verticalFill ) {
				
				// Test for % use in width or fixedWidth
				if ( ( heightRatio > 0 && baseHeight > 0 ) || _prevHeight != height ) {
					
					_prevHeight = height;
					
					it = decorated.iterator( UIElement.ITERATOR_CHILDREN );
					
					var totalFixedHeight : Number = 0;
					
					while ( it.hasNext()) {
						
						child = DisplayObject( it.next() );
						
						if ( !target ) {
							target = child;
						}
						else if ( target && sameColumn( child, target ) ) {
							totalFixedHeight += child.height;
							if ( it.hasNext() ) totalFixedHeight += verticalGap;
						}
					}
					
					height = heightRatio > 0 ? ( baseHeight - top - bottom ) * heightRatio : _prevHeight;
					
					if ( target ) {
						target.height = height - totalFixedHeight - verticalGap;
					}
					
					it.purge();
					it = null;
					child = null;
					target = null;
					
					updated = true;
				}
			}
			
			if ( updated ) super.arrange();
		}
		
		private function sameColumn( child : DisplayObject, target : DisplayObject ) : Boolean {
			
			var tPos : Number = target.x;
			var cPos : Number = child.x;
			
			if ( target is IUIElement ) tPos += left;
			if ( child is IUIElement ) cPos += left;
			
			return ( tPos == cPos );
		}
		
		private function sameRow( child : DisplayObject, target : DisplayObject ) : Boolean {
			
			var tPos : Number = target.y;
			var cPos : Number = child.y;
			
			if ( target is IUIElement ) tPos += top;
			if ( child is IUIElement ) cPos += top;
			
			return ( tPos == cPos );
		}
	}
}