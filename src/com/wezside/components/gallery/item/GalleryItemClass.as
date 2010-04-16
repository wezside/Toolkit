package com.wezside.components.gallery.item 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class GalleryItemClass implements IGalleryItemClass 
	{
		private var _id:String;
		private var _clazz:Class;
		private var _fileExtension:Array = [];

		
		public function GalleryItemClass( fileExtension:Array, id:String = "", clazz:Class = null ) 
		{
			_id = id;
			_clazz = clazz;
			_fileExtension = fileExtension;
		}
		

		public function get id():String
		{
			return _id;
		}
		
		public function get clazz():Class
		{
			return _clazz;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function set clazz(value:Class):void
		{
			_clazz = value;
		}
		
		public function get fileExtension():Array
		{
			return _fileExtension;
		}
		
		public function set fileExtension( value:Array ):void
		{
			_fileExtension = value;
		}
	}
}
