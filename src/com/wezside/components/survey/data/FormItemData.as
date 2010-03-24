package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormItemData implements IFormItemData 
	{


		private var _id:String;
		private var _label:String;
		private var _type:String;

		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			_label = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			value = _type;
		}
	}
}
