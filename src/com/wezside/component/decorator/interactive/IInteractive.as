package com.wezside.component.decorator.interactive 
{
	import com.wezside.component.IUIDecorator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IInteractive extends IUIDecorator
	{
		function activate():void;
		function deactivate():void;
	}
}

