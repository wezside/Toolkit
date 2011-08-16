package com.wezside.component.decorator.scroll 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.IUIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IScroll extends IUIDecorator
	{
		
		function get scrollWidth():int;
		function set scrollWidth( value:int ):void;
		
		function get scrollHeight():int;
		function set scrollHeight( value:int ):void;
		
		function get target():IUIDecorator;
		function set target( value:IUIDecorator ):void;
		
		function get horizontalGap():int;
		function set horizontalGap( value:int ):void;
		
		function get verticalGap():int;
		function set verticalGap( value:int ):void;
		
		function get scrollBarVisible():Boolean;
		function set scrollBarVisible( value:Boolean ):void;
		
		function get trackWidth():int
		function set trackWidth( value:int ):void
		
		function get trackHeight():int
		function set trackHeight( value:int ):void
		
		function get thumbWidth():int
		function set thumbWidth( value:int ):void
		
		function get thumbHeight():int
		function set thumbHeight( value:int ):void
	
		function get thumbColors():Array
		function set thumbColors( value:Array ):void
		
		function get trackColors():Array
		function set trackColors( value:Array ):void
		
		function get thumbXOffset():Number
		function set thumbXOffset( value:Number ):void 
		
		function get trackMinY():Number
		function set trackMinY( value:Number ):void
		
		function get trackMaxY():Number
		function set trackMaxY( value:Number ):void
		
		function get trackMinX():Number
		function set trackMinX( value:Number ):void
		
		function get trackMaxX():Number
		function set trackMaxX( value:Number ):void
		
		function get thumb():IUIElement
		function set thumb( value:IUIElement ):void
		
		function get track():IUIElement
		function set track( value:IUIElement ):void
		
		function to( value:Number ):void;
		function reset():void;
		function resetTrack():void;
		function resetThumb():void;
		function purge():void;

	}
}
