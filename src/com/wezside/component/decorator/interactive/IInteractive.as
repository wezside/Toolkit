package com.wezside.component.decorator.interactive 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IInteractive extends IUIDecorator
	{
		function activate():void;
		function deactivate():void;
		function click( event:MouseEvent ):void;		
	}
}

