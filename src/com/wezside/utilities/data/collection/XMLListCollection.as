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
package com.wezside.utilities.data.collection 
{
	import com.wezside.utilities.data.iterator.IIterator;
	import com.wezside.utilities.data.iterator.XMLListIterator;

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

		public function addElement( value:XML ):void 
		{
			_collection.appendChild( value );	
		}

		public function find( value:String = "" ):Object 
		{
			var iterator:IIterator = iterator();
			iterator.reset();
						
			// Returns the first item
			if ( value == "" ) return iterator.next();			
			
			while ( iterator.hasNext() )	
			{
				var item:XML = XML( iterator.next() );
				if ( item.nodeName == value )
					return item;
			}
			return null;
		}
		
		public function get length():int
		{
			return _collection.length();			
		}
	}
}
