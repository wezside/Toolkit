/*
	The MIT License

	Copyright (c) 2011 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
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
	public class DateUtil 
	{


		private var _serverTime:Date;
		private var _debug:Boolean = false;
		private var _internalStartTime:Number;
		 		public function DateUtil() 
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
			if ( !serverTime ) serverTime = new Date();
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
		
		public function daysFromMilliseconds( milliseconds:Number ):Number
		{
			var days:Number = milliseconds / 86400000;			
			days %= 365;			
			return int( days ); 	
		}
		
		public function hoursFromMilliseconds( milliseconds:Number ):Number
		{
			var hours:Number = milliseconds / 3600000;
			hours %= 24;
			return int( hours ); 	
		}

		public function minutesFromMilliseconds( milliseconds:Number ):Number
		{
			var minutes:Number = milliseconds / 60000;
			minutes %= 60;						
			return int( minutes ); 	
		}

		public function secondsFromMilliseconds( milliseconds:Number ):Number
		{ 
			var seconds:Number = milliseconds / 1000;
			seconds %= 60;						
			return int( seconds );
		}			
		
		public function toString() : String 
		{
			return getQualifiedClassName( this );
		}
		
		public function calculateStartDayOfTheWeek( d:Date ):Number
		{
			var index:int = -1;
			var theDay:int = d.getDate();
			d.date = 1;
			index = d.getDay();
			d.date = theDay;
			return index;
		}
		
		public function isLeap( date:Date ):Boolean
		{
			return ( date.getFullYear() % 100 ) % 4 == 0;
		}		
		
		public function daysInMonth( y:int, m:int ):int
		{
			return 32 - new Date( y, m, 32 ).getDate();
		}			
	}
}
