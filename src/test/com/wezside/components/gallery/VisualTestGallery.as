package test.com.wezside.components.gallery 
{
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

		/**
		 * For JUST IN TIME creation policy one needs to supply the collection in pages, i.e. use this formula for the 
		 * dataprovider to divide the collection supplied into chunks or pages
		 * 
		 * for ( var i:int = ( pageIndex * ( COLUMNS * ROWS )); i < original.length ; i++ ) 
				if ( arr.length < ( COLUMNS * ROWS ))
		 * 
		 * For ON INITIALIZE just supply the entire collection of all the items that is required. This is fine for 
		 * smaller Galleries but should be avoided for larger galleries as all items are loaded and created up front.
		 */
		private function stageInit( event:Event ):void 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			items = new Collection();
			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
//			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });

			gallery = new Gallery();
			gallery.columns = 3;
			gallery.rows = 2;
			gallery.debug = false;
			gallery.stageWidth = stage.stageWidth;
			gallery.stageHeight = stage.stageHeight;
			gallery.reflectionRowHeight = 1;
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

		private function arrangeComplete( event:GalleryEvent ):void 
		{
			gallery.show();
			Tracer.output( true, " VisualTestGallery.arrangeComplete(event)", getQualifiedClassName( this ));
		}

		private function introComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.introComplete(event)", getQualifiedClassName( this ));
		}
	}
}
