/*
	The MIT License

	Copyright (c) 2009 Wesley Swanepoel
	
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
package com.wezside.sample.gallery
{
	import com.wezside.components.gallery.GalleryEvent;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.1
	 */
	public class GalleryTransition extends GalleryPaging 
	{

		
		private var transition:DefaultTransition;
		

		override protected function galleryArrangeComplete( event:GalleryEvent ):void
		{
			super.galleryArrangeComplete( event );			
			transition = new DefaultTransition( COLUMNS, ROWS );
			transition.galleryInstance = gallery;
			transition.stageWidth = stage.stageWidth;
			transition.stageHeight = stage.stageHeight;			
			gallery.intro( transition );
		}

		
		/**
		 * To use a transition it is necessary to pass an object of type IGalleryTransition as 
		 * parameter for the intro and outro methods.
		 */
		override protected function page( event:Event ):void
		{
			if ( event.currentTarget.name == "pageLeft" && currentPageIndex > 0  )
			{
				currentPageIndex--;
				transition.direction = "right";
				gallery.outro( transition );
			}
			
			if ( event.currentTarget.name == "pageRight" && currentPageIndex < totalPageCount )
			{
				currentPageIndex++;
				transition.direction = "right";
				gallery.outro( transition );
			}
		}	
	}
}
