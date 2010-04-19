package com.wezside.components.button 
{
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.text.Label;

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * TODO: Add icon layout
	 * TODO: Allow for setting MLabel properties through this component in MXML like font
	 * TODO: Integrate CSS support
	 * 
	 * Note: text is the only property which calls update. Thus any other custom props need to be set before text
	 */
	[Event( name="click", type="flash.events.MouseEvent" )]
	[Event( name="rollOut", type="flash.events.MouseEvent" )]
	[Event( name="rollOver", type="flash.events.MouseEvent" )]
	[Event( name="mouseDown", type="flash.events.MouseEvent" )]
	public class Button extends Label 
	{
		
		
		private var _upState:Sprite;
		private var _downState:Sprite;
		private var _overState:Sprite;
		private var _selectedState:Sprite;
		private var _disabledState:Sprite;
		
		private var _width:Number;
		private var _height:Number;
		private var _cornerRadius:Number;
		private var _selected:Boolean;
		private var _defaultStates:Boolean;
		private var _align:String;

		private var matrix:Matrix;
		private var _upStateProps:Object;
		private var _overStateProps:Object;
		private var _downStateProps:Object;
		private var _selectedStateProps:Object;
		private var _iconUp:Sprite;
		private var _iconOver:Sprite;
		private var _iconDown:Sprite;
		private var _iconDisabled:Sprite;
		private var _iconSelected:Sprite;

		
		public function Button()
		{
			super();
			_width = 130;
			_height = 25;
			_selected = false;
			_defaultStates = true;
			_cornerRadius = 0;
			
			_upState = new Sprite();
			_overState = new Sprite();
			_downState = new Sprite();
			_selectedState = new Sprite();			
			
			_upStateProps = {};
			_upStateProps.colors = [ 0xE6E6E6, 0x959595 ];
			_upStateProps.alphas = [ 1,1 ];
			_upStateProps.ratios = [ 0,255 ];
		
			_overStateProps = {};
			_overStateProps.colors = [ 0xffffff, 0xB3B3B3 ];
			_overStateProps.alphas = [ 1, 1 ];
			_overStateProps.ratios = [ 0, 255 ];
			
			_downStateProps = {};
			_downStateProps.colors = [ 0x666666, 0xCCCCCC ];
			_downStateProps.alphas = [ 1, 1 ];
			_downStateProps.ratios = [ 0, 255 ];
			
			_selectedStateProps = {};			
			_selectedStateProps.colors = [ 0xE6E6E6, 0xffffff ];
			_selectedStateProps.alphas = [ 1, 1 ];
			_selectedStateProps.ratios = [ 0, 255 ];
			
			_align = TextFormatAlign.CENTER;
			
			mouseChildren = false;
			mouseEnabled = true;
			
			field.selectable = false;
			field.autoSize = TextFieldAutoSize.LEFT;
			
			addlisteners();		
			addEventListener( UIElementEvent.CREATION_COMPLETE, arrange );
		}
		
		
		override public function update():void
		{
			super.update();
			arrange();
		}

		override public function get width():Number
		{
			return _defaultStates ? _width : _upState.width;
		}

		override public function set width( value:Number ):void
		{
			_width = value;
		}		
		
		override public function get height():Number
		{
			return _defaultStates ? _height : _upState.height;
		}

		[Bindable("changeHeight")]
		override public function set height( value:Number ):void
		{
			_height = value;
		}
		
		public function get upState():Sprite
		{
			return _upState;
		}
		
		public function set upState( value:Sprite ):void
		{
			if ( contains( _upState )) removeChild( _upState );			
			_upState.graphics.clear();
			_upState = value;
		}
		
		
		public function get downState():Sprite
		{
			return _downState;
		}
		
		public function set downState( value:Sprite ):void
		{
			if ( contains( _downState )) removeChild( _downState );
			_downState.graphics.clear();
			_downState = value;
		}
		
		
		public function get overState():Sprite
		{
			return _overState;
		}
		
		public function set overState( value:Sprite ):void
		{
			if ( contains( _overState )) removeChild( _overState );
			_overState.graphics.clear();			
			_overState = value;
		}
		
		
		public function get selectedState():Sprite
		{
			return _selectedState;
		}
		
		
		public function set selectedState( value:Sprite ):void
		{
			if ( contains( _selectedState )) removeChild( _selectedState );			
			_selectedState.graphics.clear();				
			_selectedState = value;
		}
		
		
		public function get disabledState():Sprite
		{
			return _disabledState;
		}
		
		
		public function set disabledState( value:Sprite ):void
		{
			_disabledState.graphics.clear();				
			_disabledState = value;
		}
		
		
		public function get iconUp():Sprite
		{
			return _iconUp;
		}
		
		
		public function set iconUp( value:Sprite ):void
		{
			_iconUp = value;
		}
		
		public function get iconOver():Sprite
		{
			return _iconOver;
		}
		
		
		public function set iconOver( value:Sprite ):void
		{
			_iconOver = value;
		}
		
		public function get iconDown():Sprite
		{
			return _iconDown;
		}
		
		public function set iconDown( value:Sprite ):void
		{
			_iconDown = value;
		}
		
		public function get iconDisabled():Sprite
		{
			return _iconDisabled;
		}
		
		public function set iconDisabled( value:Sprite ):void
		{
			_iconDisabled = value;
		}
		
		public function get iconSelected():Sprite
		{
			return _iconSelected;
		}
		
		public function set iconSelected( value:Sprite ):void
		{
			_iconSelected = value;
		}
		
		
		override public function get useHandCursor():Boolean
		{
			return this.useHandCursor;
		}
		
		
		override public function set useHandCursor( value:Boolean ):void
		{
			super.useHandCursor = value;
			toggleMouseInteraction( upState );
			toggleMouseInteraction( overState );
			toggleMouseInteraction( downState );
		}
		
		
		public function get cornerRadius():Number
		{
			return _cornerRadius;
		}
		
		
		public function set cornerRadius( value:Number ):void
		{
			_cornerRadius = value;
		}		
		
		
		public function get defaultStates():Boolean
		{
			return _defaultStates;
		}
		
		
		public function set defaultStates( value:Boolean ):void
		{
			_defaultStates = value;
		}
		
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		
		public function set selected( value:Boolean ):void
		{
			_selected = value;
			_selected ? setState( _selectedState ) : setState( _upState );			
		}
		
		
		public function get align():String
		{
			return _align;
		}
		
		public function set align( value:String ):void
		{
			_align = value;
		}
		
		
		override public function get font():String
		{
			return super.font;
		}
		
		override public function set font( value:String ):void
		{
			super.font = value;
		}
		
		
		public function resetState():void
		{
			_upState.visible = false;
			_overState.visible = false;
			_downState.visible = false;
			_selectedState.visible = false;		
		}
	
		
		/**
		 * TODO: Add LEFT, CENTRE and RIGHT align for button label  
		 */
		protected function arrange( event:UIElementEvent = null ):void
		{
			if ( _iconUp != null )
			{
				// Arrange icon + text layout here
				// TODO: Check largest item width
				paddingLeft += _iconUp.width;
				_upState.addChild( _iconUp );
				_overState.addChild( _iconOver );
				_downState.addChild( _iconDown );
				_disabledState.addChild( _iconDisabled );
				_selectedState.addChild( _iconSelected );
			}
			
			if ( field.textWidth > _width ) _width = field.textWidth;
			
			switch ( _align )
			{
				case TextFormatAlign.CENTER: field.x = int(( _width - field.textWidth ) * 0.5 + paddingLeft); break;
				case TextFormatAlign.LEFT: field.x = int( paddingLeft ); break;
				case TextFormatAlign.RIGHT: field.x = int( _width - field.textWidth ); break;									
			}
			
			_width += paddingLeft + paddingRight;
			field.y = int(( _height - field.textHeight ) * 0.5 );
			draw();
		}

		
		protected function draw():void
		{	
			if ( _defaultStates )
			{
				_upState.name = "up";
				_overState.name = "over";
				_downState.name = "down";
				_selectedState.name = "selected";
				
				if ( contains( _upState )) removeChild( _upState );
				if ( contains( _overState )) removeChild( _overState );
				if ( contains( _downState )) removeChild( _downState );
				if ( contains( _selectedState )) removeChild( _selectedState );
					
				createBase( _upState, _upStateProps );
				createBase( _overState, _overStateProps );
				createBase( _downState, _downStateProps );
				createBase( _selectedState, _selectedStateProps );

			}
			else if ( _upState != null )
			{
				addChild( _upState );
				addChild( _overState );
				addChild( _downState );
				addChild( _selectedState );
				setState( _upState );
			}
		}
		
		
		private function rollOut( event:MouseEvent ):void
		{
			if ( !_selected ) setState( _upState );
		}


		private function rollOver( event:MouseEvent ):void
		{
			if ( !_selected ) setState(_overState  );
		}

		
		private function mouseDown( event:MouseEvent ):void
		{
			setState( _downState );
		}

		
		private function click( event:MouseEvent ):void
		{
			setState( _upState );
		}

		
		private function setState( state:Sprite ):void
		{
			resetState();
			state.visible = true;
		}

		
		private function addlisteners():void
		{
			addEventListener( MouseEvent.ROLL_OUT, rollOut );
			addEventListener( MouseEvent.ROLL_OVER, rollOver );		
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDown );
			addEventListener( MouseEvent.MOUSE_UP, click );
		}
		
		
		private function removelisteners():void
		{
			removeEventListener( MouseEvent.ROLL_OUT, rollOut );
			removeEventListener( MouseEvent.ROLL_OVER, rollOver );		
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, click );
		}


		private function toggleMouseInteraction( state:Sprite ):void
		{
			state.useHandCursor = !state.useHandCursor;
		}

		
		private function createBase( state:Sprite, props:Object ):void
		{
			matrix = new Matrix();
			matrix.createGradientBox( _width, _height, 90 / 180 * Math.PI );
						
			state.graphics.clear();			
			state.graphics.beginGradientFill( GradientType.LINEAR, props.colors, props.alphas, props.ratios, matrix );
			state.graphics.drawRoundRect(0, 0, _width, _height, _cornerRadius );
			state.graphics.lineStyle( 1, 0xffffff );
			state.graphics.moveTo( 0, 0 );
			state.graphics.lineTo( _width, 0 );
			state.graphics.moveTo( 0, 0 );
			state.graphics.lineTo( 0, _height );

			state.graphics.endFill();
			state.graphics.lineStyle( 1, 0x666666 );
			state.graphics.moveTo( 0, _height );
			state.graphics.lineTo( _width, _height );
			state.graphics.moveTo( _width, _height );
			state.graphics.lineTo( _width, 0 );
			state.graphics.endFill();			
			
			addChildAt( state, 0 );			
		}
	
	}
}
