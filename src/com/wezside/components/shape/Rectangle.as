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

	import flash.display.GradientType;
	import flash.geom.Matrix;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Rectangle extends Shape 
	{
		

		private var matrix:Matrix;


		public function Rectangle( decorated:IUIDecorator )
		{
			super( decorated );
		}

		override public function draw():void
		{

			if ( width == 0 ) width = layout.width;
			if ( height == 0 ) height = layout.height;
							
			height += layout.top;
			height += layout.bottom;
			width += layout.left;
			width += layout.right;
			
			matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );
		
			shape.graphics.beginGradientFill( GradientType.LINEAR, colours, alphas, [ 0,255 ], matrix );
			shape.graphics.drawRoundRect( -layout.left, -layout.top, width, height, cornerRadius );

			if ( cornerRadius == 0 )
			{
				shape.graphics.lineStyle( borderThickness, 0xffffff, borderAlpha );
				shape.graphics.moveTo( 0, 0 );
				shape.graphics.lineTo( width, 0 );
				shape.graphics.moveTo( 0, 0 );
				shape.graphics.lineTo( 0, height );
				shape.graphics.endFill( );
				shape.graphics.lineStyle( borderThickness, 0x666666, borderAlpha );
				shape.graphics.moveTo( 0, height );
				shape.graphics.lineTo( width, height );
				shape.graphics.moveTo( width, height );
				shape.graphics.lineTo( width, 0 );
			}			
		}
	}
}
