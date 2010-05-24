package com.wezside.utilities.manager.timeline 
{
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.collection.LinkedListCollection;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TimelineManager extends EventDispatcher 
	{
		
		public static const PLAY_POLICY_SEQUENTIAL:String = "sequential"; 
		public static const PLAY_POLICY_CONCURRENTLY:String = "concurrent";		 
		public static const CHILD_POLICY_ROOT:String = "childPolicyRoot"; 
		public static const CHILD_POLICY_RECURSIVE:String = "childPolicyRecursive";
				
				
		private var playPolicy:StateManager;
		private var animations:LinkedListCollection;
		private var total:int;
		private var currentTMI:TimelineInstance;
		private var playID:String;
		private var playIndex:int;
		private var iterator:IIterator;
		private var initializeCounter:int;

		
		public function TimelineManager() 
		{
			total = 0;
			initializeCounter = 0;
			animations = new LinkedListCollection();
			playPolicy = new StateManager();
			playPolicy.addState( PLAY_POLICY_SEQUENTIAL );
			playPolicy.addState( PLAY_POLICY_CONCURRENTLY );
			playPolicy.stateKey = PLAY_POLICY_SEQUENTIAL;
		}
		
		public function addElement( id:String, target:MovieClip, delay:int = 0, autoVisible:Boolean = false, childPolicy:String = CHILD_POLICY_ROOT ):void
		{
			var tmi:TimelineInstance = new TimelineInstance();
			tmi.id = id;
			tmi.index = total;
			tmi.delay = delay;
			tmi.target = target;
			tmi.autoVisible = autoVisible;
			tmi.childPolicy = childPolicy; 
			tmi.initTarget();
			animations.addElement( tmi );
			++total;	
			tmi.addEventListener( TimelineEvent.TARGET_INITIALIZED, addComplete );		
			tmi = null;	
		}		

		public function play( id:String = "" ):void
		{
			iterator = animations.iterator();
			switch ( playPolicy.stateKey )
			{
				case PLAY_POLICY_SEQUENTIAL: initSequential( id ); break;
				case PLAY_POLICY_CONCURRENTLY: initConcurrent(); break;
				default: break;
			}
		}

		public function purge():void
		{
			animations.purge();
		}
		
		public function purgeAnimation( id:String ):void
		{
		}
		
		public function get playbackPolicy():String
		{
			return playPolicy.stateKey;
		}
		
		public function set playbackPolicy( value:String ):void
		{
			playPolicy.stateKey = value;
		}
		
		private function initSequential( id:String ):void 
		{
			var delay:int = 0;
			currentTMI = TimelineInstance( animations.find( id ));
			delay = currentTMI.delay;
			playID = currentTMI.id;
			playIndex = currentTMI.index;
			var itemDelay:Timer = new Timer( delay * 1000, 1 );
			itemDelay.addEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
			itemDelay.start();
		}		

		private function initConcurrent():void 
		{
			while ( iterator.hasNext() )
			{
				var tmi:TimelineInstance = iterator.next().data as TimelineInstance;
				initSequential( tmi.id );
			}
		}

		private function timerComplete( event:TimerEvent = null ):void 
		{
			event.currentTarget.removeEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );			
			currentTMI.target.addEventListener( Event.ENTER_FRAME, enterFrame );
			currentTMI.target.visible = true;
			currentTMI.target.play();
			if ( currentTMI.childPolicy == CHILD_POLICY_RECURSIVE )
				setChildrenProp( currentTMI.target, "gotoAndPlay", 1 );
		}
		
		private function enterFrame( event:Event ):void 
		{			
			var mc:MovieClip = event.currentTarget as MovieClip;
			if ( mc.currentFrame == mc.totalFrames )
			{
				mc.removeEventListener( Event.ENTER_FRAME, enterFrame );
				mc.gotoAndStop( 1 );
				mc.visible = !currentTMI.autoVisible;
				if ( currentTMI.childPolicy == CHILD_POLICY_RECURSIVE )
					setChildrenProp( mc, "gotoAndStop", 1 );		
					
				switch ( playPolicy.stateKey )
				{
					case PLAY_POLICY_SEQUENTIAL: 
						playNext();			
						break;
				}									
			}
		}	
		
		private function playNext():void
		{			
			if ( playIndex == total-1 )
			{
				dispatchEvent( new TimelineEvent( TimelineEvent.SEQUENTIAL_COMPLETE, false, false, playID, playIndex, total ));
			}
			if ( playIndex < total-1 )
			{
				dispatchEvent( new TimelineEvent( TimelineEvent.COMPLETE, false, false, playID, playIndex, total ));
				var nextID:String = TimelineInstance( iterator.next().next.data ).id;
				initSequential( nextID );
			}					
		}

		private function addComplete( event:TimelineEvent ):void 
		{		 
			event.currentTarget.removeEventListener( TimelineEvent.TARGET_INITIALIZED, addComplete );			
			var tmi:TimelineInstance = event.currentTarget as TimelineInstance;
			tmi.target = event.targetMC as MovieClip;
			tmi.target.gotoAndStop( 1 );
			tmi.target.visible = !tmi.autoVisible;
			
			if ( tmi.childPolicy == CHILD_POLICY_RECURSIVE )
				setChildrenProp( tmi.target, "gotoAndStop", 1 );
			++initializeCounter;
			dispatchEvent( new TimelineEvent( TimelineEvent.READY, false, false, tmi.id, tmi.index, initializeCounter ));
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
