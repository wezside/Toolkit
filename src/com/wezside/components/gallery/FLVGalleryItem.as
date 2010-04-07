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
	import com.wezside.utilities.manager.state.StateManager;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FLVGalleryItem extends Sprite implements IGalleryItem 
	{

		
		private var _type:String;
		private var _debug:Boolean;
		private var _sm:StateManager;
		private var _selected:Boolean;


		public function FLVGalleryItem( type:String, debug:Boolean )
		{
			_type = type;
			_debug = debug;
			_selected = false;
			_sm = new StateManager();
			_sm.addState( Gallery.STATE_ROLLOVER );
			_sm.addState( Gallery.STATE_ROLLOUT );
			_sm.addState( Gallery.STATE_SELECTED, true );			
		}
		
		public function load( url:String, livedate:Date ):void
		{
		}		
		
		public function play():void
		{
		}
		
		public function stop():void
		{
		}		
		
		public function rollOver():void
		{
		}
		
		public function rollOut():void
		{
		}	
		
		public function get state():String
		{
			return _sm.state;
		}
		
		public function set state( value:String ):void
		{
			_sm.state = value;
			switch ( _sm.stateKey )
			{
				case Gallery.STATE_ROLLOUT:	
				case Gallery.STATE_ROLLOUT + Gallery.STATE_SELECTED: rollOut(); break;
									
				case Gallery.STATE_ROLLOVER:
				case Gallery.STATE_ROLLOVER + Gallery.STATE_SELECTED: rollOver(); break;
				
				case Gallery.STATE_SELECTED: _selected = !_selected; break;					
				default: break;
			}
		}	
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
				
		public function purge():void
		{
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected( value:Boolean ):void
		{
			_selected = value;
		}
	}
}
