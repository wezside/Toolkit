Wezside Components/Utilities
============================

This is a hub for components I've written and re-use quite often. These include Actionscript and MXML components.

Latest release
=======
* Build 0.1.0031
* Compiled with Flex 4 SDK build 10434 

Component list
=======

* Accordion

Utility Class list
=======

* TimelineManager



Accordion
---------

		var itemA:IAccordionItem = new AccordionItem();
		itemA.header = headerDisplayObject;
		itemA.content = contentDisplayObject; 
			
		var acc:Accordion = new Accordion();
		acc.addItem( itemA );
		addChild( acc );


TimelineManager
---------------

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