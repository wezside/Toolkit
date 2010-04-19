package com.wezside.components.layout 
{
	import com.wezside.components.IUIDecorator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ILayout extends IUIDecorator
	{
		
		function get horizontalGap():int;
		function set horizontalGap( value:int ):void;
		
		function get verticalGap():int;
		function set verticalGap( value:int ):void;
	}
}
