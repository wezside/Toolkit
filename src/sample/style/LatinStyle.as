package sample.style 
{
	import com.wezside.utilities.manager.style.StyleManager;

	import flash.system.ApplicationDomain;
	import flash.text.Font;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * This class should be compiled seperately using compiler settings into the swf/styles folder:
	 * -default-size 10 10 -default-frame-rate 31 -default-background-color 0xFFFFFF -library-path {flexSDK}/frameworks/locale/en_US
	 * 
	 * Supperted CSS1 styles:
	 * ======================
	 *  color  			Only hexadecimal color values are supported. 
		display 		Supported values are inline, block, and none.
		fontFamily 		A comma-separated list of fonts to use, in descending order of desirability. Any font family name can be used. If you specify a generic font name, it is converted to an appropriate device font. The following font conversions are available: mono is converted to _typewriter, sans-serif is converted to _sans, and serif is converted to _serif.
		fontSize 		Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		fontStyle 		Recognized values are normal and italic.
		fontWeight 		Recognized values are normal and bold.
		kerning 		Recognized values are true and false. Kerning is supported for embedded fonts only. Certain fonts, such as Courier New, do not support kerning. The kerning property is only supported in SWF files created in Windows, not in SWF files created on the Macintosh. However, these SWF files can be played in non-Windows versions of Flash Player and the kerning still applies.
		leading 		The amount of space that is uniformly distributed between lines. The value specifies the number of pixels that are added after each line. A negative value condenses the space between lines. Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		letterSpacing 	The amount of space that is uniformly distributed between characters. The value specifies the number of pixels that are added after each character. A negative value condenses the space between characters. Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		marginLeft 		Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		marginRight 	Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		textAlign 		Recognized values are left, center, right, and justify.
		textDecoration 	Recognized values are none and underline.
		textIndent
		
		Support for following Flex CSS styles tags required:
		=========================================
		 * embedFonts
		 * textRollOverColor
		 * backgroundAlpha
		 * backgroundColor
		 * advancedAntiAliasing
		 * upSkin 
		 * overSkin
		 * downSkin
		 * borderColor
		 * borderThickness
		 * selectedSkin
		 * icon
	 */
	public class LatinStyle extends StyleManager 
	{
		[Embed( source="/../resource/font/arial.ttf", 
				fontWeight= "normal", 
				fontName="ArialEmbed", 
				mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-U+007F, U+00A0-U+00FF, U+0100-U+017F, U+0180-U+024F")]
		public static var ArialEmbed:Class;		
		
		[Embed( source="/../resource/css/latin_styles.css", mimeType="application/octet-stream")]
		public static var LatinCSS:Class;				
				
		[Embed( source="/../resource/swf/library.swf", mimeType="application/octet-stream" )]
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

