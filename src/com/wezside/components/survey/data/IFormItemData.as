package com.wezside.components.survey.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormItemData 
	{
		function get id():String;
		function set id( value:String ):void;	
		
		function get type():String;
		function set type( value:String ):void;	
		
		function get value():String;
		function set value( value:String ):void;	
		
		function get label():String
		function set label( value:String ):void
		
		function get sublabel():String
		function set sublabel( value:String ):void
		
		function get styleName():String;
		function set styleName( value:String ):void;
		
		function get iconStyleName():String;
		function set iconStyleName( value:String ):void;

		function get selectedState() : Boolean;
		function set selectedState( value : Boolean ):void;		
		
		function get isValid() : Boolean;
		function set isValid( value : Boolean ):void;	

		function get state():String;
		function set state( value:String ):void;

		function purgeData() : void 
	}
}
