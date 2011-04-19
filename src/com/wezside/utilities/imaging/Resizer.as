/*
	The MIT License

	Copyright (c) 2011 Wesley Swanepoel
	
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
	public class Resizer 
	{

		
		private var targetWidth:int;
		private var targetHeight:int;
		private var ratio:Number;
		private var _originalWidth:int = 0;
		private var _originalHeight:int = 0;
		
		public static const DISTRIBUTE_TO_WIDTH:String = "DISTRIBUTE_TO_WIDTH";
		public static const DISTRIBUTE_TO_HEIGHT:String = "DISTRIBUTE_TO_HEIGHT";

		
		public function resizeToHeight( displayObject:DisplayObject, h:int ):DisplayObject
		{
			if ( originalWidth == 0 ) originalWidth = displayObject.width;
			if ( originalHeight == 0 ) originalHeight = displayObject.height;

			targetWidth = originalWidth;
			targetHeight = h;		
		
			// Determine Landscape or portrait
			if ( targetWidth < targetHeight )
			{
				// Portrait
				ratio = originalHeight / originalWidth;
				targetWidth = targetHeight / ratio;
				displayObject.width = targetWidth;
				displayObject.height = targetHeight;				
			}
			else
			{
				// Landscape			
				ratio = originalWidth / originalHeight;
				targetWidth = targetHeight * ratio;
				displayObject.width = targetWidth;
				displayObject.height = targetHeight;
			}			
			return displayObject;
		}

		public function resizeToWidth( displayObject:DisplayObject, w:int ):DisplayObject
		{
			if ( originalWidth == 0 ) originalWidth = displayObject.width;
			if ( originalHeight == 0 ) originalHeight = displayObject.height;		
			
			targetWidth = w;
			targetHeight = originalHeight;

			// Determine Landscape or portrait
			if ( targetWidth < targetHeight )
			{
				// Portrait
				ratio = originalHeight / originalWidth;
				targetHeight = targetWidth * ratio;
				displayObject.width = targetWidth;
				displayObject.height = targetHeight;				
			}
			else
			{
				// Landscape			
				ratio = originalWidth / originalHeight;
				targetHeight = targetWidth / ratio;
				displayObject.width = targetWidth;
				displayObject.height = targetHeight;
			}
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

		public function get originalWidth():int
		{
			return _originalWidth;
		}
		
		public function set originalWidth( value:int ):void
		{
			_originalWidth = value;
		}
		
		public function get originalHeight():int
		{
			return _originalHeight;
		}
		
		public function set originalHeight( value:int ):void
		{
			_originalHeight = value;
		}

		private function position( displayObject:DisplayObject, prop:String, value:Number ):void
		{
			displayObject[prop] = ( prop == "x" ? value - displayObject.width : value - displayObject.height ) * 0.5;
		}
	}
}
