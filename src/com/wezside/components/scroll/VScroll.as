package com.wezside.components.scroll 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.shape.Rectangle;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VScroll extends Scroll
	{

		public function VScroll( decorated:IUIDecorator ) 
		{
			super( decorated );
		}
		
		override public function draw():void
		{
			
			if ( width == 0 ) width = decorated.width;
			if ( height == 0 ) height = decorated.height;

			var scrollMask:Sprite = new Sprite();
			scrollMask.graphics.beginFill( 0xefefef );
			scrollMask.graphics.drawRect( 0, 0, decorated.width, scrollHeight );
			scrollMask.graphics.endFill();
			addChild( scrollMask );
//			DisplayObject( decorated ).mask = scrollMask; 

			var track:UIElement = new UIElement();
			track.background = new Rectangle( track );
			track.background.width = 20;
			track.background.height = 100;
			track.background.alphas = [ 1, 1 ];
			track.background.colours = [ 0xffffff, 0xffffff ];
			track.x = decorated.width + horizontalGap;
			track.update();
			addChild( track );
			
			var thumb:UIElement = new UIElement();
			thumb.background = new Rectangle( thumb );
			thumb.background.alphas = [1,1];
			thumb.background.colours = [ 0xcccccc, 0xcccccc ];
			thumb.background.width = 16;
			thumb.background.height = 20;
			thumb.x = track.x + 2;
			thumb.y = 2;
			thumb.update();
			addChild( thumb );
						
			width = track.background.width;
			height = track.background.height;
		}
	}
}
