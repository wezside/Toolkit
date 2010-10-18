package com.wezside.components.control 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.Layout;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.RelativeLayout;
	import com.wezside.components.text.Label;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Button extends Label 
	{

		private var _id:String;
		private var _icon:UIElement;
		private var _autoSkinSize:Boolean;
		private var _iconPlacement:String = Layout.PLACEMENT_CENTER;

		public function Button()
		{
			super( );			
			layout = new PaddedLayout( this );			
			_autoSkinSize = true;
			_icon = new Icon();
			_icon.layout = new PaddedLayout( _icon );
			addChild( _icon );
		}

		override public function build():void 
		{
			super.build( );
			_icon.build();
			_icon.setStyle();			
		}

		override public function arrange():void 
		{							
			// Apply icon layout decorators
			_icon.arrange();
			
			// Set the 9-grid placement to use
			layout = new RelativeLayout( this.layout );
			layout.placement = _iconPlacement;
			RelativeLayout( layout ).anchor = field;
			RelativeLayout( layout ).target = _icon;
						
			// Arrange the Label component to adjust the text field width and height based on the text
			super.arrange();	
			
			if ( _autoSkinSize )
			{
				skin.setSize( layout.width > 0 ? layout.width : width, layout.height > 0 ? layout.height : height );
			}
		}
		
		override public function set state( value:String ):void 
		{
			super.state = value;
			_icon.state = value;
		}
		
		override public function set debug(value:Boolean):void 
		{
			super.debug = value;
			_icon.debug = value;
		}

		public function get icon():UIElement
		{
			return _icon;
		}
		
		public function set icon( value:UIElement ):void
		{
			_icon = value;
		}
		
		public function get iconStyleName():String
		{
			return _icon.styleName;
		}
		
		public function set iconStyleName( value:String ):void
		{
			_icon.styleName = value;
			_icon.styleManager = styleManager;
		}
		
		public function set iconPlacement( value:String ):void
		{
			_iconPlacement = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function get autoSkinSize():Boolean
		{
			return _autoSkinSize;
		}
		
		public function set autoSkinSize( value:Boolean ):void
		{
			_autoSkinSize = value;
		}
	}
}

