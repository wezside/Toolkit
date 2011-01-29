package test.com.wezside.components.gallery 
{
	import flexunit.framework.Assert;

	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestGallery 
	{

		private var items:ICollection;
		private var gallery:Gallery;


		[Before]
		public function setUp():void
		{			
			items = new Collection();
			items.addElement({ url: "gallery/images/001.jpg", livedate: new Date() });
					   
			gallery = new Gallery();
			gallery.debug = false;
			gallery.reflectionRowHeight = 1;
			gallery.columns = 4;
			gallery.rows = 3;
			gallery.horizontalGap = 1;
			gallery.verticalGap = 1;
			gallery.init( items );
			gallery.x = 30;
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
			assertEquals( 24, gallery.numChildren );
		}
		
		protected function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}				
	}
}
