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
package com.wezside.sample.gallery
{
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.1.001
	 * 
	 * A sample component showing how paging would be introduced when using the Scaffold-Gallery component. This example
	 * extends SampleBasic which basically creates and loads a simple gallery with no frills, i.e. no paging, animations etc.
	 */
	public class GalleryPaging extends GalleryBasic 
	{

		
		private var leftArrow:Sprite;
		private var rightArrow:Sprite;
		protected var totalPageCount:Number;

		
		public function GalleryPaging()
		{
			super( );
		}

		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
		
		
		/**
		 * <p>This handler is invoked when the GalleryEvent.ARANGE_COMPLETE event is dipatched. This event is 
		 * fired upon successful loading of all items in the dataprovider. We override this method from SampleBasic 
		 * so the arrows can be created for paging functionality.</p>
		 * 
		 * <p>The outro complete will be dispatched when the gallery's outro animation has fully played. Because we 
		 * haven't added any animations for intro and outro yet, the event will dispatch immediately. This event is 
		 * used to kill (remove) the gallery and create a new one with different parameters.</p> 
		 * 
		 * <p>The creation of the arrows is done here purely for this example, it could be created in the constructor 
		 * should there be no need for removing the arrows and creating them with a new page.</p>
		 */
		override protected function galleryArrangeComplete( event:GalleryEvent ):void
		{
			super.galleryArrangeComplete( event );
			totalPageCount = Math.floor( ( original.length - 1 ) / ( COLUMNS * ROWS ) );
			gallery.addEventListener( GalleryEvent.OUTRO_COMPLETE, outroComplete );
			createArrows( );
			setArrowState( );
			preloader.stop();
		}				

		
		protected function page( event:Event ):void
		{
			if ( event.currentTarget.name == "pageLeft" && currentPageIndex > 0  )
			{
				currentPageIndex--;
				gallery.outro( );
			}
			
			if ( event.currentTarget.name == "pageRight" && currentPageIndex < totalPageCount )
			{
				currentPageIndex++;
				gallery.outro( );
			}
		}

		
		override protected function purge():void
		{
			super.purge( );
			removeChild( leftArrow );
			removeChild( rightArrow );
			leftArrow = null;
			rightArrow = null;
		}

		
		private function outroComplete( event:GalleryEvent ):void
		{
			purge( );
			createGallery( );
		}

	
		
		private function introComplete( event:GalleryEvent ):void
		{
			Tracer.output( true, " SamplePaging.introComplete(event)", toString( ) );
		}

		
		private function createArrows():void
		{
			leftArrow = new Sprite( );
			leftArrow.name = "pageLeft";
			leftArrow.addEventListener( MouseEvent.CLICK, page );
			leftArrow.addEventListener( MouseEvent.ROLL_OVER, rollOver );
			leftArrow.addEventListener( MouseEvent.ROLL_OUT, rollOut );
			leftArrow.addChild( createField( "«" ) );
			leftArrow.x = 20;
			leftArrow.buttonMode = true;
			leftArrow.useHandCursor = true;
			leftArrow.y = gallery.getRowHeight( ROWS ) * 0.5 + 5;		
			
			rightArrow = new Sprite( );
			rightArrow.name = "pageRight";
			rightArrow.buttonMode = true;
			rightArrow.useHandCursor = true;
			rightArrow.addEventListener( MouseEvent.CLICK, page );
			rightArrow.addEventListener( MouseEvent.ROLL_OVER, rollOver );
			rightArrow.addEventListener( MouseEvent.ROLL_OUT, rollOut );			
			rightArrow.addChild( createField( "»" ) );
			
			rightArrow.x = gallery.width + gallery.x + 5;
			rightArrow.y = gallery.getRowHeight( ROWS ) * 0.5 + 5;
						
			addChild( leftArrow );
			addChild( rightArrow );
		}

		
		private function rollOut( event:MouseEvent ):void
		{
			if ( event.currentTarget.mouseEnabled )
			{			
				var arrow:Sprite = event.currentTarget as Sprite;
				arrow.filters = [];
				var tf:TextField = arrow.getChildAt( 0 ) as TextField;
				tf.setTextFormat( getFormat( ) );			
			}
		}

		
		private function rollOver( event:MouseEvent ):void
		{
			if ( event.currentTarget.mouseEnabled )
			{
				var arrow:Sprite = event.currentTarget as Sprite;
				arrow.filters = [ new GlowFilter( 0xffffff, 0.5, 4, 4 ) ];
				var tf:TextField = arrow.getChildAt( 0 ) as TextField;
				tf.setTextFormat( getFormat( 0xffffff ) );
			}
		}		

		
		private function setArrowState():void
		{
			currentPageIndex == 0 ? leftArrow.visible = false : leftArrow.visible = true;
			currentPageIndex == totalPageCount ? rightArrow.visible = false : rightArrow.visible = true;
		}

		
		private function getFormat( color:uint = 0x666666 ):TextFormat
		{
			var fmt:TextFormat = new TextFormat( );
			fmt.font = "Times";
			fmt.bold = true;
			fmt.size = 34;
			fmt.color = color;	
			return fmt;		
		}

		
		private function createField( value:String ):TextField
		{
			var tf:TextField = new TextField( );
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = value;
			tf.selectable = false;
			tf.setTextFormat( getFormat( ) );
			tf.width += 10;									
			return tf;
		}
	}
}
