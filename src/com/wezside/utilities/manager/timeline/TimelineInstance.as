package com.wezside.utilities.manager.timeline 
{
	import flash.display.MovieClip;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TimelineInstance 
	{
		private var _id:String;
		private var _index:int;
		private var _target:MovieClip;
		private var _childPolicy:int;
		private var _delay:int;

		
		public function purge():void
		{
			_id = null;
			_target = null;
		}
		

		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function get target():MovieClip
		{
			return _target;
		}
		
		public function set target( value:MovieClip ):void
		{
			_target = value;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index( value:int ):void
		{
			_index = value;
		}
		
		public function get childPolicy():int
		{
			return _childPolicy;
		}
		
		public function set childPolicy( value:int ):void
		{
			_childPolicy = value;
		}
		
		public function get delay():int
		{
			return _delay;
		}
		
		public function set delay( value:int ):void
		{
			_delay = value;
		}
	}
}
