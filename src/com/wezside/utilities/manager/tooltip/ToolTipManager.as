/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.utilities.manager.tooltip 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * TODO: Remove dependancy on Tweenlite.
	 * TODO: Should be more like timeline manager, pushing tooltips in, thus an interface to play and control tooltips with.
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
			{
				tooltip.visible = false;
				tooltip.scaleX = tooltip.scaleY = 0;
				tooltip.y = tooltip.x - 3;
				tooltip.y = tooltip.y - 45;
			}
											  
			if ( tooltip.currentState == STATE_ANCHOR_RIGHT )
			{
				tooltip.visible = false;
				tooltip.scaleX = tooltip.scaleY = 0;
				tooltip.x = tooltip.x - 233;
				tooltip.y = tooltip.x - 40;				
			}					
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
