package test.com.wezside.utilities.stateManager 
{
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
			sm.state = STATE_ROLLOVER;
			assertEquals( 1, sm.stateValue );
			
			sm.state = STATE_ROLLOUT;
			assertEquals( 4, sm.stateValue );	
			
			sm.state = STATE_ROLLOVER;
			assertEquals( 1, sm.stateValue );
		}
		
		
		[Test]
		public function testStateManagerReservedValue():void
		{			
			sm.state = STATE_SELECTED;
			assertEquals( 2, sm.stateValue );		
				
			sm.state = STATE_SELECTED;
			assertEquals( 0, sm.stateValue );
			
			sm.state = STATE_ROLLOUT;
			assertEquals( 4, sm.stateValue );
			
			sm.state = STATE_SELECTED;
			assertEquals( 6, sm.stateValue );
		}
		
				
		[Test]
		public function testStateManagerKey():void
		{
			sm.state = STATE_ROLLOVER;
			assertEquals( STATE_ROLLOVER, sm.stateKey );

			sm.state = STATE_SELECTED;
			assertEquals( STATE_ROLLOVER + STATE_SELECTED, sm.stateKey ); 

			sm.state = STATE_SELECTED;
			assertEquals( STATE_ROLLOVER, sm.stateKey );

			sm.state = STATE_ROLLOUT;
			assertEquals( STATE_ROLLOUT, sm.stateKey );

		}
	}
}
