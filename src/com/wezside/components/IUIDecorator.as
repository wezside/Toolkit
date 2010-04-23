package com.wezside.components 
{
	import com.wezside.components.layout.ILayout;
	import com.wezside.components.shape.IShape;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIDecorator 
	{
		
		function get background():IShape
		function set background( value:IShape ):void
		
		function get layout():ILayout
		function set layout( value:ILayout ):void
				
		function get width():Number
		function set width( value:Number ):void
		
		function get height():Number
		function set height( value:Number ):void		
		
		function get filters():Array
		function set filters( value:Array ):void		
		
	 	function iterator( type:String = null ):IIterator;
		function arrange( event:UIElementEvent = null ):void;
		function update():void;
		
	}
}