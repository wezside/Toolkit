package com.wezside.components.scroll 
{
	import com.wezside.components.IUIElement;
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.shape.Rectangle;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VScroll extends Scroll
	{
		private var yOffset:Number;
		private var yMin:int;
		private var yMax:*;

		public function VScroll( decorated:IUIDecorator ) 
		{
			super( decorated );
		}
		
		override public function draw():void
		{			
			if ( width == 0 ) width = decorated.width;
			if ( height == 0 ) height = decorated.height;

			
			track = new UIElement();
			track.background = new Rectangle( UIElement( track ));
			track.background.width = 20;
			track.background.height = scrollHeight - IUIElement( decorated ).layout.bottom;
			track.background.alphas = [ 1, 1 ];
			track.background.colours = [ 0xffffff, 0xffffff ];
			track.x = width + horizontalGap - track.width - IUIElement( decorated ).layout.left;
//			track.y = IUIElement( decorated ).layout.top;
			track.update();
			addChild( track as UIElement );
			
			thumb = new UIElement();
			thumb.background = new Rectangle( UIElement( thumb ));
			thumb.background.alphas = [1,1];
			thumb.background.colours = [ 0xcccccc, 0xcccccc ];
			thumb.background.width = 16;
			thumb.background.height = 20;
			thumb.x = track.x + 2;
			thumb.y = track.y;
			thumb.update();
			addChild( thumb as UIElement );
						
			width = track.background.width;
			height = track.background.height;
			
			yMin = track.y;
			yMax = int( track.y  + track.background.height - thumb.background.height );
			thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );			
			if ( stage ) stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );				

		}
		
		private function thumbUp( event:MouseEvent ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );	
		}

		private function thumbDown( event:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			yOffset = mouseY - thumb.y;
		}

		private function thumbMove( event:MouseEvent ):void 
		{
			thumb.y = mouseY - yOffset;
			if ( thumb.y <= yMin ) thumb.y = yMin;
			if ( thumb.y >= yMax ) thumb.y = yMax;

			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, thumb.y / yMax, scrollHeight ));
			event.updateAfterEvent();
		}		
	}
}