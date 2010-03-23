package com.wezside.components.survey.form 
{
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BrickMatrix extends Sprite implements IFormLayout 
	{
		
		
		private static const VERTICAL:String = "verticalLayout";
		private static const HORIZONTAL:String = "horizontalLayout";


		private var _rowLayout:String;

		
		
		public function BrickMatrix() 
		{
			_rowLayout = HORIZONTAL;	
		}		

		public function addItem( item:IFormItem ):void
		{
		}
		
		public function arrange():void
		{
		}
		
		public function get rowLayout():String
		{
			return _rowLayout;
		}
		
		public function set rowLayout( value:String ):void
		{
			_rowLayout = value;
		}
	}
}
