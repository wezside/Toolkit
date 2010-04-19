package com.wezside.data.iterator 
{
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ChildIterator implements IIterator 
	{
		
		private var _index:uint = 0;
		private var _collection:Array;
		
		
		public function ChildIterator( child:DisplayObjectContainer ) 
		{
			_collection = getChildren( child );
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
	
		public function length():uint
		{
			return _collection.length;
		}
		
		private function getChildren( child:DisplayObjectContainer ):Array 
		{
			var arr:Array = [];
			for ( var i:int = 0; i < child.numChildren; ++i )
				arr.push( child.getChildAt( i )); 
			return arr;
		}		
	}
}
