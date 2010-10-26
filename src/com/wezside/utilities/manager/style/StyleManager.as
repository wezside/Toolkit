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
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.string.StringUtil;

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
		private var _libraryReady:Boolean;
		private var _libraryLoader:Loader;
		private var _fontReady:Boolean;
		private var _fontLoader:Loader;
		private var _reserved:Array = [ "upSkin", "overSkin", "downSkin", "selectedSkin", "invalidSkin", "disabledSkin" ];
		private var _sheet:StyleSheet;

		public function StyleManager()
		{
			_libraryReady = ( _libraryLoader == null );
			_fontReady = ( _fontLoader == null );
			addEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
		}

		public function parseCSSByteArray( clazz:Class ) : void
		{
			var ba:ByteArray = new clazz() as ByteArray;
			_css = ba.readUTFBytes( ba.length );
			_sheet = new StyleSheet();
			_sheet.parseCSS( _css );
		}

		public function parseLibrary( library:ByteArray, appDomain:ApplicationDomain, securityDomain:SecurityDomain = null ) : void
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = appDomain;
			context.securityDomain = securityDomain ? securityDomain : null;
			_libraryLoader = new Loader();
			_libraryLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLibraryLoadComplete );
			_libraryLoader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_libraryLoader.loadBytes( library, context );
		}

		public function parseFontLibrary( library:ByteArray, appDomain:ApplicationDomain, securityDomain:SecurityDomain = null ) : void
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = appDomain;
			context.securityDomain = securityDomain ? securityDomain : null;
			_fontLoader = new Loader();
			_fontLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onFontLoadComplete );
			_fontLoader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_fontLoader.loadBytes( library, context );
		}

		private function onLibraryLoadComplete( event:Event ) : void
		{
			_libraryLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLibraryLoadComplete );
			_libraryLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			Tracer.output( false, "onLibraryLoadComplete", getQualifiedClassName( this ), Tracer.INFO );
		}

		private function onFontLoadComplete( event:Event ) : void
		{
			_fontLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onFontLoadComplete );
			_fontLoader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			Tracer.output( false, "onFontLoadComplete", getQualifiedClassName( this ), Tracer.INFO );
		}

		private function onSecurityError( event:SecurityErrorEvent ) : void
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

		public function hasAssetByName( linkageClassName:String ) : Boolean
		{
			if ( _libraryLoader && _libraryLoader.contentLoaderInfo && _libraryLoader.contentLoaderInfo.applicationDomain )
			{
				return _libraryLoader.contentLoaderInfo.applicationDomain.hasDefinition( linkageClassName );
			}
			return false;
		}

		public function getAssetByName( linkageClassName:String ) : DisplayObject
		{
			if ( _libraryLoader && _libraryLoader.contentLoaderInfo && _libraryLoader.contentLoaderInfo.applicationDomain )
			{
				var SymbolClass:Class = _libraryLoader.contentLoaderInfo.applicationDomain.getDefinition( linkageClassName ) as Class;
				return new SymbolClass() as DisplayObject;
			}
			throw new Error( "Unable to find library asset " + linkageClassName );
		}

		public function getStyleSheet( styleName:String ) : StyleSheet
		{
			return _sheet;
		}

		public function getLibraryItems( styleName:String ) : Object
		{
			return {};
		}

		public function getPropertyStyles( styleName:String ) : Array
		{
			var strUtil:StringUtil = new StringUtil();
			var cssObj:Object = _sheet.getStyle( strUtil.isFirstLetterLowerCase( styleName ) ? "." + styleName : styleName );
			var props:Array = [];
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
			return props;
		}

		public function get css() : String
		{
			return _css;
		}

		public function get ready() : Boolean
		{
			return ( _libraryReady && _fontReady );
		}

		private function libraryEnterFrameCheck( event:Event ) : void
		{
			if ( _libraryLoader && _libraryLoader.content )
				_libraryReady = true;
			if ( _fontLoader && _fontLoader.content )
				_fontReady = true;
			if ( _libraryReady && _fontReady )
			{
				removeEventListener( Event.ENTER_FRAME, libraryEnterFrameCheck );
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
	}
}