package com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataItem implements IXMLDataItem 
	{
		
		private var _clazz:Class;
		private var _nodeName:String;
		private var _parentCollectionProperty:String;
		

		public function get clazz():Class
		{
			return _clazz;
		}
		
		public function get nodeName():String
		{
			return _nodeName;
		}
		
		public function get parentCollectionProperty():String
		{
			return _parentCollectionProperty;
		}
		
		public function set clazz(value:Class):void
		{
			_clazz = value;
		}
		
		public function set nodeName(value:String):void
		{
			_nodeName = value;
		}
		
		public function set parentCollectionProperty(value:String):void
		{
			_parentCollectionProperty = value;
		}
	}
}
