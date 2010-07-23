package com.wezside.components.survey.data 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.manager.style.IStyleManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormGroupData implements IFormGroupData 
	{
		
		private var _items:Collection = new Collection();
		private var _id:String;
		private var _parent:IFormData;
		private var _valid:Boolean;
		private var _isInteractive:Boolean;
		private var _styleManager:IStyleManager;
		private var _styleNameCollection:ICollection;
		private var _formItemsNS:Namespace = new Namespace( "", "com.wezside.components.survey.form.item" );
		private var _layoutDecorators:ICollection;

		public function addItemData( item:IFormItemData ):void
		{
			_items.addElement( item );
		}
		
		public function removeItemData( id:String ):IFormItemData
		{
			return null;
		}
		
		public function getItemData( id:String ):IFormItemData
		{
			return _items.find( id ) as IFormItemData;
		}
		
		public function getItemDataByIndex( index:uint ):IFormItemData
		{
			return null;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get valid():Boolean
		{
			return _valid;
		}
		
		public function get isInteractive():Boolean
		{
			return _isInteractive;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function set valid( value:Boolean ):void
		{
			_valid = value;
		}
		
		public function set isInteractive( value:Boolean ):void
		{
			_isInteractive = value;
		}
		
		public function get parent():IFormData
		{
			return _parent;
		}
		
		public function set parent(value:IFormData):void
		{
			_parent = value;
		}
		
		public function debug():void
		{
			Tracer.output( true, "\t\tGROUP : " + _id + " | Styles [" + styleNameCollection + "]", "" );
			var iterator:IIterator = _items.iterator();
			while ( iterator.hasNext())
			{
				var formData:IFormItemData = iterator.next() as IFormItemData;
				formData.debug();
			}		
			iterator.purge();			
		}
		
		public function purge():void
		{
		}
		
		public function get iterator():IIterator
		{
			return _items.iterator( );
		}
		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function get styleNameCollection():ICollection
		{
			return _styleNameCollection;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		public function set styleNameCollection( value:ICollection ):void
		{
			_styleNameCollection = value;
		}
		
		public function get formItemNS():Namespace
		{
			return _formItemsNS;
		}
		
		public function set formItemNS( value:Namespace ):void
		{
			_formItemsNS = value;
		}
		
		public function get layoutDecorators():ICollection
		{
			return _layoutDecorators;
		}
		
		public function set layoutDecorators(value:ICollection):void
		{
			_layoutDecorators = value;
		}
	}
}
