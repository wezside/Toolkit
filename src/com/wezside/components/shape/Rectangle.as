package com.wezside.components.shape 
{
	import com.wezside.components.IUIDecorator;

	import flash.display.GradientType;
	import flash.geom.Matrix;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Rectangle extends Shape 
	{
		private var matrix:Matrix;
		private var _backgroundWidth:int;
		private var _backgroundHeight:int;

		public function Rectangle( decorated:IUIDecorator )
		{
			super( decorated );
		}


		override public function draw():void
		{			

			if ( layout )
			{
				if ( _backgroundWidth == 0 ) _backgroundWidth = layout.width;
				if ( _backgroundHeight == 0 ) _backgroundHeight = layout.height;
								
				_backgroundHeight += layout.top;
				_backgroundHeight += layout.bottom;
				_backgroundWidth += layout.left;
				_backgroundWidth += layout.right;
			}
			
			
			matrix = new Matrix();
			matrix.createGradientBox( _backgroundWidth, _backgroundHeight, 90 / 180 * Math.PI );

			graphics.clear( );
			graphics.beginGradientFill( GradientType.LINEAR, backgroundColours, backgroundAlphas, [ 0,255 ], matrix );
			graphics.drawRoundRect( 0, 0, _backgroundWidth, _backgroundHeight, cornerRadius );

			if ( cornerRadius == 0 )
			{
				graphics.lineStyle( borderThickness, 0xffffff, borderAlpha );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( _backgroundWidth, 0 );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( 0, _backgroundHeight );
				graphics.endFill( );
				graphics.lineStyle( borderThickness, 0x666666, borderAlpha );
				graphics.moveTo( 0, _backgroundHeight );
				graphics.lineTo( _backgroundWidth, _backgroundHeight );
				graphics.moveTo( _backgroundWidth, _backgroundHeight );
				graphics.lineTo( _backgroundWidth, 0 );
			}
			graphics.endFill( );
		}		

		
		override public function set width(value:Number):void 
		{
			_backgroundWidth = value;
		}
		
		override public function set height(value:Number):void 
		{
			_backgroundHeight = value;
		}
	}
}
