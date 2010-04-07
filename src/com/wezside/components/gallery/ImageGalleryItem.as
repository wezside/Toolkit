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
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ImageGalleryItem extends Sprite implements IGalleryItem
	{

		protected var livedate:Date;
		protected var loader:Loader;

		private var _type:String;
		private var _debug:Boolean;
		private var _sm:StateManager;
		private var _selected:Boolean;

		
		public function ImageGalleryItem( type:String, debug:Boolean )
		{
			super( );			
			_type = type;
			_debug = debug;
			_selected = false;
			_sm = new StateManager();
			_sm.addState( Gallery.STATE_ROLLOVER );
			_sm.addState( Gallery.STATE_ROLLOUT );
			_sm.addState( Gallery.STATE_SELECTED, true );	
		}		
		
		
		public function load( url:String, livedate:Date ):void
		{
			Tracer.output( _debug, " ("+url+", " + livedate + ")", toString() );
			this.livedate = livedate;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_PROGRESS, false, false, 0 ));
			
			loader = new Loader( );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete );	
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progress );	
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, error );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.NETWORK_ERROR, error );
			loader.load( new URLRequest( url ));				
		}		
		
		public function play():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function rollOver():void
		{
			alpha = 1;
		}		
		
		public function rollOut():void
		{
			alpha = 0.5;
		}		
		
		public function get state():String
		{
			return _sm.state;
		}
		
		public function set state( value:String ):void
		{
			_sm.state = value;

			switch ( _sm.stateKey )
			{
				case Gallery.STATE_ROLLOUT:	trace("Normal rollout " + _sm.stateKey ); rollOut(); break;
				case Gallery.STATE_ROLLOUT + Gallery.STATE_SELECTED: trace("SELECTED rollout" ); break;
									
				case Gallery.STATE_ROLLOVER: rollOver(); break;
				case Gallery.STATE_ROLLOVER + Gallery.STATE_SELECTED: break;
				
				case Gallery.STATE_SELECTED: selected = !_selected; break;					
				default: break;
			}
		}	
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected( value:Boolean ):void
		{
			_selected = value;
			alpha = 0.1;	
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
		
		public function purge():void
		{
			_sm.purge();
			removeChildAt( 0 );
			livedate = null;
		}						
		
		protected function progress( event:ProgressEvent ):void
		{
			var percent:Number = ( event.bytesLoaded / event.bytesTotal ) * 100;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_PROGRESS, false, false, percent ));
		}

		protected function complete( event:Event ):void
		{
			var img:Bitmap = new Bitmap( event.currentTarget.content.bitmapData );
			img.smoothing = true;
			addChildAt( img, 0 );
			alpha = 0.5;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_LOAD_COMPLETE, false, false, this ));			
		}
		
		protected function error( event:IOErrorEvent ):void
		{
			Tracer.output( true, " ImageVideoWallItem.error(event) " + event.text, toString() );
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_ERROR  ));
		}		
	}
}
