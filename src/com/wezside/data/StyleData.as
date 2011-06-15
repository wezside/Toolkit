package com.wezside.data
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class StyleData implements IDeserializable
	{
		
		private var _id:String;
		private var _uri:String;
		private var _codes:String;
		private var _namespaces:DictionaryCollection;

		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function get codes():String
		{
			return _codes;
		}
		
		public function set codes( value:String ):void
		{
			_codes = value;
		}		
		
		public function get uri():String
		{
			return _uri;
		}
		
		public function set uri( value:String ):void
		{
			_uri = value;
		}
		
		public function get namespaces():DictionaryCollection
		{
			return _namespaces;
		}
		
		public function set namespaces( value:DictionaryCollection ):void
		{
			_namespaces = value;
		}
		
		public function codeIterator():IIterator
		{
			return new ArrayIterator( _codes.split( "," ));
		}
	}	
}
