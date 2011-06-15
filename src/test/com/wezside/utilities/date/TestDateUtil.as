package test.com.wezside.utilities.date 
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import com.wezside.utilities.date.DateUtil;

	import org.flexunit.asserts.assertEquals;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestDateUtil 
	{
		
		private var dateUtil:DateUtil;
		private var index:int;


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
		
		[Test]
		public function testCenturyIndex():void
		{
			index = dateUtil.centuryIndex( 1750 );
			assertEquals( 0, index );
			
			index = dateUtil.centuryIndex( 1850 );
			assertEquals( 1, index );
			
			index = dateUtil.centuryIndex( 1950 );
			assertEquals( 2, index );
			
			index = dateUtil.centuryIndex( 2000 );
			assertEquals( 3, index );
		}
		
		[Test]
		public function testStartDayIndexOfMonth():void
		{
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 1982, 3, 24, 17, 26, 13 ));		// April 24, 1982 = 6 (Saturday)
			assertEquals( 6, index );
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 2054, 5, 19, 17, 26, 13 ));		// June 19, 2054 = 5 (Friday)
			assertEquals( 5, index );
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 1783, 8, 18, 17, 26, 13 ));		// September 18, 1783 = 4 (Thursday)
			assertEquals( 4, index );
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 2000, 0, 1, 17, 26, 13 ));		// January 1, 2000 ( Leap year ) = 6 (Saturday)
			assertEquals( 6, index );
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 2000, 5, 15, 17, 26, 13 ));		// June 15, 2000 ( Leap year ) = 4 (Saturday)
			assertEquals( 4, index );
			index = dateUtil.calculateStartDayOfTheWeek( new Date( 2003, 11, 17, 17, 26, 13 ));		// June 15, 2000 ( Leap year ) = 4 (Saturday)
			assertEquals( 3, index );
		}
		
		[Test]
		public function testIsLeap():void
		{
			assertFalse( dateUtil.isLeap( new Date( 1773, 8, 18, 17, 26, 13 )));
			assertTrue( dateUtil.isLeap( new Date( 2000, 5, 15, 17, 26, 13 )));
			assertTrue( dateUtil.isLeap( new Date( 2004, 1, 15, 17, 26, 13 )));
		}
	}
}
