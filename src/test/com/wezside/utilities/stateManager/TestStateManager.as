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
			sm.addState( STATE_ROLLOUT );			
			sm.addState( STATE_SELECTED, true );			
		}
				
		[After]
		public function tearDown():void
		{
			sm.purge();
			sm = null;
		}		
				
		[Test] 
		public function testStateManagerHistory():void
		{
			sm.state = STATE_ROLLOVER;
			assertEquals( sm.state, STATE_ROLLOVER ); 
			
			sm.state = STATE_SELECTED;
			assertEquals( STATE_ROLLOVER + STATE_SELECTED, sm.historyKey ); 

			trace( sm.historyKey );			
			sm.state = STATE_SELECTED;
			
			trace( sm.historyKey );
			assertEquals( sm.historyKey, STATE_ROLLOVER );
		}
	}
}
