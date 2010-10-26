/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.components.decorators.shape 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;

	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ShapeRectangle extends Shape 
	{
		private var _autoDetectWidth:Boolean;
		private var _autoDetectHeight : Boolean;
		private var _scale9Grid:Rectangle;
		
		public function ShapeRectangle( decorated:IUIDecorator )
		{
			super( decorated );
		}

		/**
		 * This method is invoked everytime arrange is called. arrange() will clear the graphics object everytime. The correct 
		 * width and height is then calculated based on the usecases outlined below:
		 * 
		 * 	o No width + height explicitely set so use decorated width + height values
		 * 		o Previously decorated width + height values set and decorated arrange() is called again due 
		 * 		  to children updating their width + height properties.
		 * 		  
		 * 	o Explicitely set width + height properties thus ignore decorated width + height
		 */
		override public function draw():void
		{		
			// If width or height has changed, i.e. resize is require, set drawable props to new resized value	
			if ( _autoDetectWidth ) width = decorated.width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
			if ( _autoDetectHeight ) height = decorated.height + UIElement( decorated ).layout.top + UIElement( decorated ).layout.bottom;
						 
			// If width wasn't explicitly set - detect it automatically
			if (  width == 0 )
			{
				_autoDetectWidth = true;
				width = decorated.width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
			}
			if ( height == 0 )
			{
				_autoDetectHeight = true;
				height = decorated.height + UIElement( decorated ).layout.top + UIElement( decorated ).layout.bottom;
			}
			// If a scrollbar is present then override the height to the scrollheight
			if ( UIElement( decorated ).scroll )
			{
				height = UIElement( decorated ).scroll.height;
			}

			if ( alphas.length == 1 ) alphas.push( colours[ 0 ]);
			if ( colours.length == 1 ) colours.push( colours[ 0 ]);

			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );
			
			graphics.clear();
			graphics.lineStyle( borderThickness, borderColor, borderAlpha );
			graphics.beginGradientFill( GradientType.LINEAR, colours, alphas, [ 0,255 ], matrix );

			if ( cornerRadius > 0 )
				graphics.drawRoundRect( 0, 0, width, height, cornerRadius );
			else
				graphics.drawRoundRectComplex( 0, 0, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius );

			if ( cornerRadius == 0 && borderThickness > 0 )
			{
				graphics.lineStyle( borderThickness, borderColor, borderAlpha );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( width, 0 );
				graphics.moveTo( 0, 0 );
				graphics.lineTo( 0, height );
				graphics.endFill( );
				graphics.lineStyle( borderThickness, borderColor, borderAlpha );
				graphics.moveTo( 0, height );
				graphics.lineTo( width, height );
				graphics.moveTo( width, height );
				graphics.lineTo( width, 0 );
			}		
			graphics.endFill();			
			if ( _scale9Grid ) super.scale9Grid = _scale9Grid;
		}
		
		override public function set scale9Grid( innerRectangle:Rectangle ):void
		{
			_scale9Grid = innerRectangle;
			if ( decorated.width > 0 && decorated.height > 0 )
				super.scale9Grid = _scale9Grid;
		}
	}
}
