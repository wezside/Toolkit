package com.wezside.sample.stateManager
{
	import com.wezside.utilities.managers.state.StateManager;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class StateTest extends Sprite
	{
		
		
		public function StateTest() 
		{
			init();
		}
		
		
		private function init():void
		{
			// Add some states with Credentials being a reserved stated	
			StateManager.addState( "Credentials", true );
			StateManager.addState( "Register" );
			StateManager.addState( "show-list" );
			StateManager.addState( "Search" );
			StateManager.addState( "Results" );

			trace( "Use case  		| Current State Value 	  | History State Key");
			trace( "--------------------------------------------------------------------");
			
			StateManager.state = "Credentials";			
			trace( "Log in...  		|  " + StateManager.stateValue + " 	 		  | " + StateManager.historyKey );
			
			StateManager.state = "Credentials";			
			trace( "Log out... 		|  " + StateManager.stateValue + " 	 		  | " + StateManager.historyKey );
			
			StateManager.state = "Credentials";			
			trace( "Log in...  		|  " + StateManager.stateValue + "  			  | " + StateManager.historyKey );
			
			StateManager.state = "Register";			
			trace( StateManager.state + " 		|  " + StateManager.stateValue + " 			  | " + StateManager.historyKey );
			
			StateManager.state = "Credentials";			
			trace( "Log out... 		|  " + StateManager.stateValue + " 		 	  | " + StateManager.historyKey );
			
			StateManager.state = "show-list";			
			trace( StateManager.state + " 		|  " + StateManager.stateValue + "  			  | " + StateManager.historyKey );

			StateManager.state = "Credentials";			
			trace( "Log in...  		|  " + StateManager.stateValue + "  			  | " + StateManager.historyKey );
			
			StateManager.state = "Search";			
			trace( StateManager.state + " 			|  " + StateManager.stateValue + "		 	  | " + StateManager.historyKey );
			
			StateManager.state = "Results";			
			trace( StateManager.state + " 		|  " + StateManager.stateValue + " 			  | " + StateManager.historyKey );
			
			StateManager.state = "Credentials";			
			trace( "Log out...  		|  " + StateManager.stateValue + " 			  | " + StateManager.historyKey );			

		}
	}
}
