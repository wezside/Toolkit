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
	import com.wezside.components.UIElement;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.data.iterator.ChildIterator;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Transition extends UIElement implements IGalleryTransition 
	{
		
		private var _total:uint;
		private var _totalPages:Number;
		private var _stageWidth:Number;
		private var _stageHeight:Number;		
		private var _columns:Number = 4;
		private var _rows:Number = 3;
		private var _reflectionHeightInRows:int;
		private var _pageIndex:int = 0;
		private var _direction:String = "left";
		
		protected var eventType:String;
		protected var decorated:IUIDecorator;

		
		public function Transition( decorated:IUIDecorator ) 
		{
			this.decorated = decorated;
			eventType = GalleryEvent.INTRO_COMPLETE;
		}
		
		public function perform( type:String = "intro" ):void
		{
			
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
		
		public function get totalPages():Number
		{
			return _totalPages;
		}
		
		public function set totalPages( value:Number ):void
		{
			_totalPages = value;
		}
		
		public function get total():uint
		{
			return _total;
		}
		
		public function set total( value:uint ):void
		{
			_total = value;
		}
		
		public function get pageIndex():int
		{
			return _pageIndex;
		}
		
		public function set pageIndex( value:int ):void
		{
			_pageIndex = value;
		}
				
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction( value:String ):void
		{
			_direction = value;
		}		
		
		override public function arrange():void
		{
		}
				
		protected function transitionComplete():void
		{
			dispatchEvent( new GalleryEvent( eventType ));
		}		
		
		override public function iterator( type:String = null ):IIterator
		{
			return new ChildIterator( decorated as UIElement );  
		}
		
		public function transitionIn():void
		{
			perform( "intro" );
		}
		
		public function transitionOut():void
		{
			perform( "outro" );
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
			_total = _columns * _rows;						
		}
		
		public function set columns(value:Number):void
		{
			_columns = value;
			_total = _columns * _rows;						
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
