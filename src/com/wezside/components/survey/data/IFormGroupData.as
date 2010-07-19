package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley Swanepoel
	 */
	public interface IFormGroupData
	{
		function get id():String;
		function set id( value:String ):void;
		
		function addItemData( id:String, item:IFormItemData ):void;
		function removeItemData( id:String ):IFormItemData;

		function getItemData( id:String ):IFormItemData;
		function getItemDataByIndex( index:uint ):IFormItemData;

		function get isValid():Boolean;
		function set isValid( value:Boolean ):void;
		
		function get isInteractive():Boolean;
		function set isInteractive( value:Boolean ):void;
		
		function purgeData():void;		

	}
}
