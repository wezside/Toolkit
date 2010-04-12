package test.com.wezside.sample.timelineManager 
{
	import com.wezside.utilities.manager.timeline.TimelineEvent;
	import com.wezside.utilities.manager.timeline.TimelineManager;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * A simple usage example for the TimelineManager utility class. The TimelineManager class is not 
	 * added to the DisplayList and simply manages instances and the playback of Timeline animations.
	 */
	public class TimelineSample extends Sprite
	{
		
		
		private var swfs:Array = [ "assets-embed/swf/timelineManager/Animation01.swf",
							       "assets-embed/swf/timelineManager/Animation02.swf",
							       "assets-embed/swf/timelineManager/Animation03.swf" ];
		private var manager:TimelineManager;


		public function TimelineSample() 
		{
			manager = new TimelineManager();
			load( swfs[0] );						
		}
		
		
		private function load( url:String ):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete );
			loader.load( new URLRequest( url ));
		}
		
		
		private function complete( event:Event ):void 
		{
			var mc:MovieClip = event.target.content as MovieClip;
			var id:String = swfs[0].substring( swfs[0].lastIndexOf( "/" ), swfs[0].lastIndexOf( "." ));
			manager.push( id, mc );
			addChild( mc );
			swfs.shift();
			swfs.length > 0 ? load( swfs[0] ) : loadComplete(); 
		}
		
		
		private function loadComplete():void
		{
			manager.addEventListener( TimelineEvent.SEQUENTIAL_COMPLETE, sequenceComplete );
			manager.playPolicy = TimelineManager.PLAY_POLICY_SEQUENTIAL; 
			manager.play();
		}


		private function sequenceComplete(event:TimelineEvent):void 
		{
			manager.purgeAll();
		}
	}
}
