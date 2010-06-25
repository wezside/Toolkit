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
	import com.wezside.components.decorators.shape.IShape;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * At firt the Padding lyout may seem redundant but it is necessary to udpate the children 
	 * with the padding to keep any shapes at the correct coordinates. 
	 */
	public class PaddedLayout extends Layout 
	{

		
		public function PaddedLayout( decorated:IUIDecorator )
		{
			super( decorated );
		}
		
		override public function arrange():void
		{	
			// Avoid set of padding if arrange has been called before for this decorator
			if ( width == 0 && height == 0 )
			{			
				var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
				while ( iterator.hasNext())
				{
					var child:DisplayObject = iterator.next() as DisplayObject;
					if ( child is IShape ) child = iterator.next() as DisplayObject;
					child.x += left;
					child.y += top;
				}
				
				width = int( decorated.width + left + right ) | 0;
				height = int( decorated.height + top + bottom ) | 0;
			}
			super.arrange();
		}
	}
}
