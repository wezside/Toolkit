package com.wezside.components.container 
{
	import com.wezside.components.UIElement;

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Box extends UIElement 
	{
		
		// Mask properties
		private var _mask:Sprite;
		private var _enableMask:Boolean;
		
		// Background properties
		private var _borderAlpha:int;
		private var _cornerRadius:int;
		private var _borderThickness:int;
		private var _backgroundWidth:Number;
		private var _backgroundHeight:Number;
		private var _backgroundColours:Array;
		private var _backgroundAlphas:Array;
		private var _clipChildren:Boolean;


		private var matrix:Matrix;

		
		public function Box()
		{
			super( );			
			_clipChildren = false;
			_enableMask = false;
			_borderAlpha = 0;
			_cornerRadius = 0;
			_borderThickness = 0;
			_backgroundWidth = 0;
			_backgroundHeight = 0;
			_backgroundAlphas = [];
			_backgroundColours = [];
			
			_mask = new Sprite();
			addChild( _mask );
		}

		override public function update():void 
		{
			super.update( );
			draw( _backgroundColours, _backgroundAlphas );
		}
		
		public function get cornerRadius():int
		{
			return _cornerRadius;
		}
		
		public function set cornerRadius( value:int ):void
		{
			_cornerRadius = value;
		}

		public function get backgroundColours():Array
		{
			return _backgroundColours;
		}
		
		public function set backgroundColours( value:Array ):void
		{
			_backgroundColours = value;
		}
		
		public function get backgroundAlphas():Array
		{
			return _backgroundAlphas;
		}
		
		public function set backgroundAlphas( value:Array ):void
		{
			_backgroundAlphas = value;
		}
		
		public function get enableMask():Boolean
		{
			return _enableMask;
		}
		
		public function set enableMask( value:Boolean ):void
		{
			_enableMask = value;
			if ( _enableMask )
			{
				_mask.graphics.clear();
				_mask.graphics.beginFill( 0xff0000 );				
				_mask.graphics.drawRect(0, 0, _backgroundWidth, _backgroundHeight );
				_mask.graphics.endFill();
			}
		}
		
		override public function set width(value:Number):void 
		{
			_backgroundWidth = value;		
		}
		
		override public function set height(value:Number):void 
		{
			_backgroundHeight = value;
		}

		protected function draw( colors:Array, alphas:Array ):void
		{			

			if ( _backgroundWidth == 0 ) _backgroundWidth = width;
			if ( _backgroundHeight == 0 ) _backgroundHeight = height;
			
			matrix = new Matrix();
			matrix.createGradientBox( _backgroundWidth, _backgroundHeight, 90 / 180 * Math.PI );

			graphics.clear( );
			graphics.beginGradientFill( GradientType.LINEAR, colors, alphas, [ 0,255 ], matrix );
			graphics.drawRoundRect( 0, 0, _backgroundWidth, _backgroundHeight, _cornerRadius );

			if ( _cornerRadius == 0 )
			{
				graphics.lineStyle( _borderThickness, 0xffffff, _borderAlpha );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( _backgroundWidth, 0 );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( 0, _backgroundHeight );
				graphics.endFill( );
				graphics.lineStyle( _borderThickness, 0x666666, _borderAlpha );
				graphics.moveTo( 0, _backgroundHeight );
				graphics.lineTo( _backgroundWidth, _backgroundHeight );
				graphics.moveTo( _backgroundWidth, _backgroundHeight );
				graphics.lineTo( _backgroundWidth, 0 );
			}
			graphics.endFill( );

			if ( _enableMask ) setMask( _backgroundWidth + 1, _backgroundHeight + 1 );
		}
		
		protected function setMask( w:int, h:int ):void
		{
			_mask.width = w;
			_mask.height = h;
		}	
	}
}
