/*
	The MIT License

	Copyright (c) 2009 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package test.com.wezside.sample.gallery 
{
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Preloader extends Sprite 
	{
		

		private var gearSmall:Sprite;
		private var gearMedium:Sprite;
		private var gearLarge:Sprite;
		
		private static const TWO_PI:Number = Math.PI * 2;
		
		
		public function Preloader()
		{
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		
		public function start():void
		{
			visible = true;
			addEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		
		public function stop():void
		{
			visible = false;
			removeEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		
		public function purge():void
		{
		    removeChild( gearSmall );
		    removeChild( gearMedium );
	      	removeChild( gearLarge );			
			removeEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		
		private function stageInit( event:Event ):void
		{
			gearSmall = drawVerts( calcGear( 0, 0, 12, 9 ));
			gearSmall.filters = [ new GlowFilter( 0xffffff, 0.5, 6, 6 )];
			gearMedium = drawVerts( calcGear( 0, 0, 6, 3 ));
			gearMedium.filters = [ new GlowFilter( 0xffffff, 0.5, 6, 6 )];
			gearLarge = drawVerts( calcGear( 0, 0, 3, 5 ));
			gearLarge.filters = [ new GlowFilter( 0xffffff, 0.5, 6, 6 )];
			
		    addChild( gearSmall );
		    addChild( gearMedium );
	      	addChild( gearLarge );
		}

		
		private function enterFrame( event:Event ):void
		{
			gearSmall.rotation += 5;
			gearMedium.rotation -= 10;
			gearLarge.rotation += 3;
		}

		
		/**
		 * Method by Zevan from http://actionsnippet.com/?p=1175
		 */
		private function calcGear( x:Number, y:Number, maxRad:Number, s:int ):Array 
		{
  
			var verts:Array = new Array( );
			var step:Number = TWO_PI / ( s * 4 );
			var mod:Number = 0;
  
			for ( var i:Number = 0; i <= TWO_PI; i += step ) 
			{
				var r:Number = ( int( mod ) % 2 + 1 ) * maxRad;
				mod += .5;
				verts.push( x + r * Math.cos( i ) );
				verts.push( y + r * Math.sin( i ) );
			}
  
			return verts;
		}
		
		
		/**
		 * Method by Zevan from http://actionsnippet.com/?p=1175
		 */
		private function drawVerts( verts:Array ):Sprite
		{
			var sp:Sprite = new Sprite();
  			sp.graphics.lineStyle( 0, 0xeeeeee );
  			sp.graphics.moveTo( verts[0], verts[1] );  
  			sp.graphics.beginFill( 0x666666, 0.5 );
			for ( var i:int = 2; i < verts.length ; i += 2 ) 
  				sp.graphics.lineTo( verts[i], verts[i + 1] );
  				
			sp.graphics.lineTo( verts[0], verts[1] );
			sp.graphics.endFill();
			return sp;
		}
		
	}
}
