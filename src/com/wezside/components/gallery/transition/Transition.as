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
package com.wezside.components.gallery.transition 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.layout.ILayout;
	import com.wezside.data.iterator.ChildIterator;
	import com.wezside.data.iterator.IIterator;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Transition extends Sprite implements IGalleryTransition 
	{
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;		
		private var _columns:Number;
		private var _rows:Number;
		private var _reflectionHeightInRows:int;
		
		protected var decorated:IUIDecorator;
		protected var transEvent:GalleryEvent;

		
		public function Transition( decorated:IUIDecorator ) 
		{
			this.decorated = decorated;
			transEvent = new GalleryEvent( GalleryEvent.INTRO_COMPLETE );
		}
		
		public function get stageWidth():Number
		{
			return _stageWidth;
		}
		
		public function set stageWidth( value:Number ):void
		{
			_stageWidth = value;
		}
		
		public function get stageHeight():Number
		{
			return _stageHeight;
		}
		
		public function set stageHeight( value:Number ):void
		{
			_stageHeight = value;
		}
		
		/**
		 */
		public function arrange( event:UIElementEvent = null ):void
		{
		}
				
		protected function transitionComplete():void
		{
			dispatchEvent( transEvent );
		}		
		
		public function iterator( type:String = null ):IIterator
		{
			return new ChildIterator( this );  
		}
		
		public function update():void
		{
		}
		
		public function get layout():ILayout
		{
			return null;
		}
		
		public function set layout(value:ILayout):void
		{
		}
		
		public function intro():void
		{
		}
		
		public function outro():void
		{
		}
		
		public function get rows():Number
		{
			return _rows;
		}
		
		public function get columns():Number
		{
			return _columns;
		}
		
		public function set rows(value:Number):void
		{
			_rows = value;
		}
		
		public function set columns(value:Number):void
		{
			_columns = value;
		}
		
		public function get reflectionHeightInRows():int
		{
			return _reflectionHeightInRows;
		}
		
		public function set reflectionHeightInRows(value:int):void
		{
			_reflectionHeightInRows = value;
		}
	}
}
