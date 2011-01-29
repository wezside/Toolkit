package com.wezside.components.media 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Event(name="loadInit", type="com.wezside.components.media.MediaEvent")]
	[Event(name="loadComplete", type="com.wezside.components.media.MediaEvent")]
	[Event(name="popoutVideo", type="com.wezside.components.media.MediaEvent")]
	public class MediaPlayer extends Sprite 
	{
		
		private static const VIDEO:String = "VIDEO";
		private static const IMAGE:String = "IMAGE";
		private static const SWF:String = ".swf";
		private static const PNG:String = ".png";
		private static const JPG:String = ".jpg";
		private static const GIF:String = ".gif";
		private static const FLV:String = ".flv";
		private static const VIDEO_YOUTUBE:String = "YOUTUBE";


		private var _columns:int = 3;
		private var _rows:int = 2;
		private var _dataprovider:Array;
		private var _currentIndex:int;
		private var _original:Array;
		private var _total:uint;
		private var _thumbWidth:int = 80;
		private var _thumbHeight:int = 53;
		private var bg:Sprite;
		private var mediaContainer:Sprite;
		private var _selectedIndex:int;
		private var loader:Loader;
		private var imgHero:Boolean;
		private var imgHeight:int;
		private var imgWidth:int;
		private var _bgWidth:int = 350;
		private var _bgHeight:int = 200;

		public function get columns():int
		{
			return _columns;
		}

		public function set columns( value:int ):void
		{
			_columns = value;
		}

		public function get rows():int
		{
			return _rows;
		}

		public function set rows( value:int ):void
		{
			_rows = value;
		}

		public function get thumbWidth():int
		{
			return _thumbWidth;
		}

		public function set thumbWidth( value:int ):void
		{
			_thumbWidth = value;
		}

		public function get thumbHeight():int
		{
			return _thumbHeight;
		}

		public function set thumbHeight( value:int ):void
		{
			_thumbHeight = value;
		}

		public function get bgWidth():int
		{
			return _bgWidth;
		}
		
		public function set bgWidth( value:int ):void
		{
			_bgWidth = value;
		}
		
		public function get bgHeight():int
		{
			return _bgHeight;
		}
		
		public function set bgHeight( value:int ):void
		{
			_bgHeight = value;
		}

		public function purge():void
		{
			for each ( var item:Youtube in mediaContainer )
				item.purge();
		}

		public function set dataprovider( value:Array ):void
		{
			if ( value.length > 0 )
			{
				bg = new Sprite( );
				bg.graphics.beginFill( 0x666666 );
				bg.graphics.drawRoundRect( 0, 0, bgWidth, bgHeight, 10 );
				bg.graphics.endFill( );
				addChild( bg );
									
				mediaContainer = new Sprite( );
				addChildAt( mediaContainer, 1 );
				
				var hero:Array = [];
				hero.push( value[0] );
				_dataprovider = [];
				_dataprovider = hero.concat( _dataprovider.concat( value ) );
				_total = _dataprovider.length;
				_original = [];
				_original = _original.concat( _dataprovider );			
				_currentIndex = 0;			
				alpha = 0;
			
				load( _dataprovider[0].url, width - 10, height - 40, true );
			}
		}

		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		[Bindable]
		public function set selectedIndex( value:int ):void
		{
			_selectedIndex = value;
		}
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
		
		
		private function load( url:String, newWidth:int, newHeight:int, isHero:Boolean = false ):void
		{
			switch ( getFileType( url ))
			{
				case IMAGE: loadImage( _original[0].url, newWidth, newHeight, isHero ); break;
				case VIDEO_YOUTUBE: loadYoutubeVideo( _original[0].url, newWidth, newHeight, isHero ); break;
			}
		}


		private function loadImage( url:String, width:int, height:int, isHero:Boolean ):void 
		{
			imgWidth = width;
			imgHeight = height;
			imgHero = isHero;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, error );
			loader.load( new URLRequest( url ));	
		}


		private function error( event:IOErrorEvent ):void 
		{
		}


		private function complete( event:Event ):void 
		{
			var index:int = ( _total - _original.length );
			var bitmap:Bitmap = new Bitmap( event.currentTarget.content.bitmapData );
			bitmap.smoothing = true;
			bitmap.width = imgHero ? width - 10 : _thumbWidth;
			bitmap.height = imgHero ? height - 10 : _thumbHeight;
			var bitmapContainer:Sprite = new Sprite();
			bitmapContainer.addChild( bitmap );
			bitmapContainer.addEventListener( MouseEvent.CLICK, mediaClick );
			bitmapContainer.buttonMode = true;
			mediaContainer.addChildAt( bitmapContainer, imgHero ? 0 : index );
			
			bitmapContainer.alpha = 0.5;			
			bitmapContainer.visible = true;			
			_original.shift( );
			_original.length > 0 ? load( _original[0].url, _thumbWidth, thumbHeight ) : loadComplete();			
		}

		
		private function loadYoutubeVideo( url:String, width:int, height:int, isHero:Boolean = false ):void
		{
			dispatchEvent( new MediaEvent( MediaEvent.LOAD_INIT ));
			
			var pattern:RegExp = /\=.[0-9a-zA-Z_]+/;
			var videoURL:String = url;
			var videoURLMatch:Array = videoURL == null ? [] : videoURL.match( pattern );					
			var video:Youtube = new Youtube( );
			var index:int = ( _total - _original.length );
			video.controlsScale = 0.8;
			video.controls = isHero;
			video.enablePopoutButton = true;
			video.name = isHero ? "0" : index.toString( );
			video.videoWidth = width;
			video.videoHeight = height;			
			video.alpha = 0;			
			video.videoID = String( videoURLMatch[0] ).substring( 1 );
			video.addEventListener( YoutubeEvent.VIDEO_CUED, videoLoaded );
			
			if ( !isHero )
			{
				var videoMask:Sprite = new Sprite( );
				videoMask.graphics.beginFill( 0xff0000 );
				videoMask.graphics.drawRect( 0, 0, width, height );
				videoMask.graphics.endFill( );
				videoMask.mouseEnabled = false;
				video.addChild( videoMask );				
				video.mask = videoMask;
				video.mouseChildren = false;
				video.buttonMode = true;						
				video.addEventListener( MouseEvent.CLICK, mediaClick );
			}
			else
			{
				video.addEventListener( MediaEvent.POPOUT_VIDEO, popoutVideo );
			}
			mediaContainer.addChildAt( video, isHero ? 0 : index );
		}

		
		private function videoLoaded( event:YoutubeEvent ):void
		{
			event.target.removeEventListener( YoutubeEvent.VIDEO_CUED, videoLoaded );
			event.target.alpha = 1;			
			event.target.visible = true;			
			_original.shift( );
			_original.length > 0 ? load( _original[0].url, _thumbWidth, thumbHeight ) : loadComplete( );
		}		
		
		private function popoutVideo(event:MediaEvent):void 
		{
			dispatchEvent( event );
		}

		
		private function arrange():void
		{
			var yOffset:int = 0;
			for ( var i:int = 0; i < mediaContainer.numChildren; ++i ) 
			{
				var item:DisplayObject = mediaContainer.getChildAt( i );
				if ( i == 0 )
				{
					item.x = 5;
					item.y = 5;	
					yOffset = 300;
				}
				else
				{
					item.x = ( i - 1 ) * ( _thumbWidth + 12 );
					item.y = bg.height + 10;
				
				}
			}
		}

		
		private function mediaClick( event:MouseEvent ):void 
		{
		
			_selectedIndex = int( event.target.name );
			var child:DisplayObject = mediaContainer.getChildAt( 0 );
			
			if ( mediaContainer.getChildIndex( event.currentTarget as DisplayObject ) != 0 )
			{
				child.alpha = 0;
				child.visible = false;
				switchHero( _selectedIndex );
			}
			else
			{
				if ( child is Youtube ) Youtube( child ).play( );
				if ( child is Sprite && _dataprovider[0].href ) navigateToURL( new URLRequest( _dataprovider[0].href ));
			}
		}

		
		private function switchHero( _selectedIndex:int ):void
		{
			dispatchEvent( new MediaEvent( MediaEvent.LOAD_INIT ) );
			_original = [];
			_original = _original.concat( _dataprovider );
			_original = _original.slice( _selectedIndex, _selectedIndex + 1 );
			var child:DisplayObject = mediaContainer.getChildAt( 0 );
			if ( child is Youtube ) Youtube( child ).purge( );
			mediaContainer.removeChildAt( 0 );
			load( _original[0].url, bg.width - 10, bg.height - 40, true );	
			_currentIndex = _selectedIndex;
		}

		
		private function loadComplete():void 
		{
			arrange( );
			this.alpha = 1;
			this.visible = true;
			dispatchEvent( new MediaEvent( MediaEvent.LOAD_COMPLETE ) );
		}

		
		private function getFileType( url:String ):String 
		{
			switch ( url.substring( url.lastIndexOf( "." ) ).toLowerCase( ))
			{
				case SWF: 
					return SWF; 
				case PNG: 
					return IMAGE; 
				case JPG: 
					return IMAGE; 
				case GIF: 
					return IMAGE; 
				case FLV: 
					return VIDEO; 
			}
			
			var pattern:RegExp = /\=.[0-9a-zA-Z_]+/;
			var videoURL:String = url;
			var videoURLMatch:Array = videoURL == null ? [] : videoURL.match( pattern );
			return String( videoURLMatch[0] ).substring( 1 ) ? VIDEO_YOUTUBE : "";
		}		
	}
}
