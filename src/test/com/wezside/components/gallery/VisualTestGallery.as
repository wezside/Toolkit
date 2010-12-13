package test.com.wezside.components.gallery 
{
	import com.wezside.components.decorators.layout.DistributeLayout;
	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestGallery extends Sprite 
	{

		private var items:ICollection;
		private var gallery:Gallery;

		public function VisualTestGallery()
		{					 
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		private function stageInit( event:Event ):void 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			items = new Collection();
			items.addElement( { id: 0, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 1, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement( { id: 2, url: "gallery/images/001.jpg", livedate: new Date() });


			gallery = new Gallery();
			gallery.debug = false;
			gallery.showArrangement = true;
			gallery.stageWidth = stage.stageWidth;
			gallery.stageHeight = stage.stageHeight;
			gallery.reflectionRowHeight = 1;
			gallery.columns = 4;
			gallery.rows = 3;			
			gallery.horizontalGap = 1;
			gallery.verticalGap = 1;
			gallery.init( items );		
			gallery.create();
//			gallery.transition = new StepsTransition( gallery );			
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, arrangeComplete );
			gallery.addEventListener( GalleryEvent.INTRO_COMPLETE, introComplete );
			gallery.x = 30;
			gallery.y = 30;
			addChild( gallery );
		}

		private function arrangeComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.arrangeComplete(event)", getQualifiedClassName( this ));
			gallery.show();
		}

		private function introComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.introComplete(event)", getQualifiedClassName( this ));
		}
	}
}
