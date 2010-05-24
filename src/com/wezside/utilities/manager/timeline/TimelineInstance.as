package com.wezside.utilities.manager.timeline 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TimelineInstance extends EventDispatcher
	{
		private var _id:String;
		private var _index:int;
		private var _target:MovieClip;
		private var _childPolicy:String;
		private var _delay:int;
		private var _autoVisible:Boolean;

		
		public function initTarget():void
		{
			Loader( _target.getChildAt(0)).contentLoaderInfo.addEventListener( Event.COMPLETE, initialized );
		}
		
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
		
		public function get childPolicy():String
		{
			return _childPolicy;
		}
		
		public function set childPolicy( value:String ):void
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
		
		public function get autoVisible():Boolean
		{
			return _autoVisible;
		}
		
		public function set autoVisible( value:Boolean ):void
		{
			_autoVisible = value;
		}	
		
		private function initialized( event:Event ):void 
		{
			event.currentTarget.removeEventListener( Event.COMPLETE, initialized );
			dispatchEvent( new TimelineEvent( TimelineEvent.TARGET_INITIALIZED, false, false, "", -1, -1, event.currentTarget.content as MovieClip )); 
		}
		
	}
}
