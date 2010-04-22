package com.wezside.utilities.binding 
{
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingIterator implements IIterator 
	{		

		private var _index:uint = 0;
		private var _collection:Array;		
		
		public function BindingIterator( collection:Array ) 
		{
			_collection = collection;
		}

		public function reset():void
		{
			_index = 0;
		}
		
		public function next():Object
		{
			return _collection[ _index++ ];
		}
		
		public function hasNext():Boolean
		{
			return _index < _collection.length;
		}
		
		public function index():int
		{
			return _index;
		}
		
		public function length():uint
		{
			return _collection.length;
		}
	}
}
