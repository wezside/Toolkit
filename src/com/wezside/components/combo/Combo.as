package com.wezside.components.combo 
{
	import flash.text.TextFieldAutoSize;
	import com.wezside.components.decorators.shape.IShape;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.control.Button;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;

	import flash.display.Sprite;

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
		private var _dropdownBackground:IShape;
		private var _dataProvider:ICollection = new Collection();
		private var _selected:ComboItem;
		private var _defaultSelectedText:String;
		
		private var dropdownMask:Sprite;
		private var dropdown:UIElement;
		private var selectedButton:Button;

		
		override public function build():void 
		{		
			
			// Set the layout for the combo container
			layout = new VerticalLayout( this );
			
			// Create Selected Button
			selectedButton = new Button();
			selectedButton.styleManager = styleManager;
			selectedButton.autoSize = TextFieldAutoSize.LEFT;
			selectedButton.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			selectedButton.build();
			selectedButton.activate();
			addChild( selectedButton );		
			updateSelected();
			
			// Create Dropdown Container
			dropdown = new UIElement();
			dropdown.background = _dropdownBackground;
			dropdown.layout = new VerticalLayout( dropdown );
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

		public function get dropdownBackground():IShape
		{
			return _dropdownBackground;
		}
		
		public function set dropdownBackground( value:IShape ):void
		{
			_dropdownBackground = value;
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
				
				dispatchEvent( new ComboEvent( ComboEvent.ITEM_SELECTED, 
											   false, 
											   false, 
											   item ));
			}
		}		

		private function updateSelected( item:ComboItem = null ):void 
		{						
			selectedButton.text = item ? item.text : _defaultSelectedText;
			selectedButton.styleName = _selectedStyleName;
			selectedButton.setStyle();
			selectedButton.arrange();
		}
	}
}
