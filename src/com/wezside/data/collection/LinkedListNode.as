package com.wezside.data.collection 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LinkedListNode 
	{
		

		private var _data:*;
		private var _next:LinkedListNode;


		public function get data():*
		{
			return _data;
		}
		
		public function set data( value:* ):void
		{
			_data = value;
		}

		public function get next():LinkedListNode
		{
			return _next;
		}
		
		public function set next( value:LinkedListNode ):void
		{
			_next = value;
		}
	}
}
