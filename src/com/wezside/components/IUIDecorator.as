package com.wezside.components 
{
	import com.wezside.components.layout.ILayout;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIDecorator 
	{
		function get layout():ILayout
		function set layout( value:ILayout ):void
		
	 	function iterator( type:String = null ):IIterator;
		function arrange( event:UIElementEvent = null ):void;
		function update():void;
		
	}
}
