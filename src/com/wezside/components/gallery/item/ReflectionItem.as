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
	import com.wezside.utilities.imaging.Reflection;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ReflectionItem extends AbstractGalleryItem 
	{


		private var bmp:Bitmap;
		private var ratios:Array;
		private var reflectionHeight:Number;
		private var reflection:Sprite;
		private var originWidth:Number;
		private var originHeight:Number;
		
		private var _reflectionAlpha:Number;


		public function ReflectionItem( type:String, bmp:Bitmap, ratios:Array, reflectionHeight:Number, debug:Boolean  )
		{
			super( type, debug );
			
			this.bmp = bmp;
			this.ratios = ratios;
			this.reflectionHeight = reflectionHeight;
			
			_reflectionAlpha = 0;
			originWidth = bmp.width;
			originHeight = bmp.height;
			reflection = new Reflection( bmp, ratios, reflectionHeight );
			addChild( reflection );			
		}
		
		override public function update( dob:IGalleryItem ):void
		{
			var bmp:BitmapData = new BitmapData( originWidth, originHeight, true, 0x000000FF );
			bmp.draw( dob as Sprite );			
			removeChild( reflection );	
			reflection = new Reflection( new Bitmap( bmp ), ratios, reflectionHeight );		
			addChild( reflection );	
			bmp = null;
		}
		
		override public function load( url:String, livedate:Date, linkage:String = "", thumbWidth:int = 80, thumbHeight:int = 80 ):void
		{
		}
		
		override public function set state( value:String ):void
		{
		}			
			
		public function get reflectionAlpha():Number
		{
			return _reflectionAlpha;
		}
		
		public function set reflectionAlpha( value:Number ):void
		{
			_reflectionAlpha = value;
		}
		
	}
}
