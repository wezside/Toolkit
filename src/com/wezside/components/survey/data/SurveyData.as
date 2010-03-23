package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyData implements ISurveyData 
	{

		private var _forms:Array = [];

		public function get forms():Array
		{
			return _forms;
		}
		
		public function set forms( value:Array ):void
		{
			_forms = value;
		}
		
		public function clone():ISurveyData
		{
			var data:ISurveyData = new SurveyData();
			data.forms = data.forms.concat( _forms ); 
			return data;
		}
	}
}
