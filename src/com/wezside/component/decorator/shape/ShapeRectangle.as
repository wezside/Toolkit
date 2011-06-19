/**
 * Copyright (c) 2011 Wesley Swanepoel
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
package com.wezside.component.decorator.shape 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElement;
	import com.wezside.component.decorator.scroll.ScrollHorizontal;
	import com.wezside.component.decorator.scroll.ScrollVertical;
	import com.wezside.utilities.imaging.GraphicsEx;
	import flash.display.GradientType;
	import flash.geom.Matrix;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class ShapeRectangle extends Shape 
	{
		
	
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
			super.draw();
			
			// If width or height has changed, i.e. resize is require, set drawable props to new resized value	
			if ( autoDetectWidth && decorated is UIElement )
			{			
				width = UIElement( decorated ).bareWidth + 
						UIElement( decorated ).layout.left + 
						UIElement( decorated ).layout.right;
			}
			if ( autoDetectHeight && decorated is UIElement )
			{
				height = UIElement( decorated ).bareHeight + 
						UIElement( decorated ).layout.top + 
						UIElement( decorated ).layout.bottom;
			}

			// First Time Round: If width of the background wasn't explicitly set - detect it automatically
			// Need to add padding as Shape decorator doesn't know anything about Layout property chain
			if (  width == 0 )
			{
				autoDetectWidth = true;
				if ( decorated is UIElement )
					width = UIElement( decorated ).width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
				else width = decorated.width;
			}
			if ( height == 0 )
			{
				autoDetectHeight = true;
				if ( decorated is UIElement )
					height = decorated.height + UIElement( decorated ).layout.top + UIElement( decorated ).layout.bottom;
				else height = decorated.height;
			}

			// If a scrollbar is present then override the height to the scrollheight			
			if ( decorated is UIElement && UIElement( decorated ).scroll )
			{
				if ( UIElement( decorated ).scroll is ScrollVertical )
				{
					height = UIElement( decorated ).scroll.height + UIElement( decorated ).layout.top + UIElement( decorated ).layout.bottom;		
					width = UIElement( decorated ).bareWidth + 
							UIElement( decorated ).layout.left + 
							UIElement( decorated ).layout.right + 
							UIElement( decorated ).scroll.width;
				}					
				if ( UIElement( decorated ).scroll is ScrollHorizontal )
				{
					width = UIElement( decorated ).scroll.width + UIElement( decorated ).layout.left + UIElement( decorated ).layout.right;
					height = UIElement( decorated ).bareHeight + 
							UIElement( decorated ).layout.top + 
							UIElement( decorated ).layout.bottom + 
							UIElement( decorated ).scroll.height;
				}
			}
						
			
			if ( alphas.length == 1 ) alphas.push( colours[ 0 ]);
			if ( colours.length == 1 ) colours.push( colours[ 0 ]);

			if ( decorated is IUIElement )
				graphicsEx = new GraphicsEx( graphics );
			else
			{
				graphicsEx = new GraphicsEx( graphics );
				graphicsEx.concat( Shape( decorated ).graphicsEx );			
			}
				
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );

			if ( borderThickness > 0 )
				graphicsEx.lineStyle( borderThickness, borderColor, borderAlpha, true );

			graphicsEx.beginGradientFill( GradientType.LINEAR, colours, alphas, ratios, matrix );

			if ( cornerRadius > 0 )
				graphicsEx.drawRoundRect( xOffset, yOffset, width, height, cornerRadius );
			else
				graphicsEx.drawRoundRectComplex( xOffset, yOffset, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius );

			if ( cornerRadius == 0 && borderThickness > 0 )
			{
				graphicsEx.lineStyle( borderThickness, borderColor, borderAlpha );
				graphicsEx.moveTo( 0, 0 );
				graphicsEx.lineTo( width, 0 );
				graphicsEx.moveTo( 0, 0 );
				graphicsEx.lineTo( 0, height );
				graphicsEx.endFill( );
				graphicsEx.lineStyle( borderThickness, borderColor, borderAlpha );
				graphicsEx.moveTo( 0, height );
				graphicsEx.lineTo( width, height );
				graphicsEx.moveTo( width, height );
				graphicsEx.lineTo( width, 0 );
			}
		}
	}
}
