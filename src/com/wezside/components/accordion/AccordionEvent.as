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
package com.wezside.components.accordion 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionEvent extends Event 
	{
		public static const HEADER_CLICK:String = "headerClick";
		public static const CONTENT_CLICK:String = "contentClick";
		public static const SHOW_COMPLETE:String = "showComplete";
		public static const ARRANGE_COMPLETE:String = "arrangeComplete";
		
		public var data:*;
		public var selectedItem:uint;

		public function AccordionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, selectedItem:uint = 0, data:* = null )
		{
			super( type, bubbles, cancelable );
			this.data = data;
			this.selectedItem = selectedItem;
		}
		
		override public function clone():Event
		{
			return new AccordionEvent( type, bubbles, cancelable, selectedItem, data );
		}
	}
}
