package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormData implements IFormData 
	{


		private var _heading:String;
		private var _body:String;
		private var _submit:String;
		private var _cta:String;
		private var _subheading:String;
		private var _items:Array = [];

		
		public function get heading():String
		{
			return _heading;
		}

		public function get body():String
		{
			return _body;
		}

		public function get submit():String
		{
			return _submit;
		}

		public function get cta():String
		{
			return _cta;
		}

		public function set heading( value:String ):void
		{
			_heading = value;
		}

		public function set body( value:String ):void
		{
			_body = value;
		}

		public function set submit( value:String ):void
		{
			_submit = value;
		}

		public function set cta( value:String ):void
		{
			_cta = value;
		}
		
		public function get subheading():String
		{
			return _subheading;
		}
		
		public function set subheading( value:String ):void
		{
			_subheading = value;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function set items(value:Array):void
		{
			_items = value;
		}
	}
}
