/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.data.collection 
{
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.XMLListIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLListCollection implements ICollection 
	{
		
		private var _collection:XMLList;

		public function XMLListCollection() 
		{
			_collection = new XMLList();	
		}
		
		public function get collection():XMLList
		{
			return _collection;
		}
		
		public function set collection( value:XMLList ):void
		{
			_collection = value;
		}		
		
		public function iterator():IIterator
		{
			return new XMLListIterator( _collection );
		}

		public function addElement( value:* ):void 
		{
			_collection.appendChild( value );	
		}

		public function find( prop:* = "", value:* = null ):*
		{
			var it:IIterator = iterator();
			it.reset();
						
			// Returns the first item
			if ( String( value ) == "" && String( value ) == "" && it.hasNext() )
			{
				it.purge();
				it = null;
				return it.next();	
			}
			
			while ( it.hasNext() )	
			{
				var item:XML = XML( it.next() );
				if ( item.nodeName == value )
				{
					it.purge();
					it = null;
					return item;
				}
			}
			it.purge();
			it = null;
			return null;
		}
		
		public function get length():int
		{
			return _collection.length();			
		}
		
		public function clone():ICollection
		{
			var copy:ICollection = new Collection();
			var it:IIterator = iterator();
			var object:*;
			while ( it.hasNext() )
				copy.addElement( it.next() );

			it.purge();
			it = null;
			object = null;
			return copy;
		}		
		
		public function getElementAt( index:int ):*
		{
			return _collection[ index ];
		}
		
		public function removeElement( prop:* = "", value:* = null ):*
		{
			for ( var i:int = 0; i < _collection.length(); ++i ) 
			{
				if ( _collection.contains( value ))	
				{
					delete _collection[i];
					break;		
				}
			}	
		}
		
		public function removeElementAt( index:int ):void
		{
			delete _collection[ index ];
		}		
		
		public function purge():void
		{
			_collection = null;
		}
		
		public function toString():String
		{
			var str:String = "";
			var iterator:IIterator = iterator();
			while ( iterator.hasNext())
			{
				var item:* = iterator.next();	
				str += item.toString();
			}
			iterator.purge();
			return str;
		}		
	}
}
