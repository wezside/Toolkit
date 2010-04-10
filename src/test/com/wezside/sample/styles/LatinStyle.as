package test.com.wezside.sample.styles 
{
	import flash.system.ApplicationDomain;
	import com.wezside.utilities.manager.style.StyleManager;

	import flash.text.Font;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * This class should be compiled seperately using compiler settings into the swf/styles folder:
	 * -default-size 10 10 -default-frame-rate 31 -default-background-color 0xFFFFFF -library-path {flexSDK}/frameworks/locale/en_US
	 * 
	 */
	public class LatinStyle extends StyleManager 
	{
		[Embed( source="/../assets-embed/fonts/arial.ttf", 
				fontWeight= "normal", 
				fontName="ArialEmbed", 
				mimeType="application/x-font-truetype",
				unicodeRange="U+0020-U+007F, U+00A0-U+00FF, U+0100-U+017F, U+0180-U+024F", 
				embedAsCFF="false")]
		public static var ArialEmbed:Class;		
		
		[Embed( source="/../assets-embed/css/latin_styles.css", mimeType="application/octet-stream")]
		public static var LatinCSS:Class;				
				
		[Embed( source="/../assets-embed/swf/library.swf", mimeType="application/octet-stream" )]
		public static var Library:Class;
		
		public function LatinStyle() 
		{
			super();
			Font.registerFont( LatinStyle.ArialEmbed );			
			parseCSSByteArray( LatinStyle.LatinCSS );			
			parseLibrary( new Library(), ApplicationDomain.currentDomain );
		}
	}
}

