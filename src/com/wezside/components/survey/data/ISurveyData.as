package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ISurveyData 
	{
		function get forms():Array;
		function set forms( value:Array ):void;		

		function clone():ISurveyData;

	}
}
