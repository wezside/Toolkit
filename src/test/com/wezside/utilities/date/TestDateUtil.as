package test.com.wezside.utilities.date 
{
	import com.wezside.utilities.date.DateUtil;

	import org.flexunit.asserts.assertEquals;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestDateUtil 
	{
		
		private var dateUtil:DateUtil;


		[Before]
		public function setUp():void
		{
			dateUtil = new DateUtil();
			dateUtil.debug = true;			
		}
				
		[After]
		public function tearDown():void
		{
			dateUtil = null;
		}
		
				
		[Test] 
		public function testDateConvert():void
		{
			assertEquals( dateUtil.convertDate( "" ).toString(), "Invalid Date" );
			assertEquals( dateUtil.convertDate( "2009-01-01" ).toString(), "Invalid Date" );
			assertEquals( dateUtil.convertDate( "2009-03-13 16:18:24" ).toString(), "Fri Mar 13 16:18:24 GMT+0000 2009" );
		}
		
	}
}
