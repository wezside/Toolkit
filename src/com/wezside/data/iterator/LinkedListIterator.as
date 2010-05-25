package com.wezside.data.iterator 
{
	import com.wezside.data.collection.LinkedListNode;

	import flash.utils.Dictionary;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LinkedListIterator implements IIterator 
	{

		private var _current:LinkedListNode;
		private var _collection:Dictionary;		

		
		public function LinkedListIterator( collection:Dictionary ) 
		{
			_collection = collection;
			reset();
		}	

		public function reset():void
		{
			_current = _collection["head"];
		}
		
		public function next():Object
		{
			_current = _current.next;
			return _current;
		}
		
		public function hasNext():Boolean
		{
			return _current.next ? true : false;
		}
		
		public function index():int
		{
			return 0;
		}
		
		public function length():uint
		{
			return _collection.length();
		}
		
		public function purge():void
		{
			for each ( var i:* in _collection )
				delete _collection[i];
			_current = null;
			_collection = null;
		}
	}
}
