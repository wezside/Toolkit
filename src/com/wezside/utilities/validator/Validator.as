package com.wezside.utilities.validator 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Validator 
	{
        
		private var arr:Array = [];        
        public static const MINIMUM_CHARS:int = 8;


		
		public function Validator( arr:Array ) 
		{
			this.arr = arr;
		}

		
		public function getFormIndexByFieldID( id:String ):int
		{
			for ( var k:int = 0; k < arr.length; ++k )
				for ( var i:int = 0; i < arr[k].length; ++i )
					 if ( arr[k][i].name == id )
						return k;		
			return -1;				
		}
		
		public function getIndexByID( id:String ):int
		{
			for ( var k:int = 0; k < arr.length; ++k )
				for ( var i:int = 0; i < arr[k].length; ++i )
					if ( arr[k][i].name == id )
						return i;		
			return -1;				
		}
		
		public function getTextFieldByID( id:String ):*
		{
			for ( var k:int = 0; k < arr.length; ++k )
				for ( var i:int = 0; i < arr[k].length; ++i )
					if ( arr[k][i].name == id )
						return arr[k][i];
		
			return null;				
		}	        
		
		public function getTextFieldValue( id:String ):String
		{
			for ( var k:int = 0; k < arr.length; ++k )
				for ( var i:int = 0; i < arr[k].length; ++i )
					if ( arr[k][i].name == id )
						return arr[k][i].text;
		
			return "";			
		}		                
        
        public function validateEmail( str:String ):Boolean 
        {
            var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var result:Object = pattern.exec(str);
            if ( result == null )
                return false;
            return true;
        }			
        
        public function validateForPunctuation( str:String ):Boolean 
        {
            var pattern:RegExp = /[[:punct:]]/;
            var result:Object = pattern.exec( str );
            if ( result == null  )
                return true;
            return false;
        }
        
        public function validateForNumerical( str:String ):Boolean 
        {
            var pattern:RegExp = /\D/g;
            var result:Object = pattern.exec( str );
            if ( result == null )
                return true;
            return false;
        }
	
		public function validateString( str:String, minLength:int ):Boolean
		{
			return str.length >= minLength;
		}
	
		public function validateStringMaxChars( str:String, maxLength:int ):Boolean
		{
			return str.length < maxLength;
		}
	}
	
}
