package com.wezside.components.survey.data 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormGroupData implements IFormGroupData 
	{
		
		private var items:ICollection = new Collection( );
		private var _id:String;

		public function addItemData( id:String, item:IFormItemData ):void
		{
		}
		
		public function removeItemData( id:String ):IFormItemData
		{
			return null;
		}
		
		public function getItemData( id:String ):IFormItemData
		{
			return null;
		}
		
		public function getItemDataByIndex( index:uint ):IFormItemData
		{
			return null;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get isValid():Boolean
		{
			return null;
		}
		
		public function get isInteractive():Boolean
		{
			return null;
		}
		
		public function set id(value:String):void
		{
		}
		
		public function set isValid(value:Boolean):void
		{
		}
		
		public function set isInteractive(value:Boolean):void
		{
		}
		
		public function purgeData():void
		{
		}
	}
}
