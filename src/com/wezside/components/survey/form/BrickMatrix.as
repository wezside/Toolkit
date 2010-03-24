package com.wezside.components.survey.form 
{
	import com.wezside.components.container.HBox;
	import com.wezside.components.text.Label;

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
			
			var row:HBox = new HBox();
			var rowLabel:Label = new Label();
			rowLabel.text = item.rowLabel;
			
			row.children = [ rowLabel ];
		}		
	}
}
