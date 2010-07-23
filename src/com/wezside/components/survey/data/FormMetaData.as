package com.wezside.components.survey.data 
{
	import com.wezside.utilities.manager.style.IStyleManager;
	import com.wezside.data.collection.ICollection;
	import com.wezside.utilities.logging.Tracer;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * Refers to any additional content that a Form might have. This can be anything to additional text 
	 * to media assets.  
	 */
	public class FormMetaData implements IFormMetaData 
	{
		
		private var _data:*;
		private var _id:String;
		
		public var label:String;
		private var _styleManager:IStyleManager;
		private var _styleNameCollection:ICollection;

		public function get id():String
		{
			return _id;
		}

		public function get data():*
		{
			return _data;
		}

		public function set id( value:String ):void
		{
			_id = value;
		}

		public function set data( value:* ):void
		{
			_data = value;
		}
		
		public function debug():void
		{
			Tracer.output( true, "\t\tMETA id: " + _id + " | " + " | Styles [" + styleNameCollection + "]", "" );
		}
		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function get styleNameCollection():ICollection
		{
			return _styleNameCollection;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		public function set styleNameCollection( value:ICollection ):void
		{
			_styleNameCollection = value;
		}		
	}
}
