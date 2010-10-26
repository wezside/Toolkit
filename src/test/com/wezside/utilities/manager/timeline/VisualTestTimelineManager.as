package test.com.wezside.utilities.manager.timeline 
{
	import com.wezside.utilities.manager.timeline.TimelineEvent;
	import com.wezside.utilities.manager.timeline.TimelineManager;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestTimelineManager extends Sprite 
	{

		
		[Embed(source="/../resource/swf/timelineManager/Animation01.swf")]
		private var Animation01:Class;
		
		[Embed(source="/../resource/swf/timelineManager/Animation02.swf")]
		private var Animation02:Class;
		
		[Embed(source="/../resource/swf/timelineManager/Animation03.swf")]
		private var Animation03:Class;
		
		private var tm:TimelineManager;
		
		private var mc1:MovieClip;
		private var mc2:MovieClip;
		private var mc3:MovieClip;


		public function VisualTestTimelineManager()
		{
			tm = new TimelineManager();			
			
			mc1 = new Animation01();
			mc2 = new Animation02();		
			mc3 = new Animation03();
			tm.addEventListener( TimelineEvent.READY, ready );
			tm.addEventListener( TimelineEvent.COMPLETE, complete );
			tm.addEventListener( TimelineEvent.SEQUENTIAL_COMPLETE, sequenceComplete );
			tm.addElement( "1", mc1, 0, -1, false,  TimelineManager.CHILD_POLICY_RECURSIVE );
			tm.addElement( "2", mc2, 0, 30, false, TimelineManager.CHILD_POLICY_RECURSIVE );
			tm.addElement( "3", mc3, 0, -1, false, TimelineManager.CHILD_POLICY_RECURSIVE );
												
			addChild( mc3 );
			addChild( mc2 );			
			addChild( mc1 );			
		}

		private function complete( event:TimelineEvent ):void 
		{
			trace( "End Frame reached " + event.index );
		}

		private function ready( event:TimelineEvent ):void 
		{
			if ( event.total == 3 )
			{
				tm.play();
			}
		}

		protected function sequenceComplete( event:TimelineEvent):void
		{
			trace( "Sequence complete ");
					
			mc1.removeChildAt(0);
			mc2.removeChildAt(0);
			mc3.removeChildAt(0);
			removeChild( mc3 );
			removeChild( mc2 );			
			removeChild( mc1 );
			
			Animation01 = null;
			Animation02 = null;
			Animation03 = null;
			
			tm.purge();
			tm = null;				
			mc1 = null;
			mc2 = null;		
			mc3 = null;			
		}		
			
	}
}