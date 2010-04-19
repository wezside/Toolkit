package test.com.wezside.components.gallery 
{
	import test.com.wezside.sample.gallery.DefaultTransition;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.gallery.Gallery;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UITestGallery extends Sprite 
	{

		private var items:Array = [];
		private var gallery:Gallery;

		public function UITestGallery()
		{					 
			for ( var i : int = 0; i < 8; ++i) 
				items.push( { id: i, url: "bin-release/images/00"+(i+1)+".jpg", livedate: new Date() });
					   
			items.push( { id: i, url: "assets-embed/swf/library.swf", livedate: new Date(), linkageID: "GreenItem" });
			
			gallery = new Gallery( items, 4, 3, 2, 2, "left", "custom", 2, 0.3, Gallery.RESIZE_HEIGHT, 80, Gallery.DISTRIBUTE_H, false, 550, 500, true, false );
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, arrangeComplete );
			gallery.x = 30;
			gallery.y = 30;			
			gallery.create();
			gallery.transition = new DefaultTransition( gallery );
			addChild( gallery );
		}

		private function arrangeComplete(event:GalleryEvent):void 
		{
			gallery.selectedIndex = 2;
			gallery.show();
		}
	}
}
