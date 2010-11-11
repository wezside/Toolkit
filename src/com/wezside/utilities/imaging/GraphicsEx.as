package com.wezside.utilities.imaging 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * Based on Stephen Downs (Tink) class for cloning and concatenating graphics
	 */
	public class GraphicsEx 
	{
		
		private var graphics:Graphics;

		public var properties:ICollection;
		
		public function GraphicsEx( graphics:Graphics ) 
		{
			properties = new Collection( );
			this.graphics = graphics;			
		}
		
		public function concat( graphicsEx:GraphicsEx ):Graphics
		{
			var it:IIterator = graphicsEx.properties.iterator();
			while ( it.hasNext() )
			{
				invokeStep( it.next() );
			}
			it.purge();
			it = null;			
			return graphics;
		}
		
		public function beginBitmapFill( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void
		{
			graphics.beginBitmapFill( bitmap, matrix, repeat, smooth );
			createStep( "beginBitmapFill", arguments );
		}
		
		public function beginFill( color:uint, alpha:Number = 1.0 ):void
		{
			graphics.beginFill( color, alpha );
			createStep( "beginFill", arguments );
		}

		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			graphics.beginGradientFill( type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio );
			createStep( "beginGradientFill", arguments );
		}

		public function clear():void
		{
			graphics.clear();
//			createStep( "clear", arguments );
		}

		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			graphics.curveTo( controlX, controlY, anchorX, anchorY );
			createStep( "curveTo", arguments );			
		}

		public function drawCircle( x:Number, y:Number, radius:Number ):void
		{
			graphics.drawCircle( x, y, radius );
			createStep( "drawCircle", arguments );			
		}

		public function drawEllipse( x:Number, y:Number, width:Number, height:Number ):void
		{
			graphics.drawEllipse( x, y, width, height );
			createStep( "drawEllipse", arguments );			
		}

		public function drawRect(x:Number, y:Number, width:Number, height:Number):void
		{
			graphics.drawRect( x, y, width, height );
			createStep( "drawRect", arguments );			
		}

		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void
		{
			graphics.drawRoundRect( x, y, width, height, ellipseWidth, ellipseHeight );
			createStep( "drawRoundRect", arguments );			
		}

		public function drawRoundRectComplex( x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number ):void
		{
			graphics.drawRoundRectComplex( x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius );
			createStep( "drawRoundRectComplex", arguments );			
		}

		public function endFill():void
		{
			graphics.endFill();
			createStep( "endFill", arguments );			
		}

		public function hasOwnProperty( name:String ):Boolean
		{
			return graphics.hasOwnProperty( name );
		}

		public function isPrototypeOf( theClass:Object ):Boolean
		{
			return isPrototypeOf( theClass );			
		}

		public function lineBitmapStyle( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void
		{
			graphics.lineBitmapStyle( bitmap, matrix, repeat, smooth );
			createStep( "lineBitmapStyle", arguments );			
		}

		public function lineGradientStyle( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 ):void
		{
			graphics.lineGradientStyle( type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio );
			createStep( "lineGradientStyle", arguments );			
		}

		public function lineStyle( thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			graphics.lineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit );
			createStep( "lineStyle", arguments );			
		}

		public function lineTo( x:Number, y:Number ):void
		{
			graphics.lineTo( x, y );
			createStep( "lineTo", arguments );			
		}

		public function moveTo( x:Number, y:Number ):void
		{
			graphics.moveTo( x, y );
			createStep( "moveTo", arguments );			
		}

		public function propertyIsEnumerable( name:String ):Boolean
		{
			return graphics.propertyIsEnumerable( name );
		}
		
		/**
		 * Each instance is then push into a Array.
		 */
		private function createStep( method:String, arguments:Array ):void
		{
			properties.addElement( { method: method, arguments: arguments } );
		}

		/**
		 * This is where the re-drawing takes place.
		 * The method String is evaluated and then invoked in the switch statement, passing the correct parameters.
		 */
		private function invokeStep( step:Object ):void
		{
			var method:Function = graphics[ step.method ];
			method.apply( this, step.arguments );
		}
	}
}
