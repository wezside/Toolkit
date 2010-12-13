package com.wezside.components.combo 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.control.Button;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;

	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Combo extends UIElement 
	{
		
		private var _selectedStyleName:String;
		private var _dropdownStyleName:String;
		private var _verticalGap:int = 0;
		private var _dropdownWidth:int = 150;
		private var _dropdownHeight:int = 150;
		private var _dataProvider:ICollection = new Collection();
		private var _selected:ComboItem;
		private var _defaultSelectedText:String;
		
		private var dropdownMask:Sprite;
		private var selectedButton:Button;

		public var dropdown:UIElement;
		private var _dropdownPaddingTop:int;
		private var _dropdownPaddingRight:int;
		private var _dropdownPaddingBottom:int;
		private var _dropdownPaddingLeft:int;

		
		public function Combo() 
		{
			// Set the layout for the combo container
			layout = new VerticalLayout( this );
			dropdown = new UIElement();	
		}
		
		override public function build():void 
		{	
			// Create Selected Button
			selectedButton = new Button();
			selectedButton.styleManager = styleManager;
			selectedButton.styleName = _selectedStyleName;
			selectedButton.autoSize = TextFieldAutoSize.LEFT;
			selectedButton.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			selectedButton.activate();
			addChild( selectedButton );		
						
			// Create Dropdown Container			
			dropdown.layout = new PaddedLayout( dropdown );
			dropdown.layout.top = dropdownPaddingLeft;
			dropdown.layout.right = dropdownPaddingRight;
			dropdown.layout.bottom = dropdownPaddingBottom;
			dropdown.layout.left = dropdownPaddingLeft;
			dropdown.layout = new VerticalLayout( dropdown.layout );
			dropdown.layout.verticalGap = _verticalGap;	
			dropdown.scroll = new ScrollVertical( dropdown );
			dropdown.scroll.scrollHeight = _dropdownHeight;
			
			dropdown.styleManager = styleManager;
			dropdown.styleName = _dropdownStyleName;
			dropdown.build();
			dropdown.visible = false;			
			addChild( dropdown );			
			
			var it:IIterator = _dataProvider.iterator();
			var item:ComboItem;
			var buttonItem:Button;
			while ( it.hasNext() )
			{
				item = it.next() as ComboItem;
				
				// Build each button
				buttonItem = new Button();
				buttonItem.id = String( it.index() - 1 );
				buttonItem.width = _dropdownWidth;
				buttonItem.autoSize = TextFieldAutoSize.LEFT;
				buttonItem.styleManager = styleManager;
				buttonItem.styleName = item.styleName;
				buttonItem.text = item.text;
				buttonItem.build();
				buttonItem.setStyle();
				buttonItem.arrange();
				buttonItem.activate();
				buttonItem.addEventListener( UIElementEvent.STATE_CHANGE, itemStateChange );				
				dropdown.addChild( buttonItem );
			}
			it.purge();
			it = null;
			item = null;

			super.build( );			
		}

		override public function setStyle():void 
		{
			selectedButton.setStyle();
			dropdown.setStyle();
			super.setStyle( );
		}
		
		override public function arrange():void 
		{
			selectedButton.arrange();
			dropdown.arrange();
			super.arrange( );
			
			dropdownMask = new Sprite();
			dropdownMask.graphics.beginFill( 0xefefef, 0.5 );
			dropdownMask.graphics.drawRect( layout.left, layout.top, layout.width, dropdownHeight );
			dropdownMask.graphics.endFill();
					
			updateSelected();
		}
		
		public function show():void
		{
			dropdown.visible = true;		
		}
		
		public function hide():void
		{
			dropdown.visible = false;		
		}
		
		public function addItem( item:ComboItem ):void
		{
			item.index = _dataProvider.length;			
			_dataProvider.addElement( item );			
		}

		public function get dataProvider():ICollection
		{
			return _dataProvider;
		}
		
		public function set dataProvider( value:ICollection ):void
		{
			_dataProvider = value;
		}
		
		public function get dropdownHeight():int
		{
			return _dropdownHeight;
		}
		
		public function set dropdownHeight( value:int ):void
		{
			_dropdownHeight = value;
		}
		
		public function get dropdownStyleName():String
		{
			return _dropdownStyleName;
		}
		
		public function set dropdownStyleName( value:String ):void
		{
			_dropdownStyleName = value;
		}
		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		public function set verticalGap( value:int ):void
		{
			_verticalGap = value;
		}

		public function get selected():ComboItem
		{
			return _selected;
		}
		
		public function set selected( value:ComboItem ):void
		{
			_selected = value;
		}
		
		public function get defaultSelectedText():String
		{
			return _defaultSelectedText;
		}
		
		public function set defaultSelectedText( value:String ):void
		{
			_defaultSelectedText = value;
			addItem( new ComboItem( value, _selectedStyleName ));
		}

		public function get selectedStyleName():String
		{
			return _selectedStyleName;
		}
		
		public function set selectedStyleName( value:String ):void
		{
			_selectedStyleName = value;
		}
		
		public function get dropdownPaddingTop():int
		{
			return _dropdownPaddingTop;
		}
		
		public function set dropdownPaddingTop( value:int ):void
		{
			_dropdownPaddingTop = value;
		}
		
		public function get dropdownPaddingRight():int
		{
			return _dropdownPaddingRight;
		}
		
		public function set dropdownPaddingRight( value:int ):void
		{
			_dropdownPaddingRight = value;
		}
		
		public function get dropdownPaddingBottom():int
		{
			return _dropdownPaddingBottom;
		}
		
		public function set dropdownPaddingBottom( value:int ):void
		{
			_dropdownPaddingBottom = value;
		}
		
		public function get dropdownPaddingLeft():int
		{
			return _dropdownPaddingLeft;
		}
		
		public function set dropdownPaddingLeft( value:int ):void
		{
			_dropdownPaddingLeft = value;
		}

		private function stateChange( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK )
			{
				dropdown.visible = !dropdown.visible;
			}
		}		
		
		private function itemStateChange( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK )
			{
				var item:ComboItem = _dataProvider.getElementAt( int( event.currentTarget.id ));
				updateSelected( item );
				hide();
				dispatchEvent( new ComboEvent( ComboEvent.ITEM_SELECTED, 
											   false, 
											   false, 
											   item ));
				
			}
		}		

		private function updateSelected( item:ComboItem = null ):void 
		{				
			selectedButton.width = dropdown.width;
			selectedButton.text = item ? item.text : _defaultSelectedText;
			selectedButton.styleName = _selectedStyleName;
			selectedButton.build();
			selectedButton.setStyle();
			selectedButton.arrange();
			dropdown.y = selectedButton.height;
		}
	}
}
