package com.wezside.utilities.binding 
{
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingCollection implements IBindableCollection 
	{
		private var _collection:Array;

		public function BindingCollection() 
		{
			_collection = [];	
		}
		
		public function iterator():IIterator
		{
			return new BindingIterator( _collection );
		}

		public function addElement( value:BindingMap ):void 
		{
			_collection.push( value );	
		}
		
		public function find(value:String):Object
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
