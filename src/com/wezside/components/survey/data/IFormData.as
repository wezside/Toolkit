package com.wezside.components.survey.data 
{

	public interface IFormData 
	{
		function get id():String;	
		function set id(value:String):void;		

		function get body():String;		
		function set body(value:String):void;		

		function get cta():String;		
		function set cta(value:String):void;		

		function get heading():String;		
		function set heading(value:String):void;	
		
		function get subheading():String;		
		function set subheading(value:String):void;		

		function get isValid():Boolean;
		function set isValid( value:Boolean ):void;		

		function addGroupData( id:String, group:IFormGroupData ):void;
		function purgeData():void;
	}
}
