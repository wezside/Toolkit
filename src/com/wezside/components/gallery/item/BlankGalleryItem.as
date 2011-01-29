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
package com.wezside.components.gallery.item 
{
	import com.wezside.components.gallery.GalleryEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BlankGalleryItem extends AbstractGalleryItem
	{

		
		public function BlankGalleryItem( type:String, debug:Boolean ) 
		{
			super( type, debug );
		}
		
		
		override public function load( url:String, livedate:Date, linkage:String = "", thumbWidth:int = 80, thumbHeight:int = 80 ):void
		{
			var bmpdata:BitmapData = new BitmapData( thumbWidth, thumbHeight, false, 0x333333 );
			var bitmap:Bitmap = new Bitmap( bmpdata );
			addChildAt( bitmap, 0 );
			
			mouseEnabled = false;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_LOAD_COMPLETE, false, false, this ));	
		}
		
		override public function set state( value:String ):void
		{
		}		
	}
}
