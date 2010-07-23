package com.wezside.components.survey.data 
{
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.style.IStyleManager;

	/**
	 * @author Wesley Swanepoel
	 */
	public interface IFormGroupData
	{
		function get id():String;
		function set id( value:String ):void;

		function get parent():IFormData;
		function set parent( value:IFormData ):void;		

		function get valid():Boolean;
		function set valid( value:Boolean ):void;
		
		function get isInteractive():Boolean;
		function set isInteractive( value:Boolean ):void;
		
		function get styleManager():IStyleManager;
		function set styleManager( value:IStyleManager ):void;

		function get styleNameCollection():ICollection;
		function set styleNameCollection( value:ICollection ):void;	
		
		function get layoutDecorators():ICollection;
		function set layoutDecorators( value:ICollection ):void;
		
		function get formItemNS():Namespace;
		function set formItemNS( value:Namespace ):void;
		
		function get iterator():IIterator;
				
		function debug():void;
		function addItemData( item:IFormItemData ):void;
		function removeItemData( id:String ):IFormItemData;
		function getItemData( id:String ):IFormItemData;
		function getItemDataByIndex( index:uint ):IFormItemData;
		function purge():void;		

	}
}
