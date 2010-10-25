package test.com.wezside.components.gallery 
{
	import com.wezside.components.gallery.transition.Transition;
	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
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
			
			for ( var i : int = 0; i < 8; ++i) 
				items.push( { id: i, url: "bin-release/images/00"+(i+1)+".jpg", livedate: new Date() });
			
			gallery = new Gallery( items, 4, 3, 2, 2, "left", "custom", 1, 0.3, Gallery.RESIZE_HEIGHT, 80, Gallery.DISTRIBUTE_H, false, 550, 500, true, false );
			gallery.transition = new Transition( gallery );
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, arrangeComplete );
			gallery.x = 30;
			gallery.y = 30;
			gallery.create();
			addChild( gallery );
		}

		private function arrangeComplete(event:GalleryEvent):void 
		{
			Tracer.output( true, " VisualTestGallery.arrangeComplete(event)", getQualifiedClassName(this) );
			gallery.selectedIndex = 2;
			gallery.show();
		}
	}
}
