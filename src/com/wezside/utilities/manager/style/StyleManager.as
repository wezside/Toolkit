/**
 * Copyright (c) 2011 Wesley Swanepoel
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
	import flash.text.engine.FontDescription;
	import flash.text.engine.ElementFormat;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.string.StringUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * patched by Sean Lailvaux
	 */
	public class StyleManager extends Sprite implements IStyleManager
	{
		private var _css:String;
		private var _fontReady:Boolean = true;
		private var _libraryReady:Boolean = true;
		private var _libraryLoader:Loader;
		private var _fontLoader:Loader;
		private var _reserved:Array = [ "upSkin", "overSkin", "downSkin", "selectedSkin", "invalidSkin", "disabledSkin" ];
		private var _sheet:StyleSheet;
		private var _allowCodeImport:Boolean = true;

		public function parseCSSByteArray( clazz:Class ):void
		{
			var ba:ByteArray = new clazz() as ByteArray;
			_css = ba.readUTFBytes( ba.length );
			if ( !_sheet ) _sheet = new StyleSheet();
			_sheet.parseCSS( _css );
		}

		public function parseLibrary( library:ByteArray, appDomain:ApplicationDomain, securityDomain:SecurityDomain = null ):void
		{
			_libraryReady = false;
			if ( !hasEventListener( Event.ENTER_FRAME ))
				addEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = appDomain;
			context.securityDomain = securityDomain ? securityDomain : null;
			/*FDT_IGNORE*/
//			context.allowCodeImport = _allowCodeImport;
			/*FDT_IGNORE*/
			_libraryLoader = new Loader();
			_libraryLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLibraryLoadComplete );
			_libraryLoader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_libraryLoader.loadBytes( library, context );
		}

		public function parseFontLibrary( library:ByteArray, appDomain:ApplicationDomain, securityDomain:SecurityDomain = null ):void
		{
			_fontReady = false;
			if ( !hasEventListener( Event.ENTER_FRAME ))
				addEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = appDomain;
			context.securityDomain = securityDomain ? securityDomain : null;
			_fontLoader = new Loader();
			_fontLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onFontLoadComplete );
			_fontLoader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_fontLoader.loadBytes( library, context );
		}

		private function onLibraryLoadComplete( event:Event ):void
		{
			_libraryLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLibraryLoadComplete );
			_libraryLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			Tracer.output( false, "onLibraryLoadComplete", getQualifiedClassName( this ), Tracer.INFO );
		}

		private function onFontLoadComplete( event:Event ):void
		{
			_fontLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onFontLoadComplete );
			_fontLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			Tracer.output( false, "onFontLoadComplete", getQualifiedClassName( this ), Tracer.INFO );
		}

		private function onSecurityError( event:SecurityErrorEvent ):void
		{
			if ( _libraryLoader )
			{
				_libraryLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLibraryLoadComplete );
				_libraryLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			}
			if ( _fontLoader )
			{
				_fontLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onFontLoadComplete );
				_fontLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			}
			Tracer.output( false, "onSecurityError: " + event.text, getQualifiedClassName( this ), Tracer.ERROR );
		}

		public function hasAssetByName( linkageClassName:String ):Boolean
		{
			if ( _libraryLoader && _libraryLoader.contentLoaderInfo && _libraryLoader.contentLoaderInfo.applicationDomain )
			{
				return _libraryLoader.contentLoaderInfo.applicationDomain.hasDefinition( linkageClassName );
			}
			return hasOwnProperty( linkageClassName );
		}

		public function getAssetByName( linkageClassName:String ):DisplayObject
		{
			if ( _libraryLoader && _libraryLoader.contentLoaderInfo && _libraryLoader.contentLoaderInfo.applicationDomain )
			{
				var SymbolClass:Class = _libraryLoader.contentLoaderInfo.applicationDomain.getDefinition( linkageClassName ) as Class;
				try
				{
					return new SymbolClass() as DisplayObject;
					;
				}
				catch ( error:Error )
				{
					var bmp:Bitmap = new Bitmap( new SymbolClass( 0, 0 ) as BitmapData );
					bmp.smoothing = true;
					return bmp;
				}
			}
			if ( hasOwnProperty( linkageClassName ) )
			{
				if ( this[ linkageClassName ] is Class )
				{
					return new this[ linkageClassName ]();
				}
			}
			throw new Error( "Unable to find library asset " + linkageClassName );
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
			var props:Array = [];
			if ( _sheet )
			{
				var strUtil:StringUtil = new StringUtil();
				var cssObj:Object = _sheet.getStyle( strUtil.isFirstLetterLowerCase( styleName ) ? "." + styleName : styleName );
				strUtil = null;
				var orderedReserved:Array = [];
				for ( var k:int = 0; k < _reserved.length; ++k )
					if ( cssObj.hasOwnProperty( _reserved[k] ))
						orderedReserved.push( { prop:_reserved[k], value:cssObj[ _reserved[ k ]] } );
				for ( var i:String in cssObj )
				{
					var result:Boolean;
					for ( var j:int = 0; j < _reserved.length; ++j )
						if ( i != _reserved[j])
							result = true;
					if ( result )
						props.push( { prop:i, value:cssObj[i] } );
				}
				props = props.concat( orderedReserved );
			}
			return props;
		}
		
		/** 
         * Reads a set of style properties for a named style and then creates 
         * a TextFormat object that uses the same properties. 
         */ 
        public function getElementFormat( styleName:String ):ElementFormat 
        { 
            var style:Object = _sheet.getStyle( styleName ); 
            if ( style != null ) 
            { 
                var colorStr:String = style.color; 
                if ( colorStr != null && colorStr.indexOf( "#" ) == 0 ) 
                { 
                    style.color = colorStr.substr( 1 ); 
                } 
                var fd:FontDescription = new FontDescription( 
                                    style.fontFamily, 
                                    style.fontWeight, 
                                    style.fontPosture, 
                                    style.fontLookup, 
                                    style.renderingMode, 
                                    style.cffHinting ); 
                var format:ElementFormat = new ElementFormat(fd, 
                                      style.fontSize, 
                                      style.color, 
                                      1, 
                                      style.textRotation, 
                                      style.dominantBaseline, 
                                      style.alignmentBaseline, 
                                      style.baselineShift, 
                                      style.kerning, 
                                      style.trackingRight, 
                                      style.trackingLeft, 
                                      style.locale, 
                                      style.breakOpportunity, 
                                      style.digitCase, 
                                      style.digitWidth, 
                                      style.ligatureLevel, 
                                      style.typographicCase ); 
                 
                if ( style.hasOwnProperty( "letterSpacing" ))         
                {                  
                    format.trackingRight = style.letterSpacing; 
                } 
            } 
            return format; 
        } 				

		public function get css():String
		{
			return _css;
		}

		public function get allowCodeImport():Boolean
		{
			return _allowCodeImport;
		}

		public function set allowCodeImport( value:Boolean ):void
		{
			_allowCodeImport = value;
		}

		public function purge():void
		{
			removeEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
			if ( _libraryLoader )
			{
				if ( _libraryLoader.contentLoaderInfo )
				{
					_libraryLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLibraryLoadComplete );
					_libraryLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
				}
				try
				{
					_libraryLoader.close();
				}
				catch ( error:Error )
				{
				}
				_libraryLoader = null;
			}

			if ( _fontLoader )
			{
				if ( _fontLoader.contentLoaderInfo )
				{
					_fontLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onFontLoadComplete );
					_fontLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
				}
				try
				{
					_fontLoader.close();
				}
				catch ( error:Error )
				{
				}
				_fontLoader = null;
			}

			if ( _sheet )
			{
				_sheet.clear();
				_sheet = null;
			}

			_reserved = null;
		}

		private function libraryEnterFrameCheck( event:Event ):void
		{
			if ( _libraryLoader && _libraryLoader.content ) _libraryReady = true;
			if ( _fontLoader && _fontLoader.content ) _fontReady = true;
			if ( _libraryReady && _fontReady )
			{
				removeEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
	}
}