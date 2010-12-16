package com.wezside.data.collection
{
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;

	import flash.utils.Dictionary;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class DictionaryCollection implements IDictionaryCollection
	{
				
		private var _length:int;
		private var _collection:Dictionary;
		private var _keys:Array;
		
		public function DictionaryCollection() 
		{
			_keys = [];
			_collection = new Dictionary();
		}
		
		public function purge():void
		{
			for each ( var obj:* in _collection )
				delete _collection[ obj ];
		}
		
		public function addElement( key:*, value:* ):void
		{
			_collection[ key ] = {index: _keys.length, value: value};
			_keys.push( key );
			_length++;
		}		
		
		public function getElement( key:* ):*
		{
			return _collection[ key ].value;
		}				

		public function iterator():IIterator
		{
			return new ArrayIterator( _keys );
		}
		
		public function hasElement( key:* ):Boolean
		{					
			return _collection[ key ];
		}

		public function find( prop:String = "", value:* = null ):*
		{
			return _collection[ prop ].value;
		}
				
		public function removeElement( prop:String = "", value:* = null ):*
		{
			if ( _collection[ prop ])
			{
				_keys.splice( [ _collection[ prop ].index ], 1 );
				delete _collection[ prop ];
			}
		}		

		public function toString():String
		{
			var str:String = "";
			for each ( var obj:* in _collection )
				str += obj.toString() + ",";			
			return str;
		}
		
		public function get length():int
		{
			return _length;
		}

	}
}
