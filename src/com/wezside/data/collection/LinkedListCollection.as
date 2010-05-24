package com.wezside.data.collection 
{
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.LinkedListIterator;

	import flash.utils.Dictionary;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LinkedListCollection implements ICollection 
	{
		
		private var _length:int = 0;
		private var _current:LinkedListNode;
		private var _collection:Dictionary;


		public function LinkedListCollection() 
		{
			_collection = new Dictionary();
		}			
		
		public function addElement( value:* ):void
		{
			var node:LinkedListNode = new LinkedListNode();
			node.data = value;
			node.next = null;
			_collection[ _length ] = node;
			
			if ( !_current )
			{
				_collection["head"] = new LinkedListNode();
				_current = _collection["head"];
			}
			
			while ( _current.next )
				_current = _current.next;
								
			_current.next = node;
			
			++_length;	
			node = null;
		}
		
		public function getElementAt( index:int ):LinkedListNode
		{
			return _collection[ index.toString() ] as LinkedListNode;
		}
		
		public function removeElement( id:String ):void
		{
			
		}		

		public function iterator():IIterator
		{
			return new LinkedListIterator( _collection );
		}
		
		public function find( value:String = "" ):Object
		{		
			var iterator:IIterator = iterator();
				
			// Returns the first item
			if ( value == "" && iterator.hasNext() ) return iterator.next().data;
			
			while ( iterator.hasNext())
			{
				var item:LinkedListNode = iterator.next() as LinkedListNode;
				if ( item.data.id == value )
					return item.data; 
			}
			iterator = null;
			return null;
		}
		
		public function purge():void
		{
			for each ( var i:* in _collection )
				delete _collection[i];
			_collection = null;
		}
		
		public function length():uint
		{
			return _length;
		}		
	}
}
