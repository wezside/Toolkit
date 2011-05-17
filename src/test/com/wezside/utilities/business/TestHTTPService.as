package test.com.wezside.utilities.business
{
	import flexunit.framework.Assert;

	import com.wezside.utilities.business.ResponderEvent;
	import com.wezside.utilities.business.rpc.HTTPService;

	import org.flexunit.async.Async;

	import flash.events.Event;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestHTTPService
	{
		private var service:HTTPService;
		
		[Before]
		public function setUp():void
		{
			service = new HTTPService();
		}
				
		[After]
		public function tearDown():void
		{
			service.purge();
			service = null;
		}
				
		[Test("async")] 
		public function testCancel():void
		{
			service.id = "test";
			service.method = HTTPService.POST_METHOD;
			service.asyncToken = Math.random();
			service.url = "http://www.wezside.co.za/";
			service.addEventListener( ResponderEvent.RESULT, Async.asyncHandler( this, result, 5000, null, timeout ), false, 0, true );
			service.addEventListener( ResponderEvent.FAULT, Async.asyncHandler( this, fault, 5000, null, timeout ), false, 0, true );
			service.send();
			service.cancel();
		}		
		
		private function result( event:Event, object:Object ):void
		{
	    	Assert.fail( "This event handler should not have been invoked because we cancelled this service immediately after the first call." );			
		}
		
		private function fault( event:Event, object:Object ):void
		{
	    	Assert.fail( "An error occured invoking the service" );			
		}
		
		private function timeout( object:Object ):void
		{
	    	Assert.assertTrue( "This timeout handler means the service was cancelled successfully" );			
		}			
	}
}
