package com.wezside.data.sort
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BubbleSort implements ISort
	{
		
		private var _type:String;
		private var _prop:String;
		private var _collection:Array;
		
		private var endTime:Number;
		private var startTime:Number;
				
		public function BubbleSort( collection:Array ) 
		{
			_type = SortType.ASCENDING;
			_collection = collection;
		}
		
		public function run():Array
		{
	   	    startTime = new Date().getTime();
			var len:int = _collection.length;
			var swap:Boolean = true;
			while( swap )
			{
				swap = false;
				for ( var i:int = 0; i < len - 1; ++i )
				{
					var first:* = _collection[ i ];				
					var second:* = _collection[ i + 1 ];
					if (( _type == SortType.ASCENDING && !_prop && first > second ) ||
					   ( _type == SortType.ASCENDING && _prop && ( first[ _prop ] > second[ _prop ] )))
					{					
						swap = true;
						_collection.splice( i, 1, second );
						_collection.splice( i + 1, 1, first );
					}
					else if (( _type == SortType.DESCENDING && !_prop && second > first ) || 
							( _type == SortType.DESCENDING && _prop && ( second[ _prop ] > first[ _prop ] )))
					{
						swap = true;
						_collection.splice( i, 1, second );
						_collection.splice( i + 1, 1, first );						
					}
				}
			}
			endTime = new Date().getTime();			
			return _collection;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type( value:String ):void
		{
			_type = value;
		}
		
		public function elapsed():Number
		{
			return endTime - startTime;
		}

		public function get property():String
		{
			return _prop;
		}

		public function set property( value:String ):void
		{
			_prop = value;
		}
	}
}
