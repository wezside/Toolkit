package com.wezside.components.container 
{
	import com.wezside.components.button.Button;
	import com.wezside.utilities.logging.Tracer;

	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.1.0
	 * 
	 * TODO: Add flat colour as default with alternating colours for items.
	 * 
	 * FIXME: Problems binding to a listbox width + height props
	 * FIXME: Currently the ModuleEvent.CREATION_COMPLETE is not dispatched when no MXML children are declared. 
	 * 		  This should not be the case as some components use dataproviders to automate population.
	 * 		  Is this necessary?  		  
	 * 		  
	 * FIXME: Currently there is no CSS integration for buttons - as they are created through composition - need testing? 	
	 */
	public class ListBox extends VBox	 
	{


		private var _dataprovider:Array;
		private var items:Array;
		private var _labelPaddingLeft:int;
		private var _labelPaddingRight:int;
		private var _labelPaddingTop:int;
		private var _labelPaddingBottom:int;
		private var _selectedIndex:int;
		private var _itemWidth:int = 0;
		private var _itemHeight:int = 0;
		private var _font:String;
		private var _fontSize:int;
		private var _embedFonts:Boolean;

		
		
		public function ListBox()
		{
			super( );
			items = [];
			_itemWidth = 0;
			_itemHeight = 0;
			_labelPaddingTop = 0;
			_labelPaddingLeft = 0;
			_labelPaddingRight = 0;
			_labelPaddingBottom = 0;
		}
		

		public function get dataprovider():Array
		{
			return _dataprovider;
		}
	
		public function set dataprovider( value:Array ):void
		{
			Tracer.output( true, " ListBox.dataprovider(value)", toString() );
			_dataprovider = value;
			create();
		}
				
		public function get itemWidth():int
		{
			return _itemWidth;
		}
		
		public function set itemWidth( value:int ):void
		{
			_itemWidth = value;
		}
		
		public function get itemHeight():int
		{
			return _itemHeight;
		}
		
		public function set itemHeight( value:int ):void
		{
			_itemHeight = value;
		}
				
		public function get labelPaddingLeft():int
		{
			return _labelPaddingLeft;
		}
		
		public function set labelPaddingLeft( value:int ):void
		{
			_labelPaddingLeft = value;
		}				
		
		public function get labelPaddingRight():int
		{
			return _labelPaddingRight;
		}
		
		public function set labelPaddingRight( value:int ):void
		{
			_labelPaddingRight = value;
		}
		
		public function get labelPaddingTop():int
		{
			return _labelPaddingTop;
		}
		
		public function set labelPaddingTop( value:int ):void
		{
			_labelPaddingTop = value;
		}
		
		public function get labelPaddingBottom():int
		{
			return _labelPaddingBottom;
		}
		
		public function set labelPaddingBottom( value:int ):void
		{
			_labelPaddingBottom = value;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex( value:int ):void
		{
			_selectedIndex = value;
			Button( items[value] ).selected = true;
		}
		
		public function get font():String
		{
			return _font;
		}
		
		public function set font( value:String ):void
		{
			_font = value;
		}		
		
		public function get fontSize():int
		{
			return _fontSize;
		}
		
		public function set fontSize( value:int ):void
		{
			_fontSize = value;
		}
		
		public function get embedFonts():Boolean
		{
			return _embedFonts;
		}
		
		public function set embedFonts( value:Boolean ):void
		{
			_embedFonts = value;
		}
		
		/**
		 * Setting the super constructor children to add the dataprovider children will invoke the 
		 * ModuleEvent.CREATION_COMPLETE wihch in turn invokes the arrange method. 
		 * 
		 * FIXME: Find a way to resize the button width to maxWidth or container width.
		 */
		private function create():void
		{
			items = [];
			var maxWidth:int = 0;
			var maxHeight:int = 0;
			
			for ( var i:int = 0; i < _dataprovider.length; ++i ) 
			{
				var bt:Button = new Button();
				bt.font = _font;
				bt.text = _dataprovider[i].label;
				bt.useHandCursor = false;
				bt.align = TextFormatAlign.LEFT;
				bt.paddingLeft = _labelPaddingLeft;
				bt.paddingRight = _labelPaddingRight;
				bt.paddingTop = _labelPaddingTop;
				bt.paddingBottom = _labelPaddingBottom;
				bt.size = _fontSize;
				bt.embedFonts = _embedFonts;
				bt.addEventListener( MouseEvent.CLICK, click );
				
				maxWidth = bt.width > maxWidth ? bt.width : maxWidth;				
				maxHeight = bt.height > maxHeight ? bt.height : maxHeight;				
				items.push( bt );
			}
			
			if ( _itemWidth != 0 ) maxWidth = _itemWidth;
			if ( _itemHeight != 0 ) maxHeight = _itemHeight;
			
			for ( var k:int = 0; k < items.length; ++k ) 
			{
				Button( items[k] ).width = maxWidth;
				Button( items[k] ).height = maxHeight;
				Button( items[k] ).update();
			}
			
			children = items;
		}
		
		
		private function click( event:MouseEvent ):void
		{
			for ( var k:int = 0; k < items.length; ++k ) 
				Button( items[k] ).resetState();	
				
			Button( event.currentTarget ).selected = true;
		}	
		
	}
}
