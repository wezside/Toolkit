package com.wezside.components.container 
{

	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.3.0
	 * 
	 * TODO: Add Draggable boolean flag
	 * TODO: Add HoriztonalAlign & VerticalAlign calculations
	 * TODO: Look at child objects width and height resize options.
	 * TODO: Currently ModuleEvent.CREATION_COMPLETE is only invoked if there are children added to the 
	 * 		 component. Not all components will add children in this way. 
	 * 
	 * FIXME: Usecase: Stylesheet set with width or height prop. Setting an override value within 
	 * 		  		   the MXML props does not override the CSS. 
	 * 		   	 	   Works as ecpected if CSS is used but no width or height props set within CSS. 
	 * 		  		   Expected result: It should override any CSS settings.
	 * 		  
	 * FIXME: Problem with mouseChildren once mask is set
	 * 
	 * FIXME: Problem with stylesheet applied to hbox + vbox - disables selection on textfields  
	 */
	[Bindable]
	public class Box extends Container 
	{
		
		
		private var _gap:int;
		private var _positionProp:String;
		private var _dimensionProp:String;
		private var _cornerRadius:int;
		private var _backgroundAlpha:Number;
		private var _width:Number;
		private var _height:Number;
		private var _customWidth:Boolean;
		private var _customHeight:Boolean;
		private var _maskWidth:int;
		private var _maskHeight:Number;
		private var _enableGlow:Boolean;
		private var _enableDropShadow:Boolean;
		private var _dropShadowAlpha:Number;
		private var _ds:DropShadowFilter;
		private var _gf:GlowFilter;
		private var _filters:Array;
		private var _paddingLeft:int;
		private var _paddingRight:int;
		private var _paddingTop:int;
		private var _paddingBottom:int;
		private var _backgroundAlphas:Array;
		private var _backgroundColors:Array;
		private var _borderThickness:Number;
		private var _borderAlpha:Number;
		private var _scrollPolicy:String;
		private var _mask:Sprite;
		private var _actualWidth:int;
		private var _actualHeight:int;
		
		private var matrix:Matrix;
		
		protected var _contentWidth:int;
		protected var _contentHeight:int;		
	
		public static const PROP_X:String = "x";
		public static const PROP_Y:String = "y";
		public static const PROP_WIDTH:String = "width";
		public static const PROP_HEIGHT:String = "height";

		
		public function Box()
		{
			_gap = 0;
			_cornerRadius = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
			_paddingTop = 0;
			_paddingBottom = 0;
						
			_width = 0;
			_height = 0;
			_maskWidth = 0;
			_maskHeight = 0;
			_contentWidth = 0;
			_contentHeight = 0;			
			_actualWidth = 0;
			_actualHeight = 0;
			
			_backgroundAlpha = 1;
			_borderThickness = 1;
			_borderAlpha = 1;
	
			_backgroundColors = [0xE6E6E6, 0x959595 ];
			_backgroundAlphas = [_backgroundAlpha, _backgroundAlpha];
			
			_mask = new Sprite();
			_mask.graphics.clear();
			_mask.graphics.beginFill( 0xFF0000 );
			_mask.graphics.drawRoundRect( 0, 0, 20, 20, _cornerRadius );
			_mask.graphics.endFill();
			addChild( _mask );			
			mask = _mask;			
			
			_filters = [];
			_enableGlow = false;
			_enableDropShadow = false;
			_ds = new DropShadowFilter( 4, 45, 0, 0.5 );
			_gf = new GlowFilter( 0xefefef );			

			addEventListener( ContainerEvent.CREATION_COMPLETE, arrange );
		}
		
		
		/** 
		 * Method used to arrange x, y, width and height props based on style, or override width set 
		 * as MXML property. Method is invoked first time on ModuleEvent.CREATION_COMPLETE event. This 
		 * event is only dispatch if the component has display children declared in MXML.
		 * 
		 * The local update() method also invokes this method. Update is invoked from the super Container class
		 * once a stylesheet as been applied. 
		 */
		protected function arrange( event:Event = null ):void
		{
			var offset:int = 0;
			var maxWidth:int = 0;
			var maxHeight:int = 0;		
			
			if ( _positionProp != null )
			{
				for each ( var child:DisplayObject in _children )
				{
					child.x = _paddingLeft;
					child.y = _paddingTop;				
					child[_positionProp] += offset;
					offset += child[_dimensionProp] + _gap;
	
					maxWidth = child.width > maxWidth ? child.width : maxWidth;
					maxHeight = child.height > maxHeight ? child.height : maxHeight;
	
					if ( _positionProp == PROP_X ) _contentWidth = offset + _paddingLeft + _paddingRight;
					else _contentWidth = maxWidth + _paddingLeft + _paddingRight;
					
					if ( _positionProp == PROP_Y ) _contentHeight = offset + _paddingTop + _paddingBottom;
					else _contentHeight = maxHeight + _paddingTop + _paddingBottom;
				}
			}
			
			// If a custom prop was used within MXML then override values
			_actualWidth = _customWidth ? _width : _contentWidth;
			_actualHeight = _customHeight ? _height : _contentHeight;

			// Update internal props through setter to invoke any binding events			
			this.width = _actualWidth;
			this.height = _actualHeight;
			
			draw( _backgroundColors, _backgroundAlphas );
		}


		// FIXME: Need to have a border on rounded corners
		protected function draw( colors:Array, alphas:Array ):void
		{	
			matrix = new Matrix();
			matrix.createGradientBox( _width, _height, 90 / 180 * Math.PI );
						
			graphics.clear();			
			graphics.beginGradientFill( GradientType.LINEAR, colors, alphas, [0,255], matrix );
			graphics.drawRoundRect( 0, 0, _width, _height, _cornerRadius );			
			
			if ( _cornerRadius == 0 )
			{
				graphics.lineStyle( _borderThickness, 0xffffff, _borderAlpha );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( _width, 0 );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( 0, _height );
				graphics.endFill();
				graphics.lineStyle( _borderThickness, 0x666666, _borderAlpha );
				graphics.moveTo( 0, _height );
				graphics.lineTo( _width, _height );
				graphics.moveTo( _width, _height );
				graphics.lineTo( _width, 0 );
			}
			graphics.endFill();

			setMask( _width+1, _height+1 );		
		}

		
		protected function setMask( w:int, h:int ):void
		{
			_mask.width = w;
			_mask.height = h;
		}
		

		/**
		 * This method redraws the component onto the stage. Called from super class Container setStyle()
		 * to invoke an update if a style is applied. 
		 */
		override public function update():void
		{
			arrange();	
		}
		
		
		public function get gap():int
		{
			return _gap;
		}

		
		public function set gap( value:int ):void
		{
			_gap = value;
		}

		
		public function get cornerRadius():int
		{
			return _cornerRadius;
		}
		
		
		public function set cornerRadius( value:int ):void
		{
			_cornerRadius = value;
		}
		
		
		public function get paddingTop():int
		{
			return _paddingTop;
		}
		
		
		public function set paddingTop( value:int ):void
		{
			_paddingTop = value;
		}
		
		
		public function get paddingLeft():int
		{
			return _paddingLeft;
		}
		
		
		public function set paddingLeft( value:int ):void
		{
			_paddingLeft = value;
		}
		
		
		public function get paddingRight():int
		{
			return _paddingRight;
		}
		
		
		public function set paddingRight( value:int ):void
		{
			_paddingRight = value;
		}
		
		
		public function get paddingBottom():int
		{
			return _paddingBottom;
		}
		
		
		public function set paddingBottom( value:int ):void
		{
			_paddingBottom = value;
		}
		
		
		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}
		
		
		public function set backgroundAlpha( value:Number ):void
		{
			_backgroundAlpha = value <= 1 && value >= 0 ? value : 1;
		}

		
		public function get backgroundAlphas():Array
		{
			return _backgroundAlphas;
		}
		
		public function set backgroundAlphas( value:Array ):void
		{
			_backgroundAlphas = value;
		}

		public function get backgroundColors():Array
		{
			return _backgroundColors;
		}
		
		public function set backgroundColors( value:Array ):void
		{
			_backgroundColors = value;
		}

		public function get borerThickness():Number
		{
			return _borderThickness;
		}
		
		public function set borerThickness( value:Number ):void
		{
			_borderThickness = value;
		}

		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		public function set borderAlpha( value:Number ):void
		{
			_borderAlpha = value;
		}


		public function get enableDropShadow():Boolean
		{
			return _enableDropShadow;
		}

		
		public function set enableDropShadow( value:Boolean ):void
		{
			_enableDropShadow = value;
			_enableDropShadow ? _filters = _filters.concat([ _ds ]) : _filters;
			filters = _filters;
		}

		
		public function get dropShadowAlpha():Number
		{
			return _dropShadowAlpha;
		}
		
		public function set dropShadowAlpha( value:Number ):void
		{
			_dropShadowAlpha = value;
			_ds = new DropShadowFilter( 4, 45, 0, _dropShadowAlpha );
		}


		public function get enableGlow():Boolean
		{
			return _enableGlow;
		}
		
		
		public function set enableGlow( value:Boolean ):void
		{
			_enableGlow = value;
			_enableGlow ? _filters = _filters.concat([ _gf ]) : _filters;
			filters = _filters;			
		}


		public function get scrollPolicy():String
		{
			return _scrollPolicy;
		}
		
		public function set scrollPolicy( value:String ):void
		{
			_scrollPolicy = value;
		}


		
		public function get positionProp():String
		{
			return _positionProp;
		}
		
		
		public function set positionProp( value:String ):void
		{
			_positionProp = value;
		}
		

		public function get dimensionProp():String
		{
			return _dimensionProp;
		}
		
		
		public function set dimensionProp( value:String ):void
		{
			_dimensionProp = value;
		}
	

		override public function set x( value:Number ):void
		{
			super.x = value;
		}
		

		override public function set y( value:Number ):void
		{
			super.y = value;
		}


		override public function get width():Number
		{
			return _width;
		}		
		

		override public function set width( value:Number ):void
		{
			_width = value;
			if ( _width != _contentWidth ) _customWidth = true;
			update();
		}

		
		override public function get height():Number
		{
			return _height;
		}
		
		
		override public function set height( value:Number ):void
		{
			_height = value;
			if ( _height != _contentHeight ) _customHeight = true;
			update();
		}


		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}		
	}
}
