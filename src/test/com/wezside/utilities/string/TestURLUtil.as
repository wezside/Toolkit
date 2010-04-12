package test.com.wezside.utilities.string 
{
	import com.wezside.utilities.string.URLUtil;

	import org.flexunit.asserts.assertEquals;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestURLUtil 
	{
		private var urlUtil:URLUtil;
		private var returnValue:int;

		[Before]
		public function setUp():void
		{
			urlUtil = new URLUtil();
			returnValue = 0;							
		}
				
		[After]
		public function tearDown():void
		{
			urlUtil = null;
			returnValue = 0;
		}
		
				
		[Test] 
		public function testGetNumPaths():void
		{
			returnValue = urlUtil.getNumPaths( "services-travel", "-" );
			assertEquals( 2, returnValue );
			
			returnValue = urlUtil.getNumPaths( "/services/travel", "/" );
			assertEquals( 2, returnValue );
			
			returnValue = urlUtil.getNumPaths( "\services\travel", "\\" );
			assertEquals( 2, returnValue );
			
			returnValue = urlUtil.getNumPaths( "services?travel?", "?" );
			assertEquals( 2, returnValue );
			
			returnValue = urlUtil.getNumPaths( "*services*travel*", "*" );
			assertEquals( 2, returnValue );
		}
		
	}
}
