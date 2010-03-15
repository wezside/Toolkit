package com.wezside.utilities.managers.state 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class State implements IState 
	{
		private var _key:String;
		private var _reserved:Boolean;
		private var _value:Number;

		
		public function State( key:String, reserved:Boolean = false ) 
		{
			_key = key;
			_reserved = reserved;	
		}
		
		public function clone():IState
		{
			var state:IState = new State( _key, _reserved );
			state.value = _value;
			return state;
		}

		public function get key():String
		{
			return _key;
		}
		
		public function get reserved():Boolean
		{
			return _reserved;
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set key( value:String ):void
		{
			_key = value;
		}
		
		public function set reserved( value:Boolean ):void
		{
			_reserved = value;
		}

		public function set value( value:Number ):void
		{
			_value = value;
		}
		
		
	}
}
