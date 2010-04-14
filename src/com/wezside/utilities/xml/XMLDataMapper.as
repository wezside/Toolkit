package com.wezside.utilities.xml 
{
	import test.com.wezside.utilities.xml.Collection;

	import com.wezside.utilities.iterator.ICollection;
	import com.wezside.utilities.iterator.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataMapper 
	{
		private var _collection:XMLDataCollection;
		private var item:XMLDataItem;
		private var _data:IDeserializable;

		
		public function XMLDataMapper() 
		{
			_collection = new XMLDataCollection();
		}
		
		
		public function addDataMap( clazz:Class, nodeName:String = "", parentCollectionProperty:String = "" ):void
		{
			item = new XMLDataItem();
			item.clazz = clazz;
			item.nodeName = nodeName;
			item.parentCollectionProperty = parentCollectionProperty;
			_collection.addElement( item );
		}

		public function deserialize( xml:XML ):void 
		{
			// Create Top Level instance
			var root:IXMLDataItem = _collection.iterator().next() as IXMLDataItem;
			trace( root.clazz );
			_data = new root.clazz() as IDeserializable;
			trace( _data );
			build( xml.children()[0], _data );
		}

		public function get data():IDeserializable 
		{
			return _data;
		}

		private function build( xml:XML, parent:* ):void 
		{
		
			// Check if the class is mapped
			var item:IXMLDataItem = _collection.find( xml.name() );
			if ( item )
			{
				var clazz:Object = new item.clazz();

				// Map attributes to single properties
				for ( var i:int = 0; i < xml.attributes().length(); ++i ) 
				{				
					if ( clazz.hasOwnProperty( xml.attributes()[i].name() ))
						clazz[ String(xml.attributes()[i].name()) ] = xml.attributes()[i];
				}
				 
				// Inject text property
				if ( clazz.hasOwnProperty( "text" ))
					clazz["text"] = xml.text();
				
				// Add the new data instance to mapped parent's collection
				if ( parent.hasOwnProperty( item.parentCollectionProperty ) && !parent[ item.parentCollectionProperty ])
					parent[ item.parentCollectionProperty ] = new Collection();

				if ( parent[ item.parentCollectionProperty ] is ICollection )
					parent[ item.parentCollectionProperty ].push( clazz );
				
				
				// Check if leaf node
				if ( xml.children().length() > 0 )
				{
					for ( var k:int = 0; k < xml.children().length(); ++k ) 
					{
						build( xml.children()[k], clazz );
					}					
				}
			}
			else
			{
				if ( xml.name() )
					trace( "No data mapping specified for node " + xml.name() );
			}
		}
	}
}
