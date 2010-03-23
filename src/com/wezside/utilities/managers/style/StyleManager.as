package com.wezside.utilities.managers.style 
{
	import flash.display.Loader;
	import flash.display.Sprite;
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
	}
}
