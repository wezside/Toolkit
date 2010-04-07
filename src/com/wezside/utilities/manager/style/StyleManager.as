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
package com.wezside.utilities.manager.style 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class StyleManager extends Sprite implements IStyleManager 
	{
		
		protected var _css:String;
		protected var loader:Loader = new Loader( );
		protected var propStyles:Array = ["backgroundAlpha", 
										  "backgroundColor", 
										  "borderColor", 
										  "borderThickness",
										  "paddingTop",
										  "paddingLeft",
										  "paddingBottom",
										  "paddingRight",
										  "cornerRadius",
										  "enableDropShadow",
										  "dropShadowAlpha",
										  "horizontalGap",
										  "verticalGap",
										  "embedFonts", 
										  "textRollOverColor", 
										  "antiAliasType",
										  "wordWrap",
										  "autoSize",
										  "multiline",
										  "width",
										  "height",
										  "x",
										  "y"];
		
		private var _sheet:StyleSheet;		

		
		public function parseCSSByteArray( clazz:Class ):void
		{
			var ba:ByteArray = new clazz() as ByteArray;
			_css = ba.readUTFBytes( ba.length );		
			_sheet = new StyleSheet();
			_sheet.parseCSS( _css );
		}
		
			
		public function parseLibrary( library:* ):void
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			loader.loadBytes( library, context );
			addEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );			
		}

		
		public function getAssetByName( linkageClassName:String ):*
		{
			if ( loader != null )
			{
				var SymbolClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition( linkageClassName ) as Class;
				return new SymbolClass()();
			}
			return;
		}	
		
		
		public function getStyleSheet( styleName:String ):StyleSheet
		{
			return _sheet;
		}
		
		public function getLibraryItems( styleName:String ):Object
		{
			return {};
		}
				
		public function getPropertyStyles( styleName:String ):Array		
		{
			var cssObj:Object = _sheet.getStyle( "." + styleName );
			var props:Array = [];			
			for ( var i:int = 0; i < propStyles.length; ++i ) 
				if ( cssObj.hasOwnProperty( propStyles[i] ))
					props.push({ prop: [propStyles[i]], value: cssObj[ propStyles[i] ]});
			
			return props;	
		}
		

		public function get css():String
		{
			return _css;
		}		
		

		private function libraryEnterFrameCheck(event:Event):void 
		{
			if ( loader.content )
			{
				removeEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
				dispatchEvent( new Event( Event.COMPLETE ));
			}
		}				
	}
}
