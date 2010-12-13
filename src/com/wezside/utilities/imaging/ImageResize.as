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
package com.wezside.utilities.imaging 
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ImageResize 
	{

		
		private var targetWidth:int;
		private var targetHeight:int;
		private var originalWidth:Number;
		private var originalHeight:Number;
		private var ratio:Number;
		
		public static const DISTRIBUTE_TO_WIDTH:String = "DISTRIBUTE_TO_WIDTH";
		public static const DISTRIBUTE_TO_HEIGHT:String = "DISTRIBUTE_TO_HEIGHT";

		
		public function resizeToHeight( dislpayObject:DisplayObject, h:int ):DisplayObject
		{
			originalWidth = dislpayObject.width;
			originalHeight = dislpayObject.height;

			targetWidth = originalWidth;
			targetHeight = h;		
		
			// Determine Landscape or portrait
			if ( targetWidth < targetHeight )
			{
				// Portrait
				ratio = originalHeight / originalWidth;
				targetWidth = targetHeight / ratio;
				targetHeight = originalWidth * ratio;
				dislpayObject.width = targetWidth;
				dislpayObject.height = targetHeight;				
			}
			else
			{
				// Landscape			
				ratio = originalWidth / originalHeight;
				targetWidth = targetHeight * ratio;
				dislpayObject.width = targetWidth;
				dislpayObject.height = targetHeight;
			}
			
			return dislpayObject;
		}

		public function resizeToWidth( displayObject:DisplayObject, w:int ):DisplayObject
		{
			return displayObject;
		}

		public function distribute( displayObject:DisplayObject, value:Number, policy:String = DISTRIBUTE_TO_WIDTH ):DisplayObject
		{
			if ( policy == DISTRIBUTE_TO_WIDTH ) position( displayObject, "x", value );
			if ( policy == DISTRIBUTE_TO_HEIGHT ) position( displayObject, "y", value );
			return displayObject;
		}

		public function toString():String 
		{
			return getQualifiedClassName( this );
		}

		private function position( displayObject:DisplayObject, prop:String, value:Number ):void
		{
			trace( value, displayObject.width );
			displayObject[prop] = ( prop == "x" ? value - displayObject.width : value - displayObject.height ) * 0.5;
		}
	}
}
