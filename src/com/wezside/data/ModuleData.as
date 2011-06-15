package com.wezside.data
{
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	/**
	 * @author Wesley.Swanepoel
	 * 
	 * 
	 * TODO: Clean up
	 * TODO: Need to add namespace here too so we can use the power of namespaces which is multiple Modules from different namespaces
	 */
	public class ModuleData implements IDeserializable
	{
		
		public var id:String;
		public var items:ICollection;
		public var resources:ICollection;
		public var serviceID:String;
		
		private var _dataID:String;
		private var dataIt:IIterator = new NullIterator();

		
		public function get dataID():String
		{
			return _dataID;
		}
		
		public function set dataID( value:String ):void
		{
			_dataID = value;
		}
		
		public function item( id:String = "" ):ItemData
		{
			return items ? ItemData( items.find( "id", id )) : null;
		}	
		
		public function getQualifiedModuleID():String
		{
			return id + ( _dataID ? "-" + _dataID : "" );
		}
		
		/**
		 * Used to generate new ModuleData instances from data IDs specified in the config
		 */
		public function getDataIDIterator():IIterator
		{
			if ( _dataID )
			{
				var arr:Array = [];
				arr = _dataID.split( "," );
				if ( arr.length > 0  )
					dataIt = new ArrayIterator( arr );
			}			
			return dataIt;
		}

		public function clone():ModuleData
		{
			var data:ModuleData = new ModuleData();
			data.id = id;
			data.items = items;
			return data;
		}
		
		public function purge():void
		{
			dataIt.purge();
		}
	}
}
