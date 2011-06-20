package com.wezside.component 
{
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.events.IEventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIDecorator extends IEventDispatcher
	{
		
//			function get state():String;
//			function set state( value:String ):void;
		
//			function get buttonMode():Boolean
//			function set buttonMode( value:Boolean ):void
//			function get mouseChildren():Boolean
//			function set mouseChildren( value:Boolean ):void
//			function get stateManager():StateManager
//			function set stateManager( value:StateManager ):void		
	
			function get width():Number
			function set width( value:Number ):void
			
			function get height():Number
			function set height( value:Number ):void	
					
		 	function iterator( type:String = null ):IIterator;
			function arrange():void;
	
	}
}