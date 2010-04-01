package com.wezside.utilities.date 
{
	import com.wezside.utilities.logging.Tracer;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	/**
	 * A utility class used to determine countdown in the format [seconds, minutes, hours, days ].
	 *  
	 * @author Wesley.Swanepoel
	 */
	public class DateUtils 
	{


		private var _serverTime:Date;
		private var _debug:Boolean = false;
		private var _internalStartTime:Number;
		
		private static var instance:DateUtils;

		
		public static function getInstance():DateUtils 
		{
			if (instance == null)
				instance = new DateUtils( );
				
			return instance;
		}

		 		public function DateUtils() 
		{
			_internalStartTime = getTimer();
		}


		public function convertDate( str:String ):Date
		{
			var dateStr:String = str; 							// 2009-03-13 16:18:24 
			var reg:RegExp = new RegExp( "([\\w]+)", "gi" );
			var result:Array = dateStr.match( reg );

			var date:Date = new Date( Number(result[0]), 
									  (Number(result[1])-1), 
									  Number(result[2]), 
									  Number(result[3]),
									  Number(result[4]), 
									  Number(result[5]) );			
			Tracer.output( debug, " DateUtils.convertDate(" + str + ") " + date , toString() );	
			return date;
		}	
		
		
		public function getCountDown( date:Date ):Array
		{
			var arr:Array = [];
			if ( date != null )
			{
				var timeLeft:Number = date.time - currentDate.time;
				var seconds:Number = Math.floor( timeLeft / 1000 );
				var minutes:Number = Math.floor(seconds / 60);
				var hours:Number = Math.floor(minutes / 60);
				var days:Number = Math.floor(hours / 24);
	
				seconds %= 60;
				minutes %= 60;
				hours %= 24;
									
				if ( minutes == 0 ) minutes = 60;
				if ( hours == 0 ) hours = 24;
				arr = arr.concat( [seconds, minutes, hours, days ] );
			}
			else
			{
				Tracer.output( debug, " DateUtils.getCountDown("+date+") error: Date param is null ", toString(), Tracer.ERROR );
			}
			return arr;							
		}


		
		/**
		 * A simple method to check if the seconds in the Array created by getCountDown() is less than zero. If it is it means 
		 * the date is in the past.
		 */
		public function testLiveDate( date:Date ):Boolean
		{
			return compare( serverTime, date ) == -1 ? false : true; 
		}
		
		
		public function compare( date1:Date, date2:Date ):Number
		{
		    var date1Timestamp:Number = date1.getTime();
		    var date2Timestamp:Number = date2.getTime();
		 	    
		    var result : Number = -1;
			if ( date1Timestamp == date2Timestamp )
		    {
		        result = 0;
		    }
		    else if ( date1Timestamp > date2Timestamp )
		    {
		        result = 1;
		    }
		
		    return result;
		} 

		
		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}


		public function get serverTime():Date
		{
			return _serverTime;
		}
		
		
		public function set serverTime( value:Date ):void
		{
			_serverTime = value;
		}
		

		public function get currentDate():Date
		{
			var currentTime:Number = _serverTime.time + ( getTimer() - _internalStartTime );
			return new Date( currentTime );
		}		
		
		
		public function toString() : String 
		{
			return getQualifiedClassName( this );
		}
	}
}
