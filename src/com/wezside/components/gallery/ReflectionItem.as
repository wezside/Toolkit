/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
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
package com.wezside.components.gallery 
{
	import com.wezside.utilities.imaging.Reflection;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ReflectionItem extends Sprite implements IGalleryItem 
	{


		private var bmp:Bitmap;
		private var ratios:Array;
		private var reflectionHeight:Number;
		private var reflection:Sprite;
		private var originWidth:Number;
		private var originHeight:Number;
		
		private var _type:String;
		private var _debug:Boolean;
		private var _selected:Boolean;
		private var _sm:StateManager;
		private var _reflectionAlpha:Number;


		public function ReflectionItem( type:String, bmp:Bitmap, ratios:Array, reflectionHeight:Number, debug:Boolean  )
		{
			_type = type;
			_debug = debug;
			
			this.bmp = bmp;
			this.ratios = ratios;
			this.reflectionHeight = reflectionHeight;
			
			_reflectionAlpha = 0;
			originWidth = bmp.width;
			originHeight = bmp.height;
			
			_selected = false;
			_sm = new StateManager();
			_sm.addState( Gallery.STATE_ROLLOVER );
			_sm.addState( Gallery.STATE_ROLLOUT );
			_sm.addState( Gallery.STATE_SELECTED, true );			
			
			reflection = new Reflection( bmp, ratios, reflectionHeight );
			addChild( reflection );			
		}
		
		public function update( dob:IGalleryItem ):void
		{
			var bmp:BitmapData = new BitmapData( originWidth, originHeight, true, 0x000000FF );
			bmp.draw( dob as Sprite );			
			removeChild( reflection );	
			reflection = new Reflection( new Bitmap( bmp ), ratios, reflectionHeight );		
			addChild( reflection );	
			bmp = null;
		}
		
		public function load( url:String, livedate:Date ):void
		{
		}
		
		public function rollOver():void
		{
			alpha = 1;
		}
		
		public function rollOut():void
		{
			alpha = 0.5;
		}
		
		public function play():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function purge():void
		{
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
		
		public function get state():String
		{
			return _sm.state;
		}
		
		public function set state( value:String ):void
		{
			_sm.state = value;
			switch ( _sm.historyKey )
			{
				case Gallery.STATE_ROLLOUT:	
				case Gallery.STATE_ROLLOUT + Gallery.STATE_SELECTED: rollOut(); break;
									
				case Gallery.STATE_ROLLOVER:
				case Gallery.STATE_ROLLOVER + Gallery.STATE_SELECTED: rollOver(); break;
				
				case Gallery.STATE_SELECTED: _selected = !_selected; break;					
				default: break;
			}
		}	
		
		
		public function get reflectionAlpha():Number
		{
			return _reflectionAlpha;
		}
		
		public function set reflectionAlpha( value:Number ):void
		{
			_reflectionAlpha = value;
		}
		
		public function get selected():Boolean
		{
			return false;
		}
		
		public function set selected(value:Boolean):void
		{
		}
	}
}
