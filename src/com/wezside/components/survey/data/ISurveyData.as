package com.wezside.components.survey.data 
{
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ISurveyData 
	{
		
		function debug():void;
		function get iterator():IIterator;
		function addFormData( formData:IFormData ):void
		function getFormData( id:String ):IFormData
		function getFormGroupData( id:String ):IFormGroupData;
		function purgeData():void;
	}
}
