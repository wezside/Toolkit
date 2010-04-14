package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.ICollection;
	import com.wezside.utilities.iterator.IDeserializable;
	import com.wezside.utilities.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Collection implements ICollection 
	{
		private var _collection:Array;

		public static const ITEM:String = "ITEM";
		
		
		public function Collection() 
		{
			_collection = [];	
		}	

		public function iterator( type:String = null ):IIterator
		{
			return new TestItemIterator( _collection );					
		}
		
		public function push( value:IDeserializable ):void
		{
			_collection.push( value );
		}
		
		public function find( value:String ):Object
		{
			var iterator:IIterator = iterator();
			iterator.reset();
			
			while( iterator.hasNext())
			{
				var item:* = iterator.next();
				if ( item.id == value )
					return item; 
			}
			return null;
		}
	}
}
