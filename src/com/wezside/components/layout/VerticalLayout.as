/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
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
			var firstChild:DisplayObject;
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );			
			if ( iterator.hasNext() )
			{
				firstChild = iterator.next() as DisplayObject;
				yOffset = firstChild.y;
			}
			iterator.reset();
			
			// Skip the background which is always the first child
			iterator.next();
			
			// Iterate over rest of the children and layout vertically
			while ( iterator.hasNext())
			{
				var child:DisplayObject = iterator.next() as DisplayObject;
				if ( child is IUIDecorator )
				{
					child.y = yOffset;
					yOffset += child.height;
					if ( iterator.hasNext() ) yOffset += verticalGap;
				}
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