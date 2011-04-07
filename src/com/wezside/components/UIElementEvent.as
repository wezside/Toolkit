/*
	The MIT License

	Copyright (c) 2011 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.components 
{
	import com.wezside.utilities.manager.state.IState;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UIElementEvent extends Event 
	{
		
		public static const INIT:String = "INIT";
		public static const CREATION_COMPLETE:String = "CREATION_COMPLETE";			
		public static const STYLEMANAGER_READY:String = "STYLEMANAGER_READY";			
		public static const ARRANGE_COMPLETE:String = "ARRANGE_COMPLETE";
		public static const STATE_CHANGE:String = "STATE_CHANGE";
		
		private var _state:IState;

		public function UIElementEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, state:IState = null )
		{
			super( type, bubbles, cancelable );
			_state = state;
		}

		public override function clone():Event 
		{
			return new UIElementEvent( type, bubbles, cancelable, _state );
		}
		
		public function get state():IState
		{
			return _state;
		}
		
		public function set state( value:IState ):void
		{
			_state = value;
		}	
	}
}
