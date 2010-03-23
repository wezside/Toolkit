package com.wezside.components.survey.form
{
	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IFormItemSkin 
	{
		
		function get up():DisplayObject;
		function set up( value:DisplayObject ):void;		
		
		function get over():DisplayObject;
		function set over( value:DisplayObject ):void;		
		
		function get down():DisplayObject;
		function set down( value:DisplayObject ):void;		
		
		function get upSelected():DisplayObject;
		function set upSelected( value:DisplayObject ):void;		
		
		function get overSelected():DisplayObject;
		function set overSelected( value:DisplayObject ):void;		
		
		function get downSelected():DisplayObject;
		function set downSelected( value:DisplayObject ):void;		
		
		function get iconUp():DisplayObject;
		function set iconUp( value:DisplayObject ):void;		
		
		function get iconOver():DisplayObject;
		function set iconOver( value:DisplayObject ):void;		
		
		function get iconDown():DisplayObject;
		function set iconDown( value:DisplayObject ):void;		
		
	}
}
