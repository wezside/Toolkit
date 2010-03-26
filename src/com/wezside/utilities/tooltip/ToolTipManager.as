package com.wezside.utilities.tooltip 
{
	import gs.TweenLite;

	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ToolTipManager extends EventDispatcher
	{
		
		public static const STATE_ANCHOR_LEFT:String = "STATE_ANCHOR_LEFT";
		public static const STATE_ANCHOR_RIGHT:String = "STATE_ANCHOR_RIGHT";
		
		private var _tooltip:IToolTip;
		private var hideTimer:Timer;
		private var autoPlayTimer:Timer;
		private var _delay:Number;
		private var _data:IToolTipData;

		
		public function ToolTipManager( delay:Number ) 
		{
			
			_delay = delay;
			
			// A timer to manage the hide of the tooltip - this is to fix the rollove
			// problem due to the size of the rollover hotspot (very small). By adding a delay before the hide
			// method is called, time is left in the event the user rolls over the tooltip again.
			hideTimer = new Timer( 200, 1 );
			hideTimer.addEventListener( TimerEvent.TIMER_COMPLETE, hideTooltip );
			
			// A timer to manage the autoplay of showing tooltips when the module starts
			// or when there is user inactivity
			autoPlayTimer = new Timer( _delay * 1000, 1 );
			autoPlayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, autoShowHideTooltip );	
		}
		
		public function startHide():void
		{
			hideTimer.start();
		}
		
		public function startAutoplay():void
		{
			autoPlayTimer.start( );
		}

		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay( value:Number ):void
		{
			_delay = value;
		}		
				
		public function get tooltip():IToolTip
		{
			return _tooltip;
		}
		
		public function set tooltip( value:IToolTip ):void
		{
			_tooltip = value;
		}
		
		public function get data():IToolTipData
		{
			return _data;
		}
		
		public function set data( value:IToolTipData ):void
		{
			_data = value;
		}
		
		public function hideTooltip( event:TimerEvent = null ):void 
		{
			if ( tooltip.currentState == STATE_ANCHOR_LEFT )
				TweenLite.to( tooltip, 0.5, { autoAlpha: 0, scaleX: 0, scaleY: 0, 
										      x: tooltip.x - 3, 
											  y: tooltip.y + 45 });			
											  
			if ( tooltip.currentState == STATE_ANCHOR_RIGHT )
				TweenLite.to( tooltip, 0.5, { autoAlpha: 0, scaleX: 0, scaleY: 0, 
										      x: tooltip.x + 233, 
											  y: tooltip.y + 40 });			
		}		
				
		public function resetHide():void
		{
			hideTimer.reset();
		}
				
		public function stopHide():void
		{
			hideTimer.stop();
		}
				
		public function resetAutoPlay():void
		{
			autoPlayTimer.reset();
		}
				
		public function stopAutoPlay():void
		{
			autoPlayTimer.stop();
		}
		
		public function purge():void
		{
			autoPlayTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, autoShowHideTooltip );
			hideTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, hideTooltip );
			tooltip = null;
			autoPlayTimer = null;
			hideTimer = null;
		} 

		private function autoShowHideTooltip( event:TimerEvent ):void 
		{
			if ( _tooltip.visible )
			{
				dispatchEvent( new ToolTipEvent( ToolTipEvent.HIDE ));
			}
			else
			{
				dispatchEvent( new ToolTipEvent( ToolTipEvent.SHOW ));
			}
		}		
	}
}
