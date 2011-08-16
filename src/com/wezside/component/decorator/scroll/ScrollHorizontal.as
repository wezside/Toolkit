package com.wezside.component.decorator.scroll
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.UIElement;
	import com.wezside.component.decorator.shape.ShapeRectangle;
	import flash.events.MouseEvent;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollHorizontal extends Scroll
	{
		private var xMin:int;
		private var xMax:int;
		private var xOffset:int;
		private var _percent:Number = 0;

		public function ScrollHorizontal( decorated:IUIDecorator )
		{
			super( decorated );
		}
		
		override public function draw():void
		{
			// Don't draw if width is less than scrollWidth
			if ( int( UIElement( decorated ).bareWidth ) - 4 > scrollWidth )
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
					thumb.build();		
				}
				
				// Update the x + y position for the track everytime this conditional is met
				resetTrack();
				
				// Update the thumb size and position 
				resetThumb();	
							
				width = track && track.background ? track.background.width : ( track ? track.width : trackWidth );
				height = track && track.background ? track.background.height + verticalGap : ( track ? track.height : trackHeight ) + verticalGap;

				xMin = int( track.x ) + trackMinX;				
				xMax = int( track.x + scrollWidth - thumb.width ) - trackMaxX;				

				if ( stage && !stage.hasEventListener( MouseEvent.MOUSE_UP ) )
					stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );

				scrollBarVisible = true;
			}
			else
			{
				height = 0;
				if ( thumb && contains( thumb as UIElement )) removeChild( thumb as UIElement );
				if ( track && contains( track as UIElement ) ) removeChild( track as UIElement );					
				reset();
				scrollBarVisible = false;
			}

			if ( track && thumb )
			{
				if ( thumb.x != int( track.x + ( _percent * int( xMax - track.x ))))
				{
					// reset the child containers y position
					thumb.x = int( track.x + ( _percent * int( xMax - track.x )));
					if ( thumb.x < xMin ) thumb.x = xMin;
					if ( thumb.x > xMax ) thumb.x = xMax;
					dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, scrollBarVisible ? _percent : 0, scrollWidth, "x" ));
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
			resetTrack();
			resetThumb();	
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, 0, scrollWidth, "x" ));
		}

		override public function resetTrack():void
		{
			if ( !track ) return;
			if ( track.background )
			{
				track.background.width = scrollWidth;
				track.background.height = trackHeight;
			}			
			track.x = UIElement( decorated ).layout.left;
			track.y = UIElement( decorated ).bareHeight + 
					  UIElement( decorated ).layout.top + 
					  verticalGap;
			track.arrange();
			addChild( track as UIElement );					
		}

		override public function resetThumb():void
		{
			if ( !thumb ) return;
			if ( thumb.background )
			{
				if ( thumbWidth == 0 ) thumb.background.width = thumbWidth = int( scrollWidth / UIElement( decorated ).bareWidth * scrollWidth );
				else thumb.background.width = thumbWidth;
				if ( thumbHeight == 0 ) thumb.background.height = thumbHeight = trackHeight - thumbYOffset * 2;
				thumb.background.width = thumbWidth > 20 ? thumbWidth : 20;
			}					
			if ( !thumb.hasEventListener( MouseEvent.MOUSE_DOWN ))
				thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );
				
			if ( !thumb.hasEventListener( MouseEvent.MOUSE_OUT ))
				thumb.addEventListener( MouseEvent.MOUSE_OUT, thumbOut );
				
			UIElement( thumb ).mouseChildren = false;
			thumb.arrange();					
			thumb.x = track.x + trackMinX;
			thumb.y = track.y + thumbYOffset;
			addChild( thumb as UIElement );			
		}

		override public function to( value:Number ):void
		{
			if ( value < 0 ) return;
			if ( value > 1 ) return;
			_percent = value;
			thumb.x = track.width * value - thumb.width * 0.5;
			if ( thumb.x < xMin ) thumb.x = xMin;
			if ( thumb.x > xMax ) thumb.x = xMax;
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, percent, scrollWidth, "x" ));
		}

		public function get percent():Number 
		{
			return _percent;
		}			

		private function thumbOut( event:MouseEvent ):void
		{
			if ( !stage.hasEventListener( MouseEvent.MOUSE_UP ))
				stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );
		}

		private function thumbUp( event:MouseEvent ):void
		{
			if ( stage ) stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
		}

		private function thumbDown( event:MouseEvent ):void
		{
			if ( !stage.hasEventListener( MouseEvent.MOUSE_MOVE ))
				stage.addEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			xOffset = int( mouseX - thumb.x );
		}

		private function thumbMove( event:MouseEvent ):void
		{
			thumb.x = mouseX - xOffset;
			if ( thumb.x < xMin ) thumb.x = xMin;
			if ( thumb.x > xMax ) thumb.x = xMax;
			_percent = int( thumb.x - track.x ) / int( xMax - track.x );
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, _percent, scrollWidth, "x" ));
			event.updateAfterEvent();
		}
	}
}