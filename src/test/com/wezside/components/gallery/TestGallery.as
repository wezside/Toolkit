package test.com.wezside.components.gallery 
{
	import flexunit.framework.Assert;

	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestGallery 
	{

		private var items:Array;
		private var gallery:Gallery;


		[Before]
		public function setUp():void
		{			
			items = [{ id: "0",	
					   url: "",
					   livedate: new Date() }];
					   
			gallery = new Gallery( items, 4, 2, 2, 2, "left", "custom", 0, 0.3, Gallery.RESIZE_HEIGHT, 80, Gallery.DISTRIBUTE_H, false, 550, 500, true, true );
			gallery.x = 50;
			gallery.y = 30;			
		}
		
		[After]
		public function tearDown():void
		{
			gallery.purge();
			gallery = null;
			items = null;
		}
		
		[Test(async)] 
		public function testGalleryCreate():void
		{
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, Async.asyncHandler( this, galleryArranged, 3000, null, timeout ), false, 0, true );
			gallery.create();	
		}

		protected function galleryArranged( event:GalleryEvent, object:Object ):void
		{
			assertEquals( 0, gallery.numChildren );
		}
		
		protected function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}				
	}
}
