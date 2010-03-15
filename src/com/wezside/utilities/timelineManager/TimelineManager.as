package com.wezside.utilities.timelineManager 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * A simple class to deal with timeline animations. Manage timeline animations playback, removal and 
	 * end frame behaviour. A play policy exist to allow for playing back multiple animations at once or 
	 * in sequence starting at a specific animation or simply play a single (default) animation.
	 * 
	 * TODO: Add interrupt policy for interrupting playing animations in different ways - need to use binary options for this.
	 * TODO: Add concurrent playback
	 */
	public class TimelineManager extends EventDispatcher 
	{

		
		private var _playPolicy:int;
		private var _endFramePolicy:int;
		private var _playIndex:int;
		private var _total:int;
		private var _playID:String;
		private var _interruptPolicy:int;
		
		private var _autoplay:Boolean = false;
		private var _isPlaying:Boolean = false;
		private var _autoplayDelay:Number;
		
		private var animations:Dictionary;
		private var autoPlayTimer:Timer;


		public static const PLAY_POLICY_SINGLE:int = 0; 
		public static const PLAY_POLICY_SEQUENTIAL:int = 1; 
		public static const PLAY_POLICY_CONCURRENTLY:int = 2;
		 
		public static const ENDFRAME_POLICY_STOP:int = 3; 
		public static const ENDFRAME_POLICY_LOOP:int = 4; 

		public static const CHILD_POLICY_ROOT:int = 5; 
		public static const CHILD_POLICY_RECURSIVE:int = 6;

		public static const INTERRUPT_POLICY_OVERWRITE:int = 7; 
		public static const INTERRUPT_POLICY_SINGLE_COMPLETE:int = 8;
		public static const INTERRUPT_POLICY_SEQUENCE_COMPLETE:int = 9;

		
		public function TimelineManager(target:IEventDispatcher = null)
		{
			super( target );
			_total = 0;
			_playIndex = 0;
			_endFramePolicy = ENDFRAME_POLICY_STOP;
			_isPlaying = false;
			_playPolicy = PLAY_POLICY_SINGLE;
			_interruptPolicy = INTERRUPT_POLICY_OVERWRITE;
			animations = new Dictionary();
		}
		

		public function push( id:String, target:MovieClip, delay:int = 0, childPolicy:int = CHILD_POLICY_ROOT ):void
		{
			animations[id] = { instance: target, index: _total, id: id, childPolicy: childPolicy, delay: delay };
			target.gotoAndStop( 1 );
			
			if ( childPolicy == CHILD_POLICY_RECURSIVE )
				setChildrenProp( target, "gotoAndStop" );
			_total++;
		}
		
		public function getAnimation( id:String ):Object
		{
			return animations[id];
		}
		
		public function play( id:String = "" ):void
		{
			switch ( _playPolicy )
			{
				case 0:	initSequential( id ); break;
				case 1:	initSequential( id ); break;
				case 2:	initConcurrent(); break;
				default: break;
			}
		}
		
		public function playAuto( delay:int = 1 ):void
		{
			_autoplay = true;
			_playIndex = 0;
			_autoplayDelay = delay * 1000;
			var autoPlayTimer:Timer = new Timer( delay * 1000, 1 );
			autoPlayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, playAutoHandler );
			autoPlayTimer.start();
		}

		private function playAutoHandler( event:TimerEvent ):void 
		{
			play();
		}

		public function stop( id:String ):void
		{
			MovieClip( animations[id].instance ).stop();		
		}

		public function purgeAnimation( id:String ):void
		{
			if ( autoPlayTimer )
			{
				autoPlayTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
				autoPlayTimer.stop();
				autoPlayTimer = null; 
			}
			
			if ( MovieClip( animations[id].instance ).hasEventListener( Event.ENTER_FRAME ))
				MovieClip( animations[id].instance ).removeEventListener( Event.ENTER_FRAME, enterFrame );
			delete animations[id];
			--_total;
			if ( _playIndex > _total ) _playIndex = _total;
		}
		
		public function purgeAll():void
		{
			for each ( var animation:Object in animations )
			{
				if ( MovieClip( animation.instance ).hasEventListener( Event.ENTER_FRAME ))
					MovieClip( animation.instance ).removeEventListener( Event.ENTER_FRAME, enterFrame );
				delete animations[ animation.id ];
			}
			_total = 0;
			_playIndex = 0;
			_autoplay = false;
		}
		
		public function hasAnimation( id:String ):Boolean
		{
			for each ( var animation:Object in animations )
				if ( String( animation.id ) == id)
					return true;
			return false;		
		}


		public function getAnimationByIndex( index:int ):MovieClip 
		{
			for each ( var animation:Object in animations )
				if ( int( animation.index ) == index )
					return animation.instance;
			return null;
		}

		public function getAnimationIndexByID( id:String ):int 
		{
			for each ( var animation:Object in animations )
				if ( String( animation.id ) == id )
					return int( animation.index );
			return -1;
		}		
		
		public function getAnimationIDByIndex( index:int  ):String 
		{
			for each ( var animation:Object in animations )
				if ( int( animation.index ) == index )
					return animation.id;
			return null;
		}		
		
		public function get interruptPolicy():int
		{
			return _interruptPolicy;
		}
		
		public function set interruptPolicy( value:int ):void
		{
			_interruptPolicy = value;
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
		
		private function initConcurrent():void 
		{
		}

		private function initSequential( id:String ):void 
		{
			if ( id == "" ) _playIndex = 0;
			else _playIndex = getAnimationIndexByID( id );

			if ( getAnimationIDByIndex( _playIndex ) )
			{						
				var itemDelay:Timer = new Timer( getAnimation( getAnimationIDByIndex( _playIndex )).delay * 1000, 1 );
				itemDelay.addEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
				itemDelay.start();
			}
		}

		private function timerComplete( event:TimerEvent ):void 
		{
			event.currentTarget.removeEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
			playAnimation( _playIndex );
		}

		private function playAnimation( index:int ):void
		{
			_playID = getAnimationIDByIndex( index );
			_isPlaying = true;
			var anime:MovieClip = getAnimationByIndex( index );
			anime.addEventListener( Event.ENTER_FRAME, enterFrame );
			anime.play();
			setChildrenProp( anime, "gotoAndPlay" );
		}

		private function enterFrame( event:Event ):void 
		{

			if ( event.currentTarget.currentFrame == event.currentTarget.totalFrames && _endFramePolicy == ENDFRAME_POLICY_STOP )
			{
				event.currentTarget.removeEventListener( Event.ENTER_FRAME, enterFrame );
				event.currentTarget.gotoAndStop( 1 );
				
				if ( getAnimation( getAnimationIDByIndex( _playIndex )).childPolicy == CHILD_POLICY_RECURSIVE )
					setChildrenProp( MovieClip( event.currentTarget ), "gotoAndStop" );
				
				_isPlaying = false;
				++_playIndex;
				if ( _playIndex == _total )
				{
					if ( _autoplay )
						playAuto( _autoplayDelay / 1000 );
					
					dispatchEvent( new TimelineEvent( TimelineEvent.SEQUENTIAL_COMPLETE, false, false, _playID, _playIndex ));
				}
				else
				{
					dispatchEvent( new TimelineEvent( TimelineEvent.COMPLETE, false, false, _playID, _playIndex ));
					if ( _playPolicy == PLAY_POLICY_SEQUENTIAL && _playIndex < _total )
					{
						initSequential( getAnimationIDByIndex( _playIndex ));
					}
				}					
			}
		}
		
		private function setChildrenProp( target:MovieClip, prop:String, indentString:String = "" ):void
		{
		    var child:DisplayObject;
		    for ( var i:uint=0; i < target.numChildren; i++ )
		    {
		        child = target.getChildAt(i);
		        if ( child is MovieClip )
		        {
		        	MovieClip( child )[ prop ]( 1 );
		            setChildrenProp( MovieClip( child ), prop, indentString + "    ");
		        }
		
		    }
		}			

	}
}
