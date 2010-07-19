package com.wezside.components.survey.form 
{
	import com.ogilvy.survey.components.ui.IFormItem;
	import com.ogilvy.survey.data.IFormItemData;
	import com.wezside.components.UIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormItem extends UIElement implements IFormItem 
	{
				
		public static const ITEM_DO_NOT_KNOW:String = "ITEM_DO_NOT_KNOW";
		public static const ITEM_TYPE_STATIC_TEXT:String = "ITEM_TYPE_STATIC_TEXT";
		public static const ITEM_RADIO_BUTTON:String = "ITEM_RADIO_BUTTON";
		public static const ITEM_TEXT_INPUT:String = "ITEM_TEXT_INPUT";
		public static const ITEM_CALL_TO_ACTION:String = "ITEM_CALL_TO_ACTION";		
		
		
		public function FormItem()
		{
		}
		
		public function destroy():void
		{
		}
		
		public function showValid(value:Boolean):void
		{
		}
		
		public function get id():String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get type():String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get value():String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get selected():Boolean
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get data():IFormItemData
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get isValid():Boolean
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function set value(value:String):void
		{
		}
		
		public function set selected(value:Boolean):void
		{
		}
		
		public function set data(value:IFormItemData):void
		{
		}
		
		public function set isValid(value:Boolean):void
		{
		}
	}
}
