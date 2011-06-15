package com.wezside.utilities.factory.business 
{
	import com.wezside.data.parser.IParser;
	import com.wezside.utilities.business.rpc.IService;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ServiceResource implements IServiceResource 
	{
		
		private var _uri:String;
		private var _id:String;
		private var _instance:IService;
		private var _qualifiedName:String;
		private var _type:int;
		private var _operationID:String;
		private var _params:Object;
		private var _method:String;
		private var _requestHeaders:Array;
		private var _asyncToken:Number;
		private var _dormant:Boolean;
		private var _parser:IParser;
		private var _associateID:String;

		
		public function get id():String
		{
			return _id;
		}
		
		public function get uri():String
		{
			return _uri;
		}
		
		public function get qualifiedName():String
		{
			return _qualifiedName;
		}
		
		public function get instance():IService
		{
			return _instance;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function set uri(value:String):void
		{
			_uri = value;
		}
		
		public function set qualifiedName(value:String):void
		{
			_qualifiedName = value;
		}
		
		public function set instance(value:IService):void
		{
			_instance = value;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}
		
		public function get operationID():String
		{
			return _operationID;
		}
		
		public function get params():Object
		{
			return _params;
		}
		
		public function set operationID(value:String):void
		{
			_operationID = value;
		}
		
		public function set params(value:Object):void
		{
			_params = value;
		}
		
		public function get method():String
		{
			return _method;
		}
		
		public function set method(value:String):void
		{
			_method = value;
		}
		
		public function get requestHeaders():Array
		{
			return _requestHeaders;
		}
		
		public function set requestHeaders(value:Array):void
		{
			_requestHeaders = value;
		}
		
		public function get asyncToken():Number
		{
			return _asyncToken;
		}
		
		public function set asyncToken(value:Number):void
		{
			_asyncToken = value;
		}
		
		public function get dormant():Boolean
		{
			return _dormant;
		}
		
		public function set dormant( value:Boolean ):void
		{
			_dormant = value;
		}
		
		public function get parser():IParser
		{
			return _parser;
		}
		
		public function set parser( value:IParser ):void
		{
			_parser = value;
		}

		public function get associateID():String
		{
			return _associateID;
		}

		public function set associateID( value:String ):void
		{
			_associateID = value;
		}
	}
}
