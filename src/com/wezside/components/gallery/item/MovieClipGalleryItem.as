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
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MovieClipGalleryItem extends AbstractGalleryItem
	{
		
		private var linkageID:String;
		private var mc:MovieClip;

		public function MovieClipGalleryItem( type:String, debug:Boolean ) 
		{
			super( type, debug );
		}
				
		override public function load( url:String, livedate:Date, linkage:String = "", thumbWidth:int = 80, thumbHeight:int = 80 ):void
		{						
			mouseEnabled = false;
			this.livedate = livedate;
			this.linkageID = linkageID;
			Tracer.output( debug, " ("+url+", " + livedate + ")", toString() );
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_PROGRESS, false, false, 0 ));
			
			loader = new Loader( );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete );	
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progress );	
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, error );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.NETWORK_ERROR, error );
			loader.load( new URLRequest( url ));	
		}
		
		override public function rollOver():void
		{
			super.rollOver();
			mc.play();
		}
		
		override public function rollOut():void
		{
			super.rollOut();
			mc.gotoAndStop( 1 );			
		}		
		
		protected function progress( event:ProgressEvent ):void
		{
			var percent:Number = ( event.bytesLoaded / event.bytesTotal ) * 100;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_PROGRESS, false, false, percent ));
		}

		protected function complete( event:Event ):void
		{
			var MCClass:Class = event.currentTarget.applicationDomain.getDefinition( this.linkageID ) as Class;
			mc = new MCClass() as MovieClip;			
			if ( mc ) 
			{
				mc.gotoAndStop( 1 );
				addChild( mc );			
			}
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_LOAD_COMPLETE, false, false, this ));			
		}
		
		protected function error( event:IOErrorEvent ):void
		{
			Tracer.output( debug, " ImageVideoWallItem.error(event) " + event.text, toString() );
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_ERROR  ));
		}			
	}
}
