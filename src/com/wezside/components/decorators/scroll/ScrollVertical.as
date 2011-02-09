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
			// Don't draw if height is less than scrollheight
			if ( decorated.height > scrollHeight )
			{			
				scrollBarVisible = true;				
				if ( !track )
				{
					track = new UIElement();				
					addChild( track as UIElement );
				}
				track.background = new ShapeRectangle( track );
				track.background.width = trackWidth;
				track.background.height = scrollHeight;
				track.background.alphas = [ 1, 1 ];
				track.background.colours = trackColors;
				track.x = decorated.width + horizontalGap + ( width == 0 ? UIElement( decorated ).layout.left : 0 );
				track.y = IUIElement( decorated ).layout.top;
				track.build();
				track.arrange();
				
				var thumbHeight:int = int( scrollHeight / decorated.height * scrollHeight );
				if ( !thumb )
				{
					thumb = new UIElement();
					addChild( thumb as UIElement );
				}
				
				thumb.background = new ShapeRectangle( thumb );
				thumb.background.alphas = [ 1, 1 ];
				thumb.background.colours = thumbColors;
				thumb.background.width = thumbWidth;
				thumb.background.height = thumbHeight > 20 ? thumbHeight : 20;
				thumb.x = track.x + thumbXOffset;
				thumb.y = track.y + thumbXOffset;
				thumb.build();
				thumb.arrange();
				
				width = track.background.width;
				height = track.background.height;
	
				yMin = int( track.y ) + trackMinY;
				yMax = int( track.y + track.height - thumb.height ) - trackMaxY;
				thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );			
				thumb.addEventListener( MouseEvent.MOUSE_OUT, thumbOut );			
				if ( stage ) stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );		
			}		
			else
			{
				scrollBarVisible = false;
				width = 0;
				if ( track ) height = track.background.height;
				else height = UIElement( decorated ).height;
				if ( thumb && contains( thumb as UIElement )) removeChild( thumb as UIElement );
				if ( track && contains( track as UIElement ) ) removeChild( track as UIElement );
			}
		}

		override public function purge():void 
		{
			if ( stage )
			{
				stage.removeEventListener( MouseEvent.MOUSE_UP, thumbUp );
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			}
			if ( thumb ) thumb.removeEventListener( MouseEvent.MOUSE_DOWN, thumbDown );	
		}


		private function thumbOut( event:MouseEvent ):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );
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
											int( thumb.y - track.y - trackMinY  ) / int( yMax - track.y - trackMaxY ), 
											scrollHeight,
											"y" ));
			event.updateAfterEvent();
		}		
	}
}
