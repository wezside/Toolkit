package com.wezside.utilities.string 
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Sean Lailvaux
	 */
	public class URLUtil {
		
		
		/**
		 * @author Sean Lailvaux
		 * 
		 * @param url 			[String] 		The URL you want to check.
		 * @param useDash 		[Boolean] 		Default to false. Set to true to only check against dashes
		 * @return 				[int] 			The amount of paths in the URL
		 * 
		 * @example 	getNumPaths( "one/two/three/" );  	//returns 3		 * @example 	getNumPaths( "one-two" );   		//returns 1		 * @example 	getNumPaths( "one-two", true );   	//returns 2		 * @example 	getNumPaths( "\one\two\three\" );   //returns 3
		 */
		public function getNumPaths( url : String, delimiter:String = "/" ) : int {

			var amt : uint = 0;
			url = url.replace( /\t/g, "/t" );
			url = url.replace( /\n/g, "/n" );
			
			if ( delimiter != "/" )
			{
				url = url.replace( /\W/g, "/" );
				delimiter = "/";
			}

			amt += url.split( delimiter ).length;
			if ( url.charAt(0) == delimiter ) amt--;			if ( url.charAt(url.length-1) == delimiter ) amt--;
			
			return ( amt > 0 ) ? amt : 0;
		}
		
		
		/**
		 * @author Sean Lailvaux
		 * 
		 * @param url 			[String] 		The URL you want to use.
		 * @param length 		[int] 			Which path you want to get (first is 0)		 * @param useDash 		[Boolean] 		Default to false. Set to true to only check against dashes.
		 * @return 				[int] 			The amount of paths in the URL.
		 * 
		 * @example 	getPathAt( "one/two/three/", 0 );  		//returns "one"
		 * @example 	getPathAt( "one-two", 1 );   			//returns "one"		 * @example 	getPathAt( "one-two", 1, true );  		//returns "two"
		 * @example 	getPathAt( "\one\two\three\", 2 ); 		//returns "three"
		 */
		public function getPathAt( url : String, length : int, delimiter:String = "-" ) : String {
			
			
			var ar : Array = [];
			ar = url.split( delimiter );
			
			if ( delimiter == "/" ) 
			{
				if ( url.indexOf( "\\") != -1 ) {
					url = url.replace( "\\", "/" );
				}
				ar = url.split( "/" );
			}
			
			var i : int;
			var len : int = ar.length;
			var count : int = -1;
			
			for ( i=0; i<len; ++i ) {
				if ( ar[i] != "" ) count++;
				if ( count == length ) {
					return ar[i];
				}
			}
			return "";
		}
		
		/**
		 * 
		 * 
		 * @param url 			[String] 		The URL you want to goto.
		 * @param window 		[String] 	    What window type to up in
		 * 
		 */
		public function getURL(url:String, window:String = null):void
        {
            var req:URLRequest = new URLRequest(url);
            
            try {
                navigateToURL(req, window);
            } catch (e:Error) {
                trace("Navigate to URL failed", e.message);
            }
        }
		
		
	}
}