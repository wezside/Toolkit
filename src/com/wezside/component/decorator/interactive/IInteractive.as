package com.wezside.component.decorator.interactive 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.utilities.manager.state.StateManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IInteractive extends IUIDecorator
	{
		
		function get mouseChildren():Boolean;
		function set mouseChildren( value:Boolean ):void;
		
		function get buttonMode():Boolean;
		function set buttonMode( value:Boolean ):void;
				
		function get stateManager():StateManager;
		function set stateManager( value:StateManager ):void;				
		
		function get state():String;
		function set state( value:String ):void;
		
		function activate():void;
		function deactivate():void;
		
	}
}
