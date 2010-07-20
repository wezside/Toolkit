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
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Collection implements ICollection 
	{

		private var _collection:Array;
		private var collectionIterator:IIterator;

		public function Collection() 
		{
			_collection = [];	
			collectionIterator = iterator();
		}	

		public function iterator():IIterator
		{
			return new ArrayIterator( _collection );					
		}
		
		public function find( value:String = "" ):Object
		{			
			collectionIterator.reset();			
			// Returns the first item
			if ( value == "" && collectionIterator.hasNext() ) return collectionIterator.next();
			
			while ( collectionIterator.hasNext())
			{
				var item:* = collectionIterator.next();
				if ( item.id == value )
					return item; 
			}
			return null;
		}
		
		public function get length():int
		{
			return _collection.length;
		}
		
		public function purge():void
		{
			_collection = null;
			collectionIterator.purge();
			collectionIterator = null;
		}
		
		public function addElement( value:* ):void
		{
			_collection.push( value );
		}
		
		public function getElementAt( index:int ):*
		{
			return _collection[ index ];
		}		
		
		public function removeElement( id:String ):*
		{
			var removeIndex:int = -1;
			collectionIterator.reset();
			while ( collectionIterator.hasNext())
			{
				var item:* = collectionIterator.next();
				if ( item.id == id )
				{
					removeIndex = collectionIterator.index() - 1;
					break;
				}
			}
			trace( removeIndex );
			return _collection.splice( removeIndex, 1 );
		}
	}
}
