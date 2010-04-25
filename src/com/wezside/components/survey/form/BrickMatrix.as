package com.wezside.components.survey.form 
{
	import com.wezside.components.text.Label;

	import mx.containers.Box;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BrickMatrix extends Sprite implements IFormLayout 
	{
		
		
		public static const VERTICAL:String = "verticalLayout";
		public static const HORIZONTAL:String = "horizontalLayout";


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
		
		private function createFormRow( item:IFormItem ):void 
		{
			
			var row:Box = new Box();
			var rowLabel:Label = new Label();
			rowLabel.text = item.rowLabel;
			
			row.addChild( rowLabel );
		}		
	}
}
