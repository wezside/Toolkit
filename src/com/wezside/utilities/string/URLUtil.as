package com.wezside.utilities.string
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Sean Lailvaux
	 */
	public class URLUtil
	{
		/**
		 * @author Sean Lailvaux
		 * 
		 * @param url 			[String] 		The URL you want to check.
		 * @param useDash 		[Boolean] 		Default to false. Set to true to only check against dashes
		 * @return 				[int] 			The amount of paths in the URL
		 * 
		 * @example 	getNumPaths( "one/two/three/" );  	// returns 3
		 * @example 	getNumPaths( "one-two" );   		// returns 1
		 * @example 	getNumPaths( "one-two", true );   	// returns 2
		 * @example 	getNumPaths( "\one\two\three\" );   // returns 3
		 */
		public function getNumPaths( url:String, delimiter:String = "/" ):int
		{
			var amt:uint = 0;
			url = url.replace( /\t/g, "/t" );
			url = url.replace( /\n/g, "/n" );

			if ( delimiter != "/" )
			{
				url = url.replace( /\W/g, "/" );
				delimiter = "/";
			}

			amt += url.split( delimiter ).length;
			if ( url.charAt( 0 ) == delimiter ) amt--;
			if ( url.charAt( url.length - 1 ) == delimiter ) amt--;

			return ( amt > 0 ) ? amt : 0;
		}

		/**
		 * @author Sean Lailvaux
		 * 
		 * @param url 			[String] 		The URL you want to use.
		 * @param length 		[int] 			Which path you want to get (first is 0)
		 * @param useDash 		[Boolean] 		Default to false. Set to true to only check against dashes.
		 * 
		 * @return 				[int] 			The amount of paths in the URL.
		 * 
		 * @example 	getPathAt( "one/two/three/", 0 );  		// returns "one"
		 * @example 	getPathAt( "one-two", 1 );   			// returns "one"
		 * @example 	getPathAt( "one-two", 1, true );  		// returns "two"
		 * @example 	getPathAt( "\one\two\three\", 2 ); 		// returns "three"
		 */
		public function getPathAt( url:String, length:int, delimiter:String = "-" ):String
		{
			var ar:Array = [];
			ar = url.split( delimiter );

			if ( delimiter == "/" )
			{
				if ( url.indexOf( "\\" ) != -1 )
				{
					url = url.replace( "\\", "/" );
				}
				ar = url.split( "/" );
			}

			var i:int;
			var len:int = ar.length;
			var count:int = -1;

			for ( i = 0; i < len; ++i )
			{
				if ( ar[i] != "" ) count++;
				if ( count == length )
				{
					return ar[i];
				}
			}
			return "";
		}

		/**
		 * @author Sean Lailvaux
		 * Useful when you have a few strings you need to combine to create a URL,
		 * but may not be fomratted correctly.
		 * 
		 * @param parts [Array] Array of strings
		 * 
		 * @example getURLFromParts( [ "http://example.com", "/en", "\something", "else", ] );
		 * @example 	- returns "http://example.com/en/something/else"
		 */
		public function getURLFromParts( parts:Array ):String
		{
			var i:int;
			var len:int = parts.length;

			var ar:Array = [];
			var part:String;

			for ( i = 0; i < len; ++i )
			{
				part = parts[i];

				if ( part && part != "" )
				{
					part = part.replace( "\\", "/" );

					// strip slashes in front
					if ( part.charAt( 0 ) == "/" && i > 0 )
					{
						part = part.substring( 1, part.length );
					}
					// strip slashes at end
					if ( part.charAt( part.length - 1 ) == "/" )
					{
						part = part.substring( 0, part.length - 1 );
					}

					ar.push( part );
				}
			}

			var url:String = "";

			len = ar.length;
			for ( i = 0; i < len; ++i )
			{
				url += ar[i];
				if ( i < len - 1 )
				{
					url += "/";
				}
			}

			return url;
		}

		/**
		 * @param url 			[String] 		The URL you want to goto.
		 * @param window 		[String] 	    What window type to up in
		 */
		public function getURL( url:String, window:String = "_blank" ):void
		{
			if ( url && url != "" )
			{
				if ( window == null || window.indexOf( "_" ) == -1 )
				{
					window = "_blank";
				}

				try
				{
					navigateToURL( new URLRequest( url ), window );
				}
				catch ( error:Error )
				{
					trace( "Navigate to URL failed", error.message );
				}
			}
		}
	}
}