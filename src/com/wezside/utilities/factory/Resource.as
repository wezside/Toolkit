package com.wezside.utilities.factory
{
	import com.wezside.data.parser.IParser;

	import flash.system.LoaderContext;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Resource implements IResource
	{
		
		public static const XMLFILE:int = 0;
		public static const TXT:int = 1;
		public static const SWF:int = 2;
		public static const IMAGE:int = 3;
		public static const VIDEO:int = 4;
		
		private var _id:String;
		private var _uri:String;
		private var _type:int;		
		private var _data:*;
		private var _bytesTotal:Number;
		private var _bytesLoaded:Number;
		private var _clazz:Class;
		private var _xmlns:Namespace;
		private var _parser:IParser;
		private var _context:LoaderContext;
		
		public function get type():int
		{
			return _type;
		}

		public function get uri():String
		{
			return _uri;
		}

		public function set type( value:int ):void
		{
			_type = value;
		}

		public function set uri( value:String ):void
		{
			_uri = value;
		}

		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}

		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}

		public function set bytesLoaded( value:Number ):void
		{
			_bytesLoaded = value;
		}

		public function set bytesTotal( value:Number ):void
		{
			_bytesTotal = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id( value:String ):void
		{
			_id = value;
		}

		public function get data():*
		{
			return _data;
		}

		public function set data( value:* ):void
		{
			_data = value;			
		}

		public function get xmlns():Namespace
		{
			return _xmlns;
		}

		public function set xmlns( value:Namespace ):void
		{
			_xmlns = value;
		}

		public function get parser():IParser
		{
			return _parser;
		}

		public function set parser( value:IParser ):void
		{
			_parser = value;
		}

		public function get context():LoaderContext
		{
			return _context;
		}

		public function set context( value:LoaderContext ):void
		{
			_context = value;
		}
	}
}
