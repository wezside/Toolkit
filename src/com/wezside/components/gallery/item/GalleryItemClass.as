package com.wezside.components.gallery.item 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class GalleryItemClass implements IGalleryItemClass 
	{
		private var _id:String;
		private var _clazz:Class;
		private var _fileExtension:ICollection;
		private var _data:*;

		
		public function GalleryItemClass( fileExtension:Array, id:String = "", clazz:Class = null, data:* = null ) 
		{
			_id = id;
			_clazz = clazz;
			_fileExtension = new Collection( fileExtension );
			_data = data;
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
		
		public function get fileExtension():ICollection
		{
			return _fileExtension;
		}
		
		public function set fileExtension( value:ICollection ):void
		{
			_fileExtension = value;
		}
		
		public function get data():*
		{
			return _data;
		}
		
		public function set data( value:* ):void
		{
			_data = value;
		}
	}
}
