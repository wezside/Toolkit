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
		
		/**
		 * Add a new timeline element to the manager. This method will create a new TimelineInstance element. 
		 *  
		 * @param id A unique ID fo referencing a specific TimelineInstance
		 * @param target The Target embedded Movieclip
		 * @param delay A start delay before the TimelineInstance starts playing
		 * @param endFrame An end frame number for when the TimelineEvent.COMPLETE event is dispatch. Leave as -1 to use the totalFrames of the MovieClip
		 * @param autoVisible Toggels visibility on and off at start and end of playback
		 * @param childPolicy A policy defining if gotoAndStop(1) is called on all children at start and end of playback. Default is root only. 
		 */
		public function addElement( id:String, target:MovieClip, delay:int = 0, endFrame:int = -1, autoVisible:Boolean = false, childPolicy:String = CHILD_POLICY_ROOT ):void
		{
			var tmi:TimelineInstance = new TimelineInstance();
			tmi.id = id;
			tmi.index = total;
			tmi.delay = delay;
			tmi.target = target;
			tmi.autoVisible = autoVisible;
			tmi.childPolicy = childPolicy;
			tmi.endFrame = endFrame; 
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
			if ( currentTMI ) currentTMI.purge();
			playPolicy.purge();
			animations.purge();
			animations = null;
			currentTMI = null;
			playPolicy = null;
			iterator = null;
			playID = null;
		}
		
		public function purgeAnimation( id:String ):void
		{
			TimelineInstance( animations.find( "id", id )).purge();
			animations.removeElement( id );
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
			currentTMI = TimelineInstance( animations.find( "id", id ));
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
				tmi.purge();
				tmi = null;
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
			if ( mc.currentFrame == currentTMI.endFrame )
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
			dispatchEvent( new TimelineEvent( TimelineEvent.COMPLETE, false, false, playID, playIndex, total ));
			if ( playIndex == total-1 )
			{
				dispatchEvent( new TimelineEvent( TimelineEvent.SEQUENTIAL_COMPLETE, false, false, playID, playIndex, total ));
			}
			if ( playIndex < total-1 )
			{
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
			tmi.endFrame = tmi.endFrame == -1 ? tmi.target.totalFrames : tmi.endFrame;
			
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
		    child = null;
		}		
	}
}
