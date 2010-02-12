package com.wezside.components.accordion 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.1.0004
	 */
	[Event( name="headerClicked", type="com.wezside.components.accordion.AccordionEvent" )]
	public class Accordion extends Sprite 
	{

		private var _verticalGap:Number;
		private var _selectedIndex:int;
		private var _autoCollapse:Boolean;
		private var _lastIndex:int;

		protected var yOffset:Number;

		
		public function Accordion()
		{
			yOffset = 0;
			_verticalGap = 0;
			_selectedIndex = 0;
			_autoCollapse = true;
		}

		public function addItem( item:IAccordionItem ):void
		{
			item.y += yOffset;
			item.name = this.numChildren.toString( );
			item.addEventListener( AccordionEvent.HEADER_CLICK, sliderItemClicked );	
			addChild( DisplayObject( item ) );
			yOffset += item.height + _verticalGap;
		}

		/**
		 * This method arranges all the items based on their height property. It is called after the selected item's 
		 * flag was set which will mean any reference to the item's height property will produce the 
		 * header + content height. If the selected flag is false the property will return the header height only. 
		 */
		public function arrange():void
		{
			var ypos:Number = 0;
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var item:DisplayObject = getChildAt( i ) as DisplayObject;
				item.y = ypos;
				ypos += item.height + _verticalGap;
			}
		}

		public function reset( ignoreIndex:int = -1 ):void
		{
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var item:IAccordionItem = getChildAt( i ) as IAccordionItem;
				if ( item && ignoreIndex >= 0 && i != ignoreIndex ) item.selected = false;
			}
		}

		public function getSelectedItem():IAccordionItem
		{
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var item:IAccordionItem = getChildAt( i ) as IAccordionItem;
				if ( item.selected ) return item;
			}
			return null;
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		[Bindable(event="updateSelectedIndex")]
		public function set selectedIndex( value:int ):void
		{
			_selectedIndex = value;
			if ( _autoCollapse ) reset( value );			
			IAccordionItem( getChildAt( _selectedIndex )).selected = true;
		}		

		public function get verticalGap():Number
		{
			return _verticalGap;
		}

		public function set verticalGap( value:Number ):void
		{
			_verticalGap = value;
		}

		/**
		 * Determines if the reset() method is called before setting the selected item. This will allow
		 * multiple content areas to be open at the same time. Set this flag to false if only one content
		 * area should only ever display. 
		 */
		public function get autoCollapse():Boolean
		{
			return _autoCollapse;
		}

		public function set autoCollapse( value:Boolean ):void
		{
			_autoCollapse = value;
		}

		protected function sliderItemClicked( event:AccordionEvent ):void 
		{
			_lastIndex = _selectedIndex;			
			selectedIndex = event.selectedItem;
			arrange();
		}

	}
}
