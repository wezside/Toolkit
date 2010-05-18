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
	import com.wezside.components.layout.PaddedLayout;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Label extends UIElement
	{

		protected var fmt:TextFormat;
		protected var field:TextField;
				
		private var _text:String;
		private var _textColourUp:uint;
		private var _textColourOver:uint;
		private var _textColourDown:uint;
		private var _textColourSelected:uint;
		private var _textColourDisabled:uint;
		private var _textColourInvalid:uint;

		
		public function Label()
		{
			super();
			layout = new PaddedLayout( this.layout );
			fmt = new TextFormat( );
			field = new TextField();			
		}

		override public function arrange():void
		{
			super.arrange();
			setText();
		}
		
		override public function set state( value:String ):void 
		{
			super.state = value;
			switch ( value )
			{
				case UIElementState.STATE_VISUAL_UP : field.textColor = textColourUp; break; 
				case UIElementState.STATE_VISUAL_OVER :	field.textColor = textColourOver; break;
				case UIElementState.STATE_VISUAL_DOWN :	field.textColor = textColourDown; break;
				case UIElementState.STATE_VISUAL_SELECTED :	field.textColor = textColourSelected; break;
				case UIElementState.STATE_VISUAL_INVALID : field.textColor = textColourInvalid; break;
				case UIElementState.STATE_VISUAL_DISABLED : field.textColor = textColourDisabled; break;
			}
		}
		
		override public function activate():void 
		{
			interactive.activate();
		}
		
		override public function deactivate():void 
		{
			interactive.deactivate();
		}		

		public function get font():String
		{
			return fmt.font;
		}
		
		public function set font( value:String ):void
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
		
		public function set text( value:String ):void
		{
			_text = value;
			addChild( field );			
		}		
		
		public function get embedFonts():Boolean
		{
			return field.embedFonts;
		}		
		
		public function set embedFonts( value:Boolean ):void
		{
			field.embedFonts = value;
		}		
		
		public function get textColor():uint
		{
			return field.textColor;
		}		
		
		public function set textColor( value:uint ):void
		{
			field.textColor = value;
			_textColourUp = value;
		}		
		
		public function get textColourUp():uint
		{
			return _textColourUp;
		}
		
		public function set textColourUp( value:uint ):void
		{
			_textColourUp = value;
			field.textColor = value;
		}
		
		public function get textColourOver():uint
		{
			return _textColourOver;
		}
		
		public function set textColourOver( value:uint ):void
		{
			_textColourOver = value;
		}
		
		public function get textColourDown():uint
		{
			return _textColourDown;
		}
		
		public function set textColourDown( value:uint ):void
		{
			_textColourDown = value;
		}
		
		public function get textColourSelected():uint
		{
			return _textColourSelected;
		}
		
		public function set textColourSelected( value:uint ):void
		{
			_textColourSelected = value;
		}
		
		public function get textColourDisabled():uint
		{
			return _textColourDisabled;
		}
		
		public function set textColourDisabled( value:uint ):void
		{
			_textColourDisabled = value;
		}
		
		public function get textColourInvalid():uint
		{
			return _textColourInvalid;
		}
		
		public function set textColourInvalid( value:uint ):void
		{
			_textColourInvalid = value;
		}
		
		public function get autoSize():String
		{
			return field.autoSize;
		}		
		
		public function set autoSize( value:String ):void
		{
			field.autoSize = value;
		}
		
		public function get wordWrap():Boolean
		{
			return field.wordWrap;
		}
		
		public function set wordWrap( value:Boolean ):void
		{
			field.wordWrap = value;
		}
		
		public function get paddingTop():int
		{
			return layout.top;
		}
		
		public function set paddingTop( value:int ):void
		{
			layout.top = value;
		}
		
		public function get paddingLeft():int
		{
			return layout.left;
		}
		
		public function set paddingLeft( value:int ):void
		{
			layout.left = value;
		}
		
		public function get paddingRight():int
		{
			return layout.right;
		}
		
		public function set paddingRight( value:int ):void
		{
			layout.right = value;
		}
		
		public function get paddingBottom():int
		{
			return layout.bottom;
		}
		
		public function set paddingBottom( value:int ):void
		{
			layout.bottom = value;
		}
		
		public function get selectable():Boolean
		{
			return field.selectable;
		}
		
		public function set selectable( value:Boolean ):void
		{
			field.selectable = value;
		}
		
		public function get multiline():Boolean
		{
			return field.multiline;
		}
		
		public function set multiline( value:Boolean ):void
		{
			field.multiline = value;
		}
		
		public function get antiAliasType():String
		{
			return field.antiAliasType;
		}
		
		public function set antiAliasType( value:String ):void
		{
			field.antiAliasType = value;
		}
		
		public function get border():Boolean
		{
			return field.border;
		}
		
		public function set border( value:Boolean ):void
		{
			field.border = value;
		}
		
		public function get borderColour():uint
		{
			return field.borderColor;
		}
		
		public function set borderColour( value:uint ):void
		{
			field.borderColor = value;
		}
		
		public function get align():String
		{
			return fmt.align;
		}
		
		public function set align( value:String ):void
		{
			fmt.align = value;
		}		
	
		override public function set buttonMode( value:Boolean ):void 
		{
			super.buttonMode = value;
			mouseChildren = false;
		}

		private function setText():void
		{
			if ( !text )
			{
				if ( contains( field )) removeChild( field );
				return;
			}
			if ( styleSheet ) 
			{
				field.styleSheet = styleSheet; 
				field.htmlText =  "<body><span class='"+styleName+"'>" + _text + "</span></body>";
			}
			else
			{
				field.text = _text;
				field.setTextFormat( fmt );
			}
		}	
	}
}