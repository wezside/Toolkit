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
package com.wezside.components.shape 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;

	import flash.display.GradientType;
	import flash.geom.Matrix;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Rectangle extends Shape 
	{
		
		public function Rectangle( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function draw():void
		{				
			if ( width == 0 ) width = decorated.width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
			if ( height == 0 ) height = decorated.height + UIElement( decorated ).layout.top + UIElement( decorated ).layout.bottom;
			
			// If a scrollbar is present then override the height to the scrollheight
			if ( UIElement( decorated ).scroll )
			{
				width = decorated.width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
				height = UIElement( decorated ).scroll.height;	
			}

			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );
			graphics.beginGradientFill( GradientType.LINEAR, colours, alphas, [ 0,255 ], matrix );
			graphics.drawRoundRect( 0, 0, width, height, cornerRadius );

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
		}
	}
}
