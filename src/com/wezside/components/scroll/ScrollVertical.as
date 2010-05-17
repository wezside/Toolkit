package com.wezside.components.scroll 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElement;
	import com.wezside.components.shape.Rectangle;

	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollVertical extends Scroll
	{
		private var yOffset:Number; 
		private var yMin:int;
		private var yMax:int;

		public function ScrollVertical( decorated:IUIDecorator ) 
		{
			super( decorated );
		}
		
		override public function draw():void
		{	
			// Because a Scroll decorator updates the width and height properties
			if ( width == 0 ) width = decorated.width;
			if ( height == 0 ) height = decorated.height;
			
			track = new UIElement();
			track.background = new Rectangle( track );
			track.background.width = trackWidth;
			track.background.height = scrollHeight;
			track.background.alphas = [ 1, 1 ];
			track.background.colours = [ 0xffffff, 0xffffff ];
			track.x = width + IUIElement( decorated ).layout.left + horizontalGap;
			track.y = IUIElement( decorated ).layout.top;
			track.build();
			track.arrange();
			addChild( track as UIElement );
			
			var thumbHeight:int = int( scrollHeight / height * scrollHeight );
			thumb = new UIElement();
			thumb.background = new Rectangle( thumb );
			thumb.background.alphas = [ 1, 1 ];
			thumb.background.colours = [ 0x666666, 0x666666 ];
			thumb.background.width = 16;
			thumb.background.height = thumbHeight > 20 ? thumbHeight : 20;
			thumb.x = track.x + 2;
			thumb.y = track.y + 2;
			thumb.build();
			thumb.arrange();
			addChild( thumb as UIElement );
			
			width = track.background.width + horizontalGap;
			height = track.y + track.background.height + IUIElement( decorated ).layout.bottom;

			yMin = int( track.y ) + 2;
			yMax = int( track.y + track.height - thumb.height ) - 2;
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
			yOffset = int( mouseY - thumb.y );
		}

		private function thumbMove( event:MouseEvent ):void 
		{
			thumb.y = mouseY - yOffset;
			if ( thumb.y <= yMin ) thumb.y = yMin;
			if ( thumb.y >= yMax ) thumb.y = yMax;

			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, 
											int( thumb.y - track.y - 2  ) / int( yMax - track.y - 2 ), scrollHeight ));
			event.updateAfterEvent();
		}		
	}
}
