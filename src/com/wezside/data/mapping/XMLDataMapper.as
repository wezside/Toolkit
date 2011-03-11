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
package com.wezside.data.mapping 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.XMLListCollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.XMLListIterator;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.string.StringUtil;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataMapper 
	{

		private var _data:*;
		private var _debug:Boolean;
		private var item:XMLDataItem;
		private var _strUtil:StringUtil;
		private var _collection:DictionaryCollection;
		private var _xmlCollection:XMLListCollection;
		private var _xmlCollectionIterator:IIterator;
		private var _namespaces:DictionaryCollection;
		private var _id:String;

		public function XMLDataMapper() 
		{
			_debug = false;
			_id = "";
			_strUtil = new StringUtil();
			_namespaces = new DictionaryCollection();
			_collection = new DictionaryCollection( );
		}

		public function addDataMap( clazz:Class, nodeName:String = "", parentCollectionProperty:String = "" ):void
		{
			Tracer.output( _debug, " XMLDataMapper.addDataMap(" + clazz + ", " + nodeName + " , " + parentCollectionProperty + ")", "" );
			item = new XMLDataItem( );
			item.id = _id != "" ? _id + "-" + nodeName : nodeName;
			item.clazz = clazz;
			item.nodeName = nodeName;
			item.parentCollectionProperty = parentCollectionProperty;
			_collection.addElement( item.id, item );
		}

		public function deserialize( xml:XML ):void 
		{
			// Create Top Level instance
			var it:IIterator = _collection.iterator( );
			
			var root:IXMLDataItem = _collection.getElement( String( it.next() )) as IXMLDataItem;
			if ( root )
			{
				if ( !_data ) _data = new root.clazz( );
				_xmlCollection = new XMLListCollection();
				_xmlCollection.collection = xml.children();			
				_xmlCollectionIterator = _xmlCollection.iterator( );
				build( _xmlCollectionIterator, _data );
				buildNamespaceCollection( xml.namespaceDeclarations());	
			}
			else
				throw new Error( "Must have a root Data class assigned." );
				
			it.purge();
			it = null;
		}

		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}

		public function get debug():Boolean
		{
			return _debug;
		}

		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}

		public function get data():* 
		{
			return _data;
		}

		public function get length():int
		{
			return _collection.length;
		}

		public function get namespaces():DictionaryCollection
		{
			return _namespaces;
		}
		
		public function set namespaces( value:DictionaryCollection ):void
		{
			_namespaces = value;
		}

		public function toString():String 
		{
			return getQualifiedClassName( this );
		}

		private function build( iterator:IIterator, parent:* ):void 
		{		
			// Loop through collection using iterator
			while ( iterator.hasNext( ))
			{							
				
				var child:XML = XML( iterator.next() );
				var childName:String = child.name() ? child.name().localName : "";
				var uniqueID:String = _id ? _id + "-" + childName : childName;
				var item:IXMLDataItem = IXMLDataItem( _collection.getElement( uniqueID ));	
				
				// Check if there is a class to map from the xml supplied
				if ( item )
				{
					var clazz:Object = new item.clazz( );
										
					// Map attributes to single properties
					for ( var i:int = 0; i < child.attributes( ).length( ); ++i ) 
					{
						if ( clazz.hasOwnProperty( child.attributes( )[i].name())) 
						{
							if ( clazz[ String( child.attributes( )[i].name() ) ] is Boolean ) 
							{
								clazz[ String( child.attributes( )[i].name())] = ( child.attributes( )[i] == "true" || child.attributes( )[i] == "1" );
							}
							else if ( String( child.attributes( )[i] ).indexOf( "%" ) != -1 )
							{
								if ( String( child.attributes( )[i].name()) == "width" )
									clazz[ "widthRatio" ] = _strUtil.getNumeric( child.attributes( )[i] ) / 100;
									
								if ( String( child.attributes( )[i].name()) == "height" )
									clazz[ "heightRatio" ] = _strUtil.getNumeric( child.attributes( )[i] ) / 100;
							}
							else 
							{
								clazz[ String( child.attributes( )[i].name())] = child.attributes( )[i];
							}
						}
					}
					 
					// Inject text property
					if ( clazz.hasOwnProperty( "text" ))
						clazz["text"] = child.text();
					
					// Add the new data instance to collection in parent
					if ( parent.hasOwnProperty( item.parentCollectionProperty ) && !parent[ item.parentCollectionProperty ])
						parent[ item.parentCollectionProperty ] = new Collection( );
						
					if ( parent.hasOwnProperty( item.parentCollectionProperty ) && parent[ item.parentCollectionProperty ] is ICollection )
					{
						parent[ item.parentCollectionProperty ].addElement( clazz );
						Tracer.output( _debug, " Adding " + item.clazz, toString( ) );
					}			
			
					// Get the child's children										
					var xmlList:XMLListCollection = new XMLListCollection( );
					xmlList.collection = child.children();
					
					if ( child.name() )
						Tracer.output( _debug, " Trying to map " + xmlList.length + " child(ren) of '" + child.name() + "'", toString( ) );		 
						
					build( xmlList.iterator( ), clazz );
				}
				else
				{
					// Single leaf node text value 
					if ( parent.hasOwnProperty( child.localName()) && child.text().length() == 1 )
					{
						parent[ child.localName() ] = child.text();
						Tracer.output( _debug, " Mapping single leaf node '" + child.localName() + "' with text value '" + child.text() + "' on data class " + parent, toString() );
					}
					Tracer.output( _debug, " No mapping for '" + child.name( ) + "' moving on. Iterator index is " + XMLListIterator( _xmlCollectionIterator ).index( ) + " ", toString( ) );		 
					if ( iterator.hasNext( )) build( _xmlCollectionIterator, _data );
				}
			}
		}

		private function buildNamespaceCollection( namespaceDeclarations:Array ):void 
		{
			for ( var i:int = 0; i < namespaceDeclarations.length; ++i ) 
				_namespaces.addElement( Namespace( namespaceDeclarations[i] ).prefix, Namespace( namespaceDeclarations[i] ));	
		}
	}
}
