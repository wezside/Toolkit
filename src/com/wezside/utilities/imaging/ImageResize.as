package com.wezside.utilities.imaging 
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import flash.display.Bitmap;

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
			displayObject[prop] = ( prop == "x" ? value - displayObject.width : value - displayObject.height ) * 0.5;
		}
	}
}
