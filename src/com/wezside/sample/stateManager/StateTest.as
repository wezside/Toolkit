package com.wezside.sample.stateManager
{
	import com.wezside.utilities.managers.state.StateManager;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class StateTest extends Sprite
	{
		
		
		public function StateTest() 
		{

			var fmt:TextFormat = new TextFormat();
			fmt.font = "Courier New";
			
			var field:TextField = new TextField();
			field.width = 500;
			field.height = 400;
			addChild( field );

			// Add some states with Credentials being a reserved stated	
			StateManager.addState( "Credentials", true );
			StateManager.addState( "Register" );
			StateManager.addState( "show-list" );
			StateManager.addState( "Search" );
			StateManager.addState( "Results" );

			field.text = "Use case  			| Current State Value   | History State Key\n";
			field.appendText("--------------------------------------------------------------------\n");
			
			StateManager.state = "Credentials";			
			field.appendText("Log in...\t\t\t|  " + StateManager.stateValue + "\t\t\t\t\t| " + StateManager.historyKey + "\n");
			
			StateManager.state = "Credentials";			
			field.appendText("Log out...\t\t\t|  " + StateManager.stateValue + "\t\t\t\t\t| " + StateManager.historyKey + "\n");
			
			StateManager.state = "Credentials";			
			field.appendText("Log in...\t\t\t|  " + StateManager.stateValue + "\t\t\t\t\t| " + StateManager.historyKey + "\n");
			
			StateManager.state = "Register";			
			field.appendText( StateManager.state + "\t\t\t|  " + StateManager.stateValue + "\t\t\t\t\t| " + StateManager.historyKey + "\n");
			
			StateManager.state = "Credentials";			
			field.appendText("Log out...\t\t\t|  " + StateManager.stateValue + "\t\t\t\t\t| " + StateManager.historyKey + "\n");
			field.appendText("Previous State...\t|  " + StateManager.previousState() + "\t\t\t| " + StateManager.historyKey + "\n");

			field.setTextFormat( fmt );
		}
	}
}
