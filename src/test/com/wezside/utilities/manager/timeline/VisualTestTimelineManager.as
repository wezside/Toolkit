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

		
		[Embed(source="/../assets-embed/swf/timelineManager/Animation01.swf")]
		private var Animation01:Class;
		
		[Embed(source="/../assets-embed/swf/timelineManager/Animation03.swf")]
		private var Animation02:Class;
		
		[Embed(source="/../assets-embed/swf/timelineManager/Animation03.swf")]
		private var Animation03:Class;
		
		private var tm:TimelineManager;
		private var mc1:MovieClip;
		private var mc2:MovieClip;
		private var mc3:MovieClip;

		public function VisualTestTimelineManager()
		{
			tm = new TimelineManager();			
			mc1 = new Animation01() as MovieClip;		
			mc2 = new Animation02() as MovieClip;		
			mc3 = new Animation03() as MovieClip;		
			tm.push( "1", mc1 );
			tm.push( "two", mc2 );
			tm.push( "3", mc3 );
			tm.addEventListener( TimelineEvent.SEQUENTIAL_COMPLETE, complete );
			
			addChild( mc1 );			
			addChild( mc2 );			
			addChild( mc3 );
						
			tm.play();
		}
		
		protected function complete( event:TimelineEvent):void
		{
			trace( "Sequence complete ");
		}		
			
	}
}
