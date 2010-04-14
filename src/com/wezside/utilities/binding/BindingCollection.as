package com.wezside.utilities.binding 
{
	import com.wezside.utilities.iterator.ICollection;
	import com.wezside.utilities.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingCollection implements ICollection 
	{
		private var _collection:Array;

		public function BindingCollection() 
		{
			_collection = [];	
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return new BindingIterator( _collection );
		}

		public function addElement( value:BindingMap ):void 
		{
			_collection.push( value );	
		}
	}
}
