package com.wezside.components.media
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	[DefaultProperty("children")]
	public class Youtube extends Sprite 
	{

		private var loader:Loader;
		private var player:Object;

		private var _videoID:String = "";
		private var _videoWidth:Number = 240;
		private var _videoHeight:Number = 180;
		private var _autoPlay:Boolean = false;
		private var _controls:Boolean = true;


		private static const DEBUG:Boolean = false;
		private var bar:Sprite;
		private var indicator:Sprite;
				
		[Embed(source="/../resource/swf/library.swf", symbol="PlayButton")]
		private var PlayButtonClass:Class;
		
		[Embed(source="/../resource/swf/library.swf", symbol="PauseButton")]
		private var PauseButtonClass:Class;

		[Embed(source="/../resource/swf/library.swf", symbol="MuteButton")]
		private var MuteButtonClass:Class;

		[Embed(source="/../resource/swf/library.swf", symbol="MuteButtonSelected")]
		private var MuteButtonSelectedClass:Class;

		[Embed(source="/../resource/swf/library.swf", symbol="PopOutButton")]
		private var PopOutButtonClass:Class;
		
		private var playButton:SimpleButton;
		private var pauseButton:SimpleButton;
		private var muteButton:SimpleButton;
		private var muteSelectedButton:SimpleButton;
		private var _controlsScale:Number = 1;
		private var popOutButton:SimpleButton;
		private var _enablePopoutButton:Boolean;

		
		public function Youtube()
		{
			Security.allowInsecureDomain("*");
			Security.allowDomain("*");
		}

		
		public function init( event:Event = null ):void
		{
			// This will hold the API player instance once it is initialized.
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.INIT, onLoaderInit );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, error );
			loader.load( new URLRequest( "http://www.youtube.com/apiplayer?version=3" ) );		
		}

		
		public function createProgressControl():void 
		{			
			var controlPadding:int = 5;
			playButton = new PlayButtonClass() as SimpleButton;
			playButton.name = "play";
			playButton.scaleX = playButton.scaleY = _controlsScale;
			playButton.visible = false;			
			playButton.x = 0;
			playButton.y = _videoHeight + 5 * _controlsScale;
			playButton.addEventListener( MouseEvent.CLICK, controlsHandler );
			addChild( playButton );
			
			pauseButton = new PauseButtonClass() as SimpleButton;
			pauseButton.scaleX = pauseButton.scaleY = _controlsScale;
			pauseButton.name = "pause";
			pauseButton.x = playButton.x;
			pauseButton.y = playButton.y;
			pauseButton.addEventListener( MouseEvent.CLICK, controlsHandler );
			addChild( pauseButton );

			var barWidth:int = 0;
			if ( _enablePopoutButton ) 
				barWidth = _videoWidth - (( playButton.x * 3 ) + playButton.width * 3 + controlPadding * 3);
			else
				barWidth = _videoWidth - (( playButton.x * 2 ) + playButton.width * 2 + controlPadding * 2);
			bar = new Sprite();
			bar.graphics.beginFill( 0xcccccc );
			bar.graphics.drawRoundRect(0, 0, barWidth, 6, 3 );
			bar.graphics.endFill();
			bar.x = playButton.x + playButton.width + controlPadding;
			addChild( bar );
			bar.y = int( playButton.y + playButton.height * 0.5 - bar.height * 0.5 );
			
			indicator = new Sprite();
			indicator.scaleX = indicator.scaleY = _controlsScale;
			indicator.graphics.beginFill( 0xdd4995 );
			indicator.graphics.drawCircle(0, 0, 3 );
			indicator.graphics.endFill( );
			indicator.x = 43;
			indicator.y = bar.y + 3;
			addChild( indicator );
			
			muteButton = new MuteButtonClass() as SimpleButton;
			muteButton.name = "mute";
			muteButton.scaleX = muteButton.scaleY = _controlsScale;
			muteButton.x = bar.x + bar.width + 5;
			muteButton.y = _videoHeight + 5;
			muteButton.addEventListener( MouseEvent.CLICK, controlsHandler );
			
			muteSelectedButton = new MuteButtonSelectedClass() as SimpleButton;
			muteSelectedButton.name = "muteSelected";
			muteSelectedButton.scaleX = muteSelectedButton.scaleY = _controlsScale;
			muteSelectedButton.visible = false;
			muteSelectedButton.x = muteButton.x;
			muteSelectedButton.y = muteButton.y;
			muteSelectedButton.addEventListener( MouseEvent.CLICK, controlsHandler );
			
			popOutButton = new PopOutButtonClass() as SimpleButton;
			popOutButton.name = "popOutButton";
			popOutButton.scaleX = popOutButton.scaleY = _controlsScale;
			popOutButton.x = muteButton.x + muteButton.width + controlPadding;
			popOutButton.y = muteButton.y;
			popOutButton.addEventListener( MouseEvent.CLICK, expandVideo );
			popOutButton.visible = _enablePopoutButton;
									
			addChild( muteButton );
			addChild( muteSelectedButton );
			addChild( popOutButton );
		}

		public function get enablePopoutButton():Boolean
		{
			return _enablePopoutButton;
		}
		
		[Bindable]
		public function set enablePopoutButton( value:Boolean ):void
		{
			_enablePopoutButton = value;
			if ( popOutButton ) popOutButton.visible = _enablePopoutButton;
		}

		public function get controlsScale():Number
		{
			return _controlsScale;
		}
		
		public function set controlsScale( value:Number ):void
		{
			_controlsScale = value;
		}
		
		private function error(event:IOErrorEvent):void 
		{
		}	


		private function expandVideo(event:MouseEvent):void 
		{
			player.pauseVideo();
			var pattern:RegExp = /\=.[0-9a-zA-Z_]+/;
			var videoURL:String =  player.getVideoUrl();
			var videoURLMatch:Array = videoURL == null ? [] : videoURL.match( pattern );			
			var youtubeID:String = videoURLMatch && videoURLMatch.length > 0 ? String( videoURLMatch[0] ).substring( 1 ) : "";
			dispatchEvent( new MediaEvent( MediaEvent.POPOUT_VIDEO, false, false, null, youtubeID ));
		}
		

		private function controlsHandler( event:MouseEvent ):void 
		{
			if ( event.target.name == "mute")
			{
				muteButton.visible = false;			
				muteSelectedButton.visible = true;
				player.mute();			
			}
			if ( event.target.name == "muteSelected")
			{
				muteButton.visible = true;			
				muteSelectedButton.visible = false;
				player.unMute();
				player.setVolume( 100 );
			}
			if ( event.target.name == "play")
			{
				playButton.visible = false;			
				pauseButton.visible = true;
				player.playVideo();
			}
			if ( event.target.name == "pause")
			{
				playButton.visible = true;			
				pauseButton.visible = false;
				player.pauseVideo();
			}
		}

		
		private function onLoaderInit( event:Event ):void 
		{
			if ( loader && loader.content )
			{
				loader.content.addEventListener( "onReady", onPlayerReady );
				loader.content.addEventListener( "onError", onPlayerError );
				loader.content.addEventListener( "onStateChange", onPlayerStateChange );
				loader.content.addEventListener( "onPlaybackQualityChange", onVideoPlaybackQualityChange );
				if ( _controls ) createProgressControl();
			}
		}

		private function onPlayerReady( event:Event ):void 
		{

			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			addChild( loader );
			player = {};
			player = loader.content;
			player.setSize( _videoWidth, _videoHeight );
			
			if ( _autoPlay )
				player.loadVideoById( _videoID, 0, "medium" );
			else
			{
				player.cueVideoById( _videoID, 0, "medium" );
			}
		}
		
		private function traceDisplayList( container:DisplayObjectContainer, indentString:String = "" ):void
		{
		    var child:DisplayObject;
		    for ( var i:uint=0; i < container.numChildren; i++ )
		    {
		        child = container.getChildAt(i);
		        trace( indentString, "|" + child + "| " + child.name ); 
		        if ( container.getChildAt(i) is DisplayObjectContainer )
		            traceDisplayList( DisplayObjectContainer( child ), indentString + "    ");
		
		    }
		}			
		
		public function purge():void
		{
			if ( loader && loader.content )
			{		
				removeChild( loader );
				loader.contentLoaderInfo.removeEventListener( Event.INIT, onLoaderInit );
				loader.content.removeEventListener( "onReady", onPlayerReady );
				loader.content.removeEventListener( "onError", onPlayerError );
				loader.content.removeEventListener( "onStateChange", onPlayerStateChange );
				loader.content.removeEventListener( "onPlaybackQualityChange", onVideoPlaybackQualityChange );
			}
			removeEventListener( Event.ENTER_FRAME, enterFrame );
			loader = null;
			if ( player )
			{
				player.destroy();
				player = null;
			}
		}
		
		public function get controls():Boolean
		{
			return _controls;
		}
		
		public function set controls( value:Boolean ):void
		{
			_controls = value;
		}
		
		public function get videoWidth():Number
		{
			return _videoWidth;
		}
		
		[Bindable]
		public function set videoWidth( value:Number ):void
		{
			_videoWidth = value;
			if ( player ) player.setSize( _videoWidth, _videoHeight );
		}

		public function get videoHeight():Number
		{
			return _videoHeight;
		}
		
		[Bindable]
		public function set videoHeight( value:Number ):void
		{
			_videoHeight = value;
			if ( player ) player.setSize( _videoWidth, _videoHeight );
		}
		
		public function get videoID():String
		{
			return _videoID;
		}
		
		public function set videoID( value:String ):void
		{
			_videoID = value;
			if ( _videoID && _videoID != "" ) init();
		}
		
		public function get autoPlay():Boolean
		{
			return _autoPlay;
		}
		
		public function set autoPlay( value:Boolean ):void
		{
			_autoPlay = value;
		}
		
		public function play():void
		{
			player.playVideo();
		}

		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}

		private function onPlayerError( event:Event ):void 
		{
		}

		private function onPlayerStateChange(event:Event):void 
		{
			// Event.data contains the event parameter, which is the new player state
			// Video Cued
			if ( Object( event ).data == 5 )
			{
				//player.seekTo( 0.1, true );
				//player.pauseVideo();
				dispatchEvent( new YoutubeEvent( YoutubeEvent.VIDEO_CUED, false, false, 5  ));
			}
				
			// Playing
			if ( Object( event ).data == 1 )
				addEventListener( Event.ENTER_FRAME, enterFrame );
				
			// Complete
			if ( Object( event ).data == 0 )
			{
				removeEventListener( Event.ENTER_FRAME, enterFrame );
				dispatchEvent( new YoutubeEvent( YoutubeEvent.VIDEO_PLAYBACK_COMPLETE, false, false, 0  ));
			}

			// Playing
			if ( Object( event ).data == -1 || Object( event ).data == 2 )
				removeEventListener( Event.ENTER_FRAME, enterFrame );
		}


		private function enterFrame( event:Event ):void 
		{
			indicator.x = int( player.getCurrentTime() / player.getDuration() * 325 ) + 43;
		}

		private function onVideoPlaybackQualityChange(event:Event):void 
		{
			// Event.data contains the event parameter, which is the new video quality
		}		
		
		
	}
}
