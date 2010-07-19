package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ISurveyData 
	{
		function addFormData( id:String, formData:IFormData ):void
		function getFormData( id:String ):IFormData
		function purgeData():void;
	}
}
