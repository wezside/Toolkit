package com.wezside.components.scroll 
{
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollContent extends Sprite 
	{
		private var targetHeight:Number;
		private var maskHeight:Number;

		public function ScrollContent() 
		{
			addEventListener( ScrollEvent.CHANGE, change );
		}

		private function change( event:ScrollEvent ):void 
		{
			
			y = -event.percent * ( targetHeight - maskHeight );
		}
	}
}
