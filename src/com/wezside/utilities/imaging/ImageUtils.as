package com.wezside.utilities.imaging 
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import flash.display.Bitmap;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ImageUtils 
	{

		
		private var targetWidth:int;
		private var targetHeight:int;
		private var originalWidth:Number;
		private var originalHeight:Number;
		private var ratio:Number;
		private var dislpayObject:DisplayObject;

		
		public function resizeToHeight( dislpayObject:DisplayObject, h:int ):DisplayObject
		{
			this.dislpayObject = dislpayObject;
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

		public function resizeToWidth( bitmap:Bitmap, h:int ):Bitmap
		{
			var bmp:Bitmap = bitmap;
			return bmp;
		}

		public function reflection():void
		{
		}

		public function toString():String 
		{
			return getQualifiedClassName( this );
		}
	}
}
