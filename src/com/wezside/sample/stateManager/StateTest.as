package com.wezside.sample.stateManager
{
	import com.wezside.utilities.manager.state.StateManager;

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
			
			var sm:StateManager = new StateManager();			
			sm.addState( "Credentials", true );
			sm.addState( "Register" );
			sm.addState( "show-list" );
			sm.addState( "Search" );
			sm.addState( "Results" );

			field.text = "Use case  			| Current State Value   | History State Key\n";
			field.appendText("--------------------------------------------------------------------\n");
			
			sm.state = "Credentials";			
			field.appendText("Log in...\t\t\t|  " + sm.stateValue + "\t\t\t\t\t| " + sm.historyKey + "\n");
			
			sm.state = "Credentials";			
			field.appendText("Log out...\t\t\t|  " + sm.stateValue + "\t\t\t\t\t| " + sm.historyKey + "\n");
			
			sm.state = "Credentials";			
			field.appendText("Log in...\t\t\t|  " + sm.stateValue + "\t\t\t\t\t| " + sm.historyKey + "\n");
			
			sm.state = "Register";			
			field.appendText( sm.state + "\t\t\t|  " + sm.stateValue + "\t\t\t\t\t| " + sm.historyKey + "\n");
			
			sm.state = "Credentials";			
			field.appendText("Log out...\t\t\t|  " + sm.stateValue + "\t\t\t\t\t| " + sm.historyKey + "\n");
			field.appendText("Previous State...\t|  " + sm.previousState() + "\t\t\t| " + sm.historyKey + "\n");

			field.setTextFormat( fmt );
		}
	}
}
