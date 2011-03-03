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
		private var xMin:int;
		private var xMax:int;
		private var xOffset:int;
		private var _percent:Number = 0;

		public function ScrollHorizontal( decorated:IUIDecorator )
		{
			super( decorated );
		}
		
		public function reset():void
		{
			height = 0;
			if ( track )
			{
				track.x = IUIElement( decorated ).layout.left;
				track.y = IUIElement( decorated ).layout.top;
				width = track.background.width;
			}
			else width = UIElement( decorated ).width;
				
			if ( thumb )
			{
				thumb.x = IUIElement( decorated ).layout.left;
				thumb.y = IUIElement( decorated ).layout.top;
			}
				
			if ( thumb && contains( thumb as UIElement )) removeChild( thumb as UIElement );
			if ( track && contains( track as UIElement ) ) removeChild( track as UIElement );			
		}		

		override public function draw():void
		{
			// Don't draw if width is less than scrollWidth
			var w:int = int( UIElement( decorated ).bareWidth );
	
			if ( w - 4 > scrollWidth )
			{
				if ( !track )
				{
					track = new UIElement();				
					addChild( track as UIElement );
					track.background = new ShapeRectangle( track );
					track.background.width = scrollWidth;
					track.background.height = trackHeight;
					track.background.alphas = [ 1, 1 ];
					track.background.colours = trackColors;

					track.build();
					track.arrange();					
				}

				if ( !thumb )
				{
					thumb = new UIElement();
					addChild( thumb as UIElement );
					thumb.background = new ShapeRectangle( thumb );
					thumb.background.alphas = [ 1, 1 ];
					thumb.background.colours = thumbColors;
					
					if ( thumbWidth == 0 ) thumb.background.width = thumbWidth = int( scrollWidth / w * scrollWidth );
					if ( thumbHeight == 0 ) thumb.background.height = thumbHeight = trackHeight - thumbYOffset * 2;
					thumb.background.width = thumbWidth > 20 ? thumbWidth : 20;					
					
					UIElement( thumb ).mouseChildren = false;
					thumb.addEventListener( MouseEvent.MOUSE_DOWN, thumbDown );
					thumb.addEventListener( MouseEvent.MOUSE_OUT, thumbOut );
					
					thumb.build();
					thumb.arrange();					
				}
				
				track.x = UIElement( decorated ).layout.left;
				track.y = UIElement( decorated ).bareHeight + 
						  UIElement( decorated ).layout.top + 
						  verticalGap;
						
				thumb.x = track.x + trackMinX;
				thumb.y = track.y + thumbYOffset;
				
				width = track.background.width;
				height = track && track.background ? track.background.height + verticalGap : ( track ? track.height : trackHeight ) + verticalGap;

				xMin = int( track.x ) + trackMinX;				
				xMax = int( track.x + scrollWidth - thumb.width ) - trackMaxX;				

				if ( stage && !stage.hasEventListener( MouseEvent.MOUSE_UP ) )
					stage.addEventListener( MouseEvent.MOUSE_UP, thumbUp );

				scrollBarVisible = true;
			}
			else
			{
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
					dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, _percent, scrollWidth, "x" ));
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