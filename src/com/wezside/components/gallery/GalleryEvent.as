/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.components.gallery 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class GalleryEvent extends Event
	{
		
		public static const ITEM_ERROR:String = "itemLoadError";
		public static const ITEM_CLICK:String = "itemClick";	
		public static const ITEM_ROLLOUT:String = "itemRollOut";	
		public static const ITEM_ROLLOVER:String = "itemRollOver";	
		public static const ITEM_PROGRESS:String = "itemProgress";
		public static const ITEM_LOAD_COMPLETE:String = "itemLoadComplete";
		public static const LOAD_COMPLETE:String = "allItemsLoadComplete";
		public static const ARRANGE_COMPLETE:String = "arrangeComplete";
		public static const INTRO_COMPLETE:String = "introComplete";
		public static const OUTRO_COMPLETE:String = "outroComplete";

		public var data:*;

		public function GalleryEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null )
		{
			super( type, bubbles, cancelable );
			this.data = data;
		}
		
        override public function clone():Event 
        {
            return new GalleryEvent( type, false, false, data );
        }				
	}
}
