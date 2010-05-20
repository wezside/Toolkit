/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.utilities.manager.timeline 
{
	import com.wezside.data.collection.LinkedListCollection;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * A simple class to deal with timeline animations. Manage timeline animations playback, removal and 
	 * end frame behaviour. A play policy exist to allow for playing back multiple animations at once or 
	 * in sequence starting at a specific animation or simply play a single (default) animation.
	 */
	public class TimelineManager extends EventDispatcher 
	{

		
		private var _playPolicy:int;
		private var _endFramePolicy:int;
		private var _playIndex:int;
		private var _total:int;
		private var _playID:String;
		private var _autoplay:Boolean = false;
		private var _isPlaying:Boolean = false;
		private var _autoplayDelay:Number;
		
		private var animations:LinkedListCollection;
		private var autoPlayTimer:Timer;

		public static const PLAY_POLICY_SEQUENTIAL:int = 0; 
		public static const PLAY_POLICY_CONCURRENTLY:int = 1;
		 
		public static const ENDFRAME_POLICY_STOP:int = 2; 
		public static const ENDFRAME_POLICY_LOOP:int = 3; 

		public static const CHILD_POLICY_ROOT:int = 4; 
		public static const CHILD_POLICY_RECURSIVE:int = 5;
		private var timelineInstance:TimelineInstance;

		
		public function TimelineManager( target:IEventDispatcher = null )
		{
			super( target );
			_total = 0;
			_playIndex = 0;
			_isPlaying = false;
			_playPolicy = PLAY_POLICY_SEQUENTIAL;
			_endFramePolicy = ENDFRAME_POLICY_STOP;
			animations = new LinkedListCollection();
		}

		
		public function push( id:String, target:MovieClip, delay:int = 0, childPolicy:int = CHILD_POLICY_ROOT ):void
		{
			var tmi:TimelineInstance = new TimelineInstance();
			tmi.id = id;
			tmi.index = _total;
			tmi.target = target;
			tmi.delay = delay;
			tmi.childPolicy = childPolicy;
			animations.addElement( tmi );
			target.gotoAndStop( 1 );
			
			++_total;
			if ( childPolicy == CHILD_POLICY_RECURSIVE )
				setChildrenProp( target, "gotoAndStop", 1 );
		}
		
		public function play( id:String = "" ):void
		{
			switch ( _playPolicy )
			{
				case 0:	
				case 1:	initSequential( id ); break;
				case 2:	initConcurrent(); break;
				default: break;
			}
		}
		
		public function playAuto( id:String = "" ):void
		{
			_autoplay = true;
			_playID = TimelineInstance( animations.find( id )).id;
			var autoPlayTimer:Timer = new Timer( TimelineInstance( animations.find( id )).delay * 1000, 1 );
			autoPlayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, playAutoHandler );
			autoPlayTimer.start();
		}


		public function stop( id:String ):void
		{
			TimelineInstance( animations.find( id ) ).target.stop();		
		}

		public function purgeAnimation( id:String ):void
		{
			if ( autoPlayTimer )
			{
				autoPlayTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
				autoPlayTimer.stop();
				autoPlayTimer = null; 
			}
			
			if ( TimelineInstance( animations.find( id ) ).target.hasEventListener( Event.ENTER_FRAME ))
				TimelineInstance( animations.find( id ) ).target.removeEventListener( Event.ENTER_FRAME, enterFrame );

			// animations.removeElement( id );

			TimelineInstance( animations.find( id )).purge();
			
			--_total;
			if ( _playIndex > _total ) _playIndex = _total;
		}
		
		public function purgeAll():void
		{
			for each ( var animation:Object in animations )
			{
				if ( MovieClip( animation.instance ).hasEventListener( Event.ENTER_FRAME ))
					MovieClip( animation.instance ).removeEventListener( Event.ENTER_FRAME, enterFrame );
				animations.purge();
			}
			_total = 0;
			_playIndex = 0;
			_autoplay = false;
		}
		
		public function hasAnimation( id:String ):Boolean
		{
			return animations.find( id ) ? true : false;		
		}
		
		public function get playPolicy():int
		{
			return _playPolicy;
		}
		
		public function set playPolicy( value:int ):void
		{
			_playPolicy = value;
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		public function set isPlaying( value:Boolean ):void
		{
			_isPlaying = value;
		}
		
		public function get playIndex():int
		{
			return _playIndex;
		}
		
		public function set playIndex( value:int ):void
		{
			_playIndex = value;
		}
		
		public function get playID():String
		{
			return _playID;
		}
		
		public function set playID( value:String ):void
		{
			_playID = value;
		}
		
		public function get total():int
		{
			return _total;
		}
		
		public function set total( value:int ):void
		{
			_total = value;
		}
		
		public function get autoplay():Boolean
		{
			return _autoplay;
		}
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
		
		private function playAutoHandler( event:TimerEvent ):void 
		{
			play( _playID );
		}		
		
		private function initConcurrent():void 
		{
		}

		private function initSequential( id:String ):void 
		{
			var delay:int = 0;
			delay = TimelineInstance( animations.find( id )).delay;
			_playID = TimelineInstance( animations.find( id )).id;
			_playIndex = TimelineInstance( animations.find( id )).index;
			timelineInstance = TimelineInstance( animations.find( _playID ));	

			var itemDelay:Timer = new Timer( delay * 1000, 1 );
			itemDelay.addEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
			itemDelay.start();
		}

		private function timerComplete( event:TimerEvent = null ):void 
		{
			event.currentTarget.removeEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
			_isPlaying = true;
			timelineInstance.target.addEventListener( Event.ENTER_FRAME, enterFrame );
			timelineInstance.target.play();
			setChildrenProp( timelineInstance.target, "gotoAndPlay", 1 );
		}

		private function enterFrame( event:Event ):void 
		{
			if ( event.currentTarget.currentFrame == event.currentTarget.totalFrames && _endFramePolicy == ENDFRAME_POLICY_STOP )
			{
				event.currentTarget.removeEventListener( Event.ENTER_FRAME, enterFrame );
				event.currentTarget.gotoAndStop( 1 );
				
				if ( timelineInstance.childPolicy == CHILD_POLICY_RECURSIVE )
					setChildrenProp( MovieClip( event.currentTarget ), "gotoAndStop", 1 );
				
				_isPlaying = false;
				++_playIndex;
				
				if ( _playPolicy == PLAY_POLICY_SEQUENTIAL )
				{
					if ( _playIndex == _total )
					{
						dispatchEvent( new TimelineEvent( TimelineEvent.SEQUENTIAL_COMPLETE, false, false, _playID, _playIndex ));
					}
					else if ( _playIndex < _total )
					{
						dispatchEvent( new TimelineEvent( TimelineEvent.COMPLETE, false, false, _playID, _playIndex ));
	
						if ( autoplay ) playAuto(  TimelineInstance( animations.iterator().next().data ).id );
						else initSequential( TimelineInstance( animations.iterator().next().data ).id );
					}			
				}		
			}
		}
		
		private function setChildrenProp( target:MovieClip, prop:String, value:*,  indentString:String = "" ):void
		{
		    var child:DisplayObject;
		    for ( var i:uint=0; i < target.numChildren; i++ )
		    {
		        child = target.getChildAt(i);
		        if ( child is MovieClip )
		        {
		        	MovieClip( child )[ prop ]( value );
		            setChildrenProp( MovieClip( child ), prop, indentString + "    ");
		        }		
		    }
		}
	}
}
