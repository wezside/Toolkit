package com.wezside.components.decorators.scroll 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.shape.ShapeRectangle;

	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollHorizontal extends Scroll
	{
		private var xOffset:Number; 
		private var xMin:int;
		private var xMax:int;

		public function ScrollHorizontal( decorated:IUIDecorator ) 
		{
			super( decorated );
		}
		
		override public function draw():void
		{	
			// Because a Scroll decorator updates the width and height properties
			if ( width == 0 ) width = decorated.width;
			if ( height == 0 ) height = decorated.height;
			
			// Don't draw if height is less than scrollheight
			if ( width > scrollWidth )
			{			
				scrollBarVisible = true;
				
				track = new UIElement();
				track.background = new ShapeRectangle( track );
				track.background.width = scrollWidth;
				track.background.height = trackHeight;
				track.background.alphas = [ 1, 1 ];
				track.background.colours = [ 0xffffff, 0xffffff ];
				track.x = IUIElement( decorated ).layout.left;
				track.y = height + IUIElement( decorated ).layout.bottom + verticalGap;
				track.build();
				track.arrange();
				addChild( track as UIElement );
				
				var thumbWidth:int = int( scrollWidth / width * scrollWidth );
				thumb = new UIElement();
				thumb.background = new ShapeRectangle( thumb );
				thumb.background.alphas = [ 1, 1 ];
				thumb.background.colours = [ 0x666666, 0x666666 ];
				thumb.background.width = thumbWidth > 20 ? thumbWidth : 20;
				thumb.background.height = 16;
				thumb.x = track.x + 2;
				thumb.y = track.y + 2;
				thumb.build();
				thumb.arrange();
				addChild( thumb as UIElement );
				
				width = track.x + track.background.width + IUIElement( decorated ).layout.right;
				height = track.y + track.background.height + IUIElement( decorated ).layout.bottom + verticalGap;
				
				xMin = int( track.x ) + 2;
				xMax = int( track.x + track.width - thumb.width ) - 2;
				thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );			
				if ( stage ) stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );
			}				
			else
				scrollBarVisible = false;
		}
		
		private function thumbUp( event:MouseEvent ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );	
		}

		private function thumbDown( event:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			xOffset = int( mouseX - thumb.x );
		}

		private function thumbMove( event:MouseEvent ):void 
		{
			thumb.x = mouseX - xOffset;
			if ( thumb.x <= xMin ) thumb.x = xMin;
			if ( thumb.x >= xMax ) thumb.x = xMax;
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, 
											int( thumb.x - track.x - 2  ) / int( xMax - track.x - 2 ), 
											scrollWidth,
											"x" ));
			event.updateAfterEvent();
		}		
	}
}
