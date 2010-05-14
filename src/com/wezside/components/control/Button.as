package com.wezside.components.control 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementState;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.text.Label;

	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Button extends UIElement 
	{
		
		
		private var _label:Label;

		public function Button()
		{
			super( );
			_label = new Label();
			addChild( _label );			
		}

		override public function build():void 
		{
			super.build( );
			if ( text )
			{				
				_label.layout = new PaddedLayout( _label );
				_label.build();
				if ( _label.styleManager ) _label.setStyle();
				_label.arrange();
					
			}			
		}
		
		override public function arrange():void 
		{		
			var skinWidth:int = int( _label.width + layout.left + layout.right );
			var skinHeight:int = int( _label.height + layout.top + layout.bottom );
			skin.setSize( skinWidth, skinHeight );
			super.arrange( );				
		}

		public function activate():void
		{
			state = UIElementState.STATE_VISUAL_UP;
			buttonMode = true;
			_label.activate();
			addEventListener( MouseEvent.ROLL_OVER, rollOver );
			addEventListener( MouseEvent.ROLL_OUT, rollOut );
			addEventListener( MouseEvent.MOUSE_DOWN, down );
			addEventListener( MouseEvent.MOUSE_UP, mouseUp  );		
		}
		
		public function deactivate():void
		{
			state = null;
			buttonMode = false;
			removeEventListener( MouseEvent.ROLL_OVER, rollOver );
			removeEventListener( MouseEvent.ROLL_OUT, rollOut );
			removeEventListener( MouseEvent.MOUSE_DOWN, down );
			removeEventListener( MouseEvent.MOUSE_UP, mouseUp  );		
		}

		public function get labelStyleName():String
		{
			return _label.styleName;
		}
		
		public function set labelStyleName( value:String ):void
		{
			_label.styleName = value;
			_label.styleManager = styleManager;
		}

		public function get text():String
		{
			return _label.text;
		}
		
		public function set text( value:String ):void
		{
			_label.text = value;
			_label.buttonMode = true;
			_label.activate();
		}

		public function get paddingLeft():int
		{
			return layout.left;
		}
		
		public function set paddingLeft( value:int ):void
		{
			trace( value );
			layout.left = value;
		}
		
		public function get labelWidth():int
		{
			return _label.width;
		}
		
		public function set labelWidth( value:int ):void
		{
			_label.width = value;
		}
		
		public function get labelHeight():int
		{
			return _label.height;
		}
		
		public function set labelHeight( value:int ):void
		{
			_label.height = value;
		}

		private function mouseUp( event:MouseEvent ):void 
		{
			state = UIElementState.STATE_VISUAL_UP;
		}

		private function rollOut( event:MouseEvent ):void 
		{
 			state = UIElementState.STATE_VISUAL_UP;
		}

		private function rollOver( event:MouseEvent ):void 
		{
			state = UIElementState.STATE_VISUAL_OVER;
		}

		private function click( event:MouseEvent ):void 
		{
			state = UIElementState.STATE_VISUAL_SELECTED;
		}

		private function down( event:MouseEvent ):void 
		{
			state = UIElementState.STATE_VISUAL_DOWN;
		}				
	}
}
