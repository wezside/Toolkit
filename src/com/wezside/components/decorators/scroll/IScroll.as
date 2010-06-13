package com.wezside.components.decorators.scroll 
{
	import com.wezside.components.IUIDecorator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IScroll extends IUIDecorator
	{
		
		function get scrollHeight():int;
		function set scrollHeight( value:int ):void;
		
		function get target():IUIDecorator;
		function set target( value:IUIDecorator ):void;
		
		function get horizontalGap():int;
		function set horizontalGap( value:int ):void;

	}
}
