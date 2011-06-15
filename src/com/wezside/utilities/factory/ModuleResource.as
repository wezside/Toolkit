package com.wezside.utilities.factory
{
	
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ModuleResource implements IModuleResource
	{
		
		private var _uri:String;
		private var _id:String;
		private var _qualifiedName:String;
		private var _instance:IModule;
		private var _dataID:String;
		private var _serviceID:String;
		
		
		public function get uri():String
		{
			return _uri;
		}
		
		public function set uri( value:String ):void
		{
			_uri = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}

		public function get qualifiedName():String
		{
			return _qualifiedName;
		}

		public function set qualifiedName( value:String ):void
		{
			_qualifiedName = value;
		}

		public function get instance():IModule
		{
			return _instance;
		}

		public function set instance( value:IModule ):void
		{
			_instance = value;
		}

		public function get dataID():String
		{
			return _dataID;
		}

		public function set dataID( value:String ):void
		{
			_dataID = value;
		}

		public function get serviceID():String
		{
			return _serviceID;
		}

		public function set serviceID( value:String ):void
		{
			_serviceID = value;
		}
	}
}
