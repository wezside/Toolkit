package test.com.wezside.components.gallery 
{
	import com.wezside.utilities.date.DateUtil;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.wezside.components.decorators.layout.GridReflectionLayout;
	import flash.events.Event;
	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.gallery.transition.StepsTransition;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestGallery extends Sprite 
	{

		private var items:Array = [];
		private var gallery:Gallery;

		public function VisualTestGallery()
		{					 
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		private function stageInit(event:Event):void 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			for ( var i : int = 0; i < 13; ++i) 
				items.push( { id: i, url: "gallery/images/001.jpg", livedate: new Date() });
			
			var dateUtil:DateUtil = new DateUtil();
			
//			items.push( { id: i, url: "gallery/images/001.jpg", livedate: dateUtil.convertDate("2010-12-24 00:00:00") });
			gallery = new Gallery( items, 4, 3, 2, 2, "left", "custom", 1, 0.3, Gallery.RESIZE_HEIGHT, 80, Gallery.DISTRIBUTE_H, false, stage.stageWidth, stage.stageHeight, true, true );

			
			gallery.transition = new StepsTransition( gallery );
			
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, arrangeComplete );
			gallery.addEventListener( GalleryEvent.INTRO_COMPLETE, introComplete );
			gallery.x = 30;
			gallery.y = 30;
			gallery.build();
			gallery.setStyle();
			gallery.arrange();
			addChild( gallery );
		}

		private function introComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.introComplete(event)", getQualifiedClassName( this ));
		}

		private function arrangeComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.arrangeComplete(event)", getQualifiedClassName( this ));
			gallery.selectedIndex = 2;
			gallery.show();
		}
	}
}
