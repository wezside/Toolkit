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
package com.wezside.components.accordion 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionItem extends Sprite implements IAccordionItem 
	{
		
		private var yOffset:Number;
		private var _content:DisplayObject;
		private var _verticalGap:Number;
		protected var _selected:Boolean;
		private var _header:DisplayObject;
		private var _currentY:Number;
		private var _targetY:Number;
		private var _adjustContentY:Boolean;
		private var _mask:Sprite;

		
		public function AccordionItem() 
		{
			yOffset = 0;
			_verticalGap = 0;
			_selected = false;
			_currentY = 0;
			_targetY = 0;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected( value:Boolean ):void
		{
			_selected = value;
			if ( _selected )
			{
				_mask.height = _content.height;
				_content.visible = true;
				
			}
			else
			{
				_content.visible = false;
			}			
		}
					
		public function get header():DisplayObject
		{
			return _header;
		}
		
		public function set header( value:DisplayObject ):void
		{
			_header = value;
			_header.addEventListener( MouseEvent.CLICK, click );
			addChild( _header );
		}

		public function get content():DisplayObject
		{
			return _content;
		}
		
		public function set content( value:DisplayObject ):void
		{
			_content = value;
			_content.y = header.y + header.height;
			_content.visible = false;
			
			_mask = new Sprite();
			_mask.graphics.beginFill( 0xff0000 );
			_mask.graphics.drawRect( _content.x, _content.y, _content.width, _content.height );
			_mask.graphics.endFill();
			_mask.height = 0;
			_content.mask = _mask;			
			
			addChildAt( _content, 0 );			
			addChildAt( _mask, 1 );			
		}
		
		public function get maskSprite():Sprite
		{
			return _mask;
		}
		
		public function set maskSprite( value:Sprite ):void
		{
			_mask = value;
		}

		public function get verticalGap():Number
		{
			return _verticalGap;
		}
		
		public function set verticalGap( value:Number ):void
		{
			_verticalGap = value;
		}		

		public function set adjustContentY( value:Boolean ):void
		{
			_adjustContentY = value;
		}
		
		override public function get height():Number 
		{
			return _selected ? _header.height + _content.height : _header.height;
		}

		public function get currentY():Number
		{
			return _currentY;
		}
		
		public function set currentY( value:Number ):void
		{
			_currentY = value;
		}
		
		public function get targetY():Number
		{
			return _targetY;
		}
		
		public function set targetY( value:Number ):void
		{
			_targetY = value;
		}

		private function click( event:MouseEvent ):void 
		{
			dispatchEvent( new AccordionEvent( AccordionEvent.HEADER_CLICK, false, false, uint( this.name )));
		}		
	}
}
