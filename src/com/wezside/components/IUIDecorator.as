package com.wezside.components 
{
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIDecorator 
	{

		function get width():Number
		function set width( value:Number ):void
		
		function get height():Number
		function set height( value:Number ):void		
		
	 	function iterator( type:String = null ):IIterator;
		function arrange( event:UIElementEvent = null ):void;

		
	}
}