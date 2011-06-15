/**
 * Copyright (c) 2011 Wesley Swanepoel
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
package com.wezside.component.decorators.layout 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.UIElement;
	import com.wezside.component.decorators.shape.IShape;
	import com.wezside.data.collection.DictionaryCollection;
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
		private var originalPos:DictionaryCollection;

		public function PaddedLayout( decorated:IUIDecorator )
		{
			super( decorated );
			// TODO: Purge
			originalPos = new DictionaryCollection();
		}
		
		/**
		 * If decorated.width == 0 then it means the decorated is an ILayout
		 */
		override public function arrange():void
		{				
			var child:DisplayObject;
			var it:IIterator;
			var element:*;
			var index:int = 0;
			it = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			while ( it.hasNext())
			{
				child = it.next() as DisplayObject;
				index = it.index() - 1;
				
				// Skip the background 
				if ( child is IShape ) child = it.next() as DisplayObject;
				element = originalPos.getElement( index );				
			
				if ( element )
				{
					if ( element.width != child.width )
						break;
					if ( element.height != child.height )
						break;

					child.x = element.x;
					child.y = element.y;
				}
				else
				{
					if ( child.x == 0 && child.y == 0 )
					{						
						child.x = left;
						child.y = top;
					}
					else
					{
						// Child's X & Y position were changed by other decorators or 
						// system
						child.x += left;
						child.y += top;
					}	
				}
				originalPos.addElement( index, { x: child.x, y: child.y, width: child.width, height: child.height });
			}

			if ( width == 0 && height == 0 )
			{
				width = int( decorated.width + left + right );
				height = int( decorated.height + top + bottom );
			}
			
			it.purge();			
			it = null;
			child = null;
			element = null;
			super.arrange();
		}
			
		override public function reset():void
		{
			var it:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
			var child:DisplayObject;
			while ( it.hasNext() )
			{
				child = it.next() as DisplayObject;
				if ( child is IShape ) child = it.next() as DisplayObject;		
				child.x = 0;
				child.y = 0;
			}
			it.purge();
			it = null;
			child = null;
		}
	}
}