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
package com.wezside.components.decorators.layout
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VerticalLayout extends Layout
	{
		private var yOffset:int = 0;

		public function VerticalLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function arrange() : void
		{
			// Iterate over rest of the children and layout horizontally
			yOffset = 0;
			yOffset += top;
			var it:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			var child:DisplayObject;
			while ( it.hasNext())
			{
				child = DisplayObject( it.next() );
				child.y = yOffset | 0;
				yOffset += child.height;
				if ( it.hasNext() )
					yOffset += verticalGap;
			}
			
			// Left and right properties will be zero if VerticalLayout is the first decorator
			// however if it isn't then we need to update the width + height correctly with 
			// the padding properties in case they were used 
			width = decorated.width + left + right;
			height = yOffset + bottom;
			if ( it.length() > 1 )
				height -= verticalGap;
				
			// Clean up
			it.purge();
			it = null;
			child = null;
			super.arrange();
		}
	}
}