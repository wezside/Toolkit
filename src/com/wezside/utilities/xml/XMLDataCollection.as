package com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.ArrayIterator;
	import com.wezside.utilities.iterator.ICollection;
	import com.wezside.utilities.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataCollection implements ICollection 
	{
		
		private var _collection:Array;

		public function XMLDataCollection() 
		{
			_collection = [];	
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return new ArrayIterator( _collection );
		}

		public function addElement( value:IXMLDataItem ):void 
		{
			_collection.push( value );	
		}

		public function find( value:String ):Object 
		{
			var iterator:IIterator = iterator();
			iterator.reset();
			while ( iterator.hasNext() )	
			{
				var item:IXMLDataItem = IXMLDataItem( iterator.next() );
				if ( item.nodeName == value )
					return item;
			}
			return null;
		}
	}
}
