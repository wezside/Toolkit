package com.wezside.components.social 
{
	import flash.events.Event;

	import com.wezside.components.UIElement;

	import flash.system.Security;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SocialGigya extends UIElement 
	{

		private var conf:Object = {};
		private var params:Object = {};
		private var _apiKey:String = "2_Y82PzwJ_chSFImHXaIDJClnLyJzmk-VFOavSsaNTzl6m901s_NNxRAS0xJ3bd3_N"; 
		private var _contextID:String = "Gigya Custom Widget Test";

		public function SocialGigya() 
		{
			Security.allowDomain( "cdn.gigya.com" );
			Security.allowInsecureDomain( "cdn.gigya.com" );			
			
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		private function stageInit(event:Event):void 
		{
			build( );
			setStyle( );
			arrange( );			
		}

		override public function build():void 
		{
			conf.APIKey = _apiKey;
			conf.mcRoot = this.root;
			conf.enabledProviders = "facebook";
			conf.cid = _contextID;
			
			params.services = "socialize";
			params.callback = gigyaInitialized;
			
			gigya.load( conf, params );
			super.build( );
		}

		public function get contextID():String
		{
			return _contextID;
		}

		public function set contextID( value:String ):void
		{
			_contextID = value;
		}

		
		private function gigyaInitialized( response:Object ):void
		{
			if ( response.hadError ) 
			{  
				trace( "An error has occurred while attemting to load Socilaize service" );  
				trace( response.errorMessage );
			} 
			else 
			{    
				trace( "Successful intialization of Gigya" );  
				
				var paramsConnect:Object = {  
				     callback: onConnect, provider: "facebook", cid: _contextID
				};        
				gigya.services.socialize.addConnection( conf, paramsConnect );  				
			}  
		}

		private function onConnect( response:Object ):void
		{
			if ( response.errorCode == 0 )
			{
 				var user:Object = response.user;  
        		var msg:String = 'User '+user.nickname + ' is ' +user.age + ' years old';  
        		trace(msg);  
			} 
			else 
			{
				//handle errors
				trace( "An error has occurred!" + '\n' + "Error details: " + response.errorMessage + '\n' + "In method: " + response.operation );
			}			
		}
	}
}
