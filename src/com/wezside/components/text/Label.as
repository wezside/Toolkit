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
package com.wezside.components.text
{
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementState;
	import com.wezside.components.decorators.layout.PaddedLayout;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * patched by Sean Lailvaux
	 */
	public class Label extends UIElement
	{
		protected var fmt:TextFormat;
		protected var field:TextField;

		private var _htmlText:String;
		private var _text:String;
		private var _textColorUp:uint;
		private var _textColorOver:uint;
		private var _textColorDown:uint;
		private var _textColorSelected:uint;
		private var _textColorDisabled:uint;
		private var _textColorInvalid:uint;

		
		override public function construct():void
		{
			super.construct();
			layout = new PaddedLayout( this.layout );
			fmt = new TextFormat();
			field = new TextField();
			addChild( field );
		}

		override public function arrange():void
		{
			setText();
			super.arrange();
		}

		override public function purge():void
		{
			super.purge();
			fmt = null;
			field = null;
		}

		override public function set state(value:String):void
		{
			super.state = value;
			switch ( value )
			{
				case UIElementState.STATE_VISUAL_UP :
					field.textColor = textColorUp;
					break;
				case UIElementState.STATE_VISUAL_OVER :
					field.textColor = textColorOver;
					break;
				case UIElementState.STATE_VISUAL_DOWN :
					field.textColor = textColorDown;
					break;
				case UIElementState.STATE_VISUAL_SELECTED :
					field.textColor = textColorSelected;
					break;
				case UIElementState.STATE_VISUAL_INVALID :
					field.textColor = textColorInvalid;
					break;
				case UIElementState.STATE_VISUAL_DISABLED :
					field.textColor = textColorDisabled;
					break;
			}
		}

		public function get font():String
		{
			return fmt.font;
		}

		public function set font(value:String):void
		{
			field.embedFonts = true;
			fmt.font = value;
		}

		override public function set width( value:Number ):void
		{
			field.width = int( value );
		}

		override public function set height( value:Number ):void
		{
			field.height = int( value );
		}

		public function get textWidth():int
		{
			return int( field.textWidth );
		}

		public function get textHeight():int
		{
			return int( field.textHeight );
		}

		public function get size():Number
		{
			return fmt.size as Number;
		}

		public function set size( value:Number ):void
		{
			fmt.size = value;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			setText();
		}

		public function get htmlText():String
		{
			return _htmlText;
		}

		public function set htmlText(value:String):void
		{
			_htmlText = value;
			setText();
		}

		public function get embedFonts():Boolean
		{
			return field.embedFonts;
		}

		public function set embedFonts(value:Boolean):void
		{
			field.embedFonts = value;
		}

		public function get textColor():uint
		{
			return field.textColor;
		}

		public function set textColor(value:uint):void
		{
			field.textColor = value;
			_textColorUp = value;
		}

		public function get textColorUp():uint
		{
			return _textColorUp;
		}

		public function set textColorUp(value:uint):void
		{
			_textColorUp = value;
			field.textColor = value;
		}

		public function get textColorOver():uint
		{
			return _textColorOver;
		}

		public function set textColorOver(value:uint):void
		{
			_textColorOver = value;
		}

		public function get textColorDown():uint
		{
			return _textColorDown;
		}

		public function set textColorDown(value:uint):void
		{
			_textColorDown = value;
		}

		public function get textColorSelected():uint
		{
			return _textColorSelected > 0 ? _textColorSelected : _textColorUp;
		}

		public function set textColorSelected(value:uint):void
		{
			_textColorSelected = value;
		}

		public function get textColorDisabled():uint
		{
			return _textColorDisabled;
		}

		public function set textColorDisabled(value:uint):void
		{
			_textColorDisabled = value;
		}

		public function get textColorInvalid():uint
		{
			return _textColorInvalid;
		}

		public function set textColorInvalid(value:uint):void
		{
			_textColorInvalid = value;
		}

		public function get autoSize():String
		{
			return field.autoSize;
		}

		public function set autoSize(value:String):void
		{
			field.autoSize = value;
		}

		public function get wordWrap():Boolean
		{
			return field.wordWrap;
		}

		public function set wordWrap(value:Boolean):void
		{
			field.wordWrap = value;
		}

		public function get paddingTop():int
		{
			return layout.top;
		}

		public function set paddingTop(value:int):void
		{
			layout.top = value;
		}

		public function get paddingLeft():int
		{
			return layout.left;
		}

		public function set paddingLeft(value:int):void
		{
			layout.left = value;
		}

		public function get paddingRight():int
		{
			return layout.right;
		}

		public function set paddingRight(value:int):void
		{
			layout.right = value;
		}

		public function get paddingBottom():int
		{
			return layout.bottom;
		}

		public function set paddingBottom(value:int):void
		{
			layout.bottom = value;
		}

		public function get selectable():Boolean
		{
			return field.selectable;
		}

		public function set selectable(value:Boolean):void
		{
			field.selectable = value;
		}

		public function get multiline():Boolean
		{
			return field.multiline;
		}

		public function set multiline(value:Boolean):void
		{
			field.multiline = value;
		}

		public function get antiAliasType():String
		{
			return field.antiAliasType;
		}

		public function set antiAliasType(value:String):void
		{
			field.antiAliasType = value;
		}

		public function get border():Boolean
		{
			return field.border;
		}

		public function set border(value:Boolean):void
		{
			field.border = value;
		}

		public function get borderColor():uint
		{
			return field.borderColor;
		}

		public function set borderColor(value:uint):void
		{
			field.borderColor = value;
		}

		public function get align():String
		{
			return fmt.align;
		}

		public function set align(value:String):void
		{
			fmt.align = value;
		}

		public function get bold():Object
		{
			return fmt.bold;
		}

		public function set bold(value:Object):void
		{
			fmt.bold = value;
		}

		public function get italic():Object
		{
			return fmt.italic;
		}

		public function set italic(value:Object):void
		{
			fmt.italic = value;
		}

		public function get underline():Object
		{
			return fmt.underline;
		}

		public function set underline(value:Object):void
		{
			fmt.underline = value;
		}

		public function get leading():Object
		{
			return fmt.leading;
		}

		public function set leading(value:Object):void
		{
			fmt.leading = value;
		}

		public function get letterSpacing():Object
		{
			return fmt.letterSpacing;
		}

		public function set letterSpacing(value:Object):void
		{
			fmt.letterSpacing = value;
		}

		public function get numLines():int
		{
			return field.numLines;
		};

		public function get backgroundColor():uint
		{
			return field.backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			if ( field )
			{
				field.background = true;
				field.backgroundColor = value;
			}
		}

		override public function set buttonMode(value:Boolean):void
		{
			super.buttonMode = value;
			mouseChildren = false;
		}

		private function setText():void
		{
			if ( text == null && htmlText == null )
			{
				if ( field && contains( field ) )
					removeChild( field );
				return;
			}
			if ( styleSheet )
			{
				var t:String = _htmlText == null ? _text : _htmlText;
				field.styleSheet = styleSheet;
				field.htmlText = "<body><span class='" + styleName + "'>" + t + "</span></body>";
			}
			else
			{
				field.defaultTextFormat = fmt;
				if ( _text )
					field.text = _text;
				if ( _htmlText )
					field.htmlText = _htmlText;
			}
		}
	}
}