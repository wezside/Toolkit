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
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.XMLDataCollection;
	import com.wezside.data.collection.XMLListCollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.XMLListIterator;
	import com.wezside.utilities.logging.Tracer;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataMapper 
	{

		private var item:XMLDataItem;
		private var _data:*;
		private var _collection:XMLDataCollection;
		private var _xmlCollection:XMLListCollection;
		private var _xmlCollectionIterator:IIterator;
		private var _debug:Boolean;

		
		public function XMLDataMapper() 
		{
			_debug = false;
			_collection = new XMLDataCollection( );
		}

		public function addDataMap( clazz:Class, nodeName:String = "", parentCollectionProperty:String = "" ):void
		{
			Tracer.output( _debug, " XMLDataMapper.addDataMap(" + clazz + ", " + nodeName + " , " + parentCollectionProperty + ")", "" );
			item = new XMLDataItem( );
			item.clazz = clazz;
			item.nodeName = nodeName;
			item.parentCollectionProperty = parentCollectionProperty;
			_collection.addElement( item );
		}

		public function deserialize( xml:XML ):void 
		{
			// Create Top Level instance
			var root:IXMLDataItem = _collection.iterator( ).next( ) as IXMLDataItem;
			_data = new root.clazz( );
			_xmlCollection = new XMLListCollection( );
			_xmlCollection.collection = xml.children( );
			_xmlCollectionIterator = _xmlCollection.iterator( );
			build( _xmlCollectionIterator, _data );
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

		public function toString():String 
		{
			return getQualifiedClassName( this );
		}

		private function build( iterator:IIterator, parent:* ):void 
		{		
			// Loop through collection using iterator
			while( iterator.hasNext( ))
			{							
				var child:XML = XML( iterator.next() );
				var item:IXMLDataItem = IXMLDataItem( _collection.find( child.name( ) ) );
				
				// Check if the class is mapped
				if ( item )
				{
					var clazz:Object = new item.clazz( );
					Tracer.output( _debug, " Adding " + item.clazz, toString( ) );		
			
					// Map attributes to single properties
					for ( var i:int = 0; i < child.attributes( ).length( ); ++i ) 
					{				
						if ( clazz.hasOwnProperty( child.attributes( )[i].name( ) )) 
						{
							if ( clazz[ String( child.attributes( )[i].name( ) ) ] is Boolean ) 
							{
								clazz[ String( child.attributes( )[i].name( ) ) ] = ( child.attributes( )[i] == "true" || child.attributes( )[i] == "1" );
							}
							else 
							{
								clazz[ String( child.attributes( )[i].name( ) ) ] = child.attributes( )[i];
							}
						}
					}
					 
					// Inject text property
					if ( clazz.hasOwnProperty( "text" ))
						clazz["text"] = child.text( );
					
					// Add the new data instance to mapped parent's collection
					if ( parent.hasOwnProperty( item.parentCollectionProperty ) && !parent[ item.parentCollectionProperty ])
						parent[ item.parentCollectionProperty ] = new Collection( );
	
					if ( parent.hasOwnProperty( item.parentCollectionProperty ) && parent[ item.parentCollectionProperty ] is ICollection )
						parent[ item.parentCollectionProperty ].addElement( clazz );
																	
					var xmlList:XMLListCollection = new XMLListCollection( );
					xmlList.collection = child.children( );
					Tracer.output( _debug, " '" + child.name( ) + "' has " + xmlList.length + " child(ren)", toString( ) );		 
					build( xmlList.iterator( ), clazz );
				}
				else
				{
					Tracer.output( _debug, " No mapping for '" + child.name( ) + "' moving on. Iterator index is " + XMLListIterator( _xmlCollectionIterator ).index( ) + " ", toString( ) );		 
					if ( iterator.hasNext( )) build( _xmlCollectionIterator, parent );
				}
			}
		}
	}
}
