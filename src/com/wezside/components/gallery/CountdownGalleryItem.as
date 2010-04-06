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
	import com.wezside.utilities.date.DateUtils;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class CountdownGalleryItem extends Sprite implements IGalleryItem 
	{

		
		private var livedate:Date;
		private var field:TextField;
		private var bmpdata:BitmapData;
		private var fmt:TextFormat;
		private var bitmap:Bitmap;
		private var _type:String;
		private var _debug:Boolean;

		
		public function CountdownGalleryItem( type:String, debug:Boolean )
		{
			super();
			this.type = type;
			_debug = debug;
		}


		public function load( url:String, livedate:Date ):void
		{
			this.livedate = livedate;
			
			fmt = new TextFormat("Arial", 80, 0x666666 );
			fmt.align = TextFormatAlign.CENTER;
				
			field = new TextField();
			field.embedFonts = false;
			field.width = 640;
			field.height = 300;
			field.text = "00:00:00:00";
			field.selectable = false;
			field.mouseEnabled = false;
			field.setTextFormat( fmt );
			
			bmpdata = new BitmapData( 760, 510, false, 0x222222 );
			bitmap = new Bitmap( bmpdata );
			addChildAt( bitmap, 0 );
			addChildAt( field, 1 );
			
			field.x = width * 0.5 - field.width * 0.5;
			field.y = height * 0.5 - field.textHeight * 0.5;;
			
			mouseEnabled = false;
			dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_LOAD_COMPLETE, false, false, this ));
							
			addEventListener( Event.ENTER_FRAME, enterFrame );
		}		

		public function play():void
		{
		}

		public function stop():void
		{
			removeEventListener( Event.ENTER_FRAME, enterFrame );
		}				
		
		public function rollOver( object:Object = null ):void
		{
		}
		
		public function rollOut( object:Object = null ):void
		{
		}		
			
		public function get enable():Boolean
		{
			return true;
		}
		
		public function set enable( value:Boolean ):void
		{
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
			removeEventListener( Event.ENTER_FRAME, enterFrame );			
			removeChildAt( 0 );
			removeChildAt( 1 );
			field = null;
			bitmap = null;
			bmpdata = null;
		}		
		
		private function enterFrame( event:Event ):void
		{
			var data:Array = DateUtils.getInstance().getCountDown( livedate );			
			field.text = doubleDigit( data[3] ) + ":" + doubleDigit( data[2] ) + ":" + doubleDigit( data[1] ) + ":" + doubleDigit( data[0] );
			field.setTextFormat( fmt );
		}
		
		
		private function doubleDigit( str:String ):String
		{
			if ( str.length == 1 ) str = "0" + str;
			return str;
		}		
	}
}
