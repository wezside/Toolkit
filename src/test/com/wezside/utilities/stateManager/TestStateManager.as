package test.com.wezside.utilities.stateManager 
{
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertEquals;
	import com.wezside.utilities.manager.state.StateManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestStateManager 
	{
		
		
		private static const STATE_ROLLOVER:String = "STATE_ROLLOVER";
		private static const STATE_ROLLOUT:String = "STATE_ROLLOUT";
		private static const STATE_SELECTED:String = "STATE_SELECTED";
		private var sm:StateManager;
		

		[Before]
		public function setUp():void
		{
			sm = new StateManager();
			sm.addState( STATE_ROLLOVER );			
			sm.addState( STATE_SELECTED, true );			
			sm.addState( STATE_ROLLOUT );			
		}
		
				
		[After]
		public function tearDown():void
		{
			sm.purge();
			sm = null;
		}		
		
				
		[Test] 
		public function testStateManagerNonReservedValue():void
		{
			sm.stateKey = STATE_ROLLOVER;
			assertEquals( 1, sm.stateValue );
			
			sm.stateKey = STATE_ROLLOUT;
			assertEquals( 4, sm.stateValue );	
			
			sm.stateKey = STATE_ROLLOVER;
			assertEquals( 1, sm.stateValue );
		}
		
		
		[Test]
		public function testStateManagerReservedValue():void
		{			
			sm.stateKey = STATE_SELECTED;
			assertEquals( 2, sm.stateValue );		
				
			sm.stateKey = STATE_SELECTED;
			assertEquals( 0, sm.stateValue );
			
			sm.stateKey = STATE_ROLLOUT;
			assertEquals( 4, sm.stateValue );
			
			sm.stateKey = STATE_SELECTED;
			assertEquals( 6, sm.stateValue );
		}
		
				
		[Test]
		public function testStateManagerKey():void
		{
			sm.stateKey = STATE_ROLLOVER;
			assertEquals( STATE_ROLLOVER, sm.stateKey );

			sm.stateKey = STATE_SELECTED;
			assertEquals( STATE_ROLLOVER + STATE_SELECTED, sm.stateKey ); 

			sm.stateKey = STATE_SELECTED;
			assertEquals( STATE_ROLLOVER, sm.stateKey );

			sm.stateKey = STATE_ROLLOUT;
			assertEquals( STATE_ROLLOUT, sm.stateKey );
			sm.stateKey = STATE_SELECTED;
			assertTrue( sm.compare( STATE_SELECTED+STATE_ROLLOUT ));

			sm.stateKey = STATE_ROLLOUT;
			assertTrue( sm.compare( STATE_ROLLOUT + STATE_SELECTED ));

		}
		
		[Test]
		public function stateValueTest():void
		{
			sm.stateKey = STATE_ROLLOVER;
			sm.stateKey = STATE_SELECTED;
			assertEquals( 3, sm.stateValue );
		}
		
		[Test]
		public function testStateManagerPrevious():void
		{
		
			assertNull( sm.previousState() );
			sm.stateKey = STATE_ROLLOVER;
			assertEquals( STATE_ROLLOVER, sm.previousState().key );
			
			sm.stateKey = STATE_ROLLOUT;
			sm.stateKey = STATE_ROLLOVER;			
			assertEquals( STATE_ROLLOUT, sm.previousState().key );
		}
				
		[Test]
		public function testStateManagerStateKeys():void
		{
			sm.stateKey = STATE_ROLLOVER;
			assertEquals( 1, sm.stateKeys.length );
		}
	}
}
