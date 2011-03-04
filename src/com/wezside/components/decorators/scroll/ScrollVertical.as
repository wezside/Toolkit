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
		private var yMin:int;
		private var yMax:int;
		private var yOffset:int;
		private var _percent:Number = 0;

		public function ScrollVertical( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function draw():void
		{
			// Don't draw if height is less than scrollheight
			if ( int( UIElement( decorated ).bareHeight ) - 4 > scrollHeight )
			{
				if ( !track )
				{
					track = new UIElement();					
					track.background = new ShapeRectangle( track );
					track.background.alphas = [ 1, 1 ];
					track.background.colours = trackColors;
					track.build();
				}

				if ( !thumb )
				{
					thumb = new UIElement();					
					thumb.background = new ShapeRectangle( thumb );
					thumb.background.alphas = [ 1, 1 ];
					thumb.background.colours = thumbColors;
					thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );
					thumb.addEventListener( MouseEvent.MOUSE_OUT, thumbOut );
					thumb.build();				
				}
								
				// Update the x + y position for the track everytime this conditional is met
				resetTrack();
				
				// Update the thumb size and position 
				resetThumb();

				width = track && track.background ? track.background.width + horizontalGap: ( track ? track.width : trackWidth ) + horizontalGap;
				height = track && track.background ? track.background.height : ( track ? track.height : trackHeight );

				yMin = int( track.y ) + trackMinY;				
				yMax = int( track.y + scrollHeight - thumb.height ) - trackMaxY;

				if ( stage && !stage.hasEventListener( MouseEvent.MOUSE_UP ))
					stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );

				scrollBarVisible = true;
			}
			else
			{
				reset();
				scrollBarVisible = false;
			}

			// Update values if resize occurs
			if ( track && thumb )
			{
				if ( thumb.y != int( track.y + ( _percent * int( yMax - track.y ))))
				{
					thumb.y = int( track.y + ( _percent * int( yMax - track.y )));
					if ( thumb.y < yMin ) thumb.y = yMin;
					if ( thumb.y > yMax ) thumb.y = yMax;
					dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, _percent, scrollHeight, "y" ) );
				}
			}
		}

		override public function purge():void
		{
			if ( thumb )
			{
				thumb.removeEventListener( MouseEvent.MOUSE_DOWN, thumbDown );
				thumb.removeEventListener( MouseEvent.MOUSE_OUT, thumbOut );
			}
			if ( stage )
			{
				stage.removeEventListener( MouseEvent.MOUSE_UP, thumbUp );
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			}
			super.purge();
		}

		override public function reset():void
		{
			width = 0;
			resetTrack();
			resetThumb();				
			if ( thumb && contains( thumb as UIElement )) removeChild( thumb as UIElement );
			if ( track && contains( track as UIElement ) ) removeChild( track as UIElement );			
		}

		override public function resetTrack():void
		{
			if ( track.background )
			{
				track.background.width = trackWidth;
				track.background.height = scrollHeight;
			}
			track.x = UIElement( decorated ).bareWidth + 
					  UIElement( decorated ).layout.left + 
					  horizontalGap;						
			track.y = IUIElement( decorated ).layout.top;
			track.arrange();
			addChild( track as UIElement );					
		}

		override public function resetThumb():void
		{
			if ( thumb.background )
			{
				if ( thumbWidth == 0 ) thumb.background.width = thumbWidth = trackWidth - thumbXOffset * 2;
				else thumb.background.width = thumbWidth;
				if ( thumbHeight == 0 ) thumb.background.height = thumbHeight = int( scrollHeight / UIElement( decorated ).bareHeight * scrollHeight );					
				thumb.background.height = thumbHeight > 20 ? thumbHeight : 20;
			}
			UIElement( thumb ).mouseChildren = false;
			thumb.arrange();
			thumb.x = track.x + thumbXOffset;
			thumb.y = track.y + trackMinY;
			addChild( thumb as UIElement );			
		}

		private function thumbOut( event:MouseEvent ):void 
		{
			if ( !stage.hasEventListener( MouseEvent.MOUSE_UP ))
				stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );
		}

		private function thumbUp( event:MouseEvent ):void
		{
			if ( stage )
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );	
		}

		private function thumbDown( event:MouseEvent ):void
		{
			if ( !stage.hasEventListener( MouseEvent.MOUSE_MOVE ))
				stage.addEventListener( MouseEvent.MOUSE_MOVE, thumbMove );

			yOffset = int( mouseY - thumb.y );
		}

		private function thumbMove( event:MouseEvent ):void
		{
			thumb.y = mouseY - yOffset;
			if ( thumb.y < yMin ) thumb.y = yMin;
			if ( thumb.y > yMax ) thumb.y = yMax;
			_percent = int( thumb.y - track.y - trackMinY ) / int( yMax - track.y - trackMaxY );
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, _percent, scrollHeight, "y" ) );
			event.updateAfterEvent();
			
			if ( !event.buttonDown ) thumbUp( null );
		}
	}
}