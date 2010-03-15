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
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionContent extends Sprite 
	{
		
		
		private var _title:DisplayObject;
		private var _bg:DisplayObject;
		private var _hitTestInstance:DisplayObject;
		private var _body:DisplayObject;

		
		public function AccordionContent() 
		{
			super();
		}
		
		public function get title():DisplayObject 
		{
			return _title;
		}
		
		public function set title( value:DisplayObject ):void
		{
			_title = value;
			addChildAt( value, this.numChildren );
		}
		
		public function set body( value:DisplayObject ):void
		{
			_body = value;
			_body.y = _title.y + _title.height;
			addChild( _body );
		}
		
		public function get body():DisplayObject 
		{
			return _body;
		}
		
		public function get background():DisplayObject 
		{
			return _bg;
		}
		
		public function set background( value:DisplayObject ):void
		{
			_bg = value;
			addChild( value );
		}
		
		public function get hitTestInstance():DisplayObject
		{
			return _hitTestInstance;
		}
		
		public function set hitTestInstance( value:DisplayObject ):void
		{
			_hitTestInstance = value;
		}
		
	}
}
