package com.wezside.utilities.observer
{
	import com.wezside.utilities.manager.state.IState;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ObserverDetail implements IObserverDetail
	{
		private var _data:*;
		private var _origin:*;
		private var _state:IState;
		private var _resourceID:String;

		public function ObserverDetail( origin:*, state:IState, data:* = null, resourceID:String = "" )
		{
			_state = state;
			_data = data;
			_resourceID = resourceID;
			_origin = origin;
		}

		public function get origin():*
		{
			return _origin;
		}
		
		public function set origin( value:* ):void
		{
			_origin = value;
		}

		public function get state():IState
		{
			return _state;
		}

		public function get data():*
		{
			return _data;
		}

		public function set state( value:IState ):void
		{
			_state = value;
		}

		public function set data( value:* ):void
		{
			_data = value;
		}

		public function get resourceID():String
		{
			return _resourceID;
		}

		public function set resourceID( value:String ):void
		{
			_resourceID = value;
		}
	}
}
