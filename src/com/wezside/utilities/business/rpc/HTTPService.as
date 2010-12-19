package com.wezside.utilities.business.rpc 
{
	import com.wezside.utilities.business.IResponder;
	import com.wezside.utilities.business.ResponderEvent;
	import com.wezside.utilities.logging.Tracer;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version .326
	 */
	public class HTTPService extends EventDispatcher implements IService 
	{
		
	    public static const RESULT_FORMAT_E4X:String = "e4x";
	    public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
	    public static const RESULT_FORMAT_OBJECT:String = "object";
	    public static const RESULT_FORMAT_ARRAY:String = "array";
	    public static const RESULT_FORMAT_TEXT:String = "text";
	    public static const RESULT_FORMAT_XML:String = "xml";
	    public static const CONTENT_TYPE_XML:String = "application/xml";
	    public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
	    public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
	    public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
	    public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
	    public static const ERROR_DECODING:String = "Client.CouldNotDecode";
	    public static const ERROR_ENCODING:String = "Client.CouldNotEncode";
	    
	    public static const GET_METHOD:String = "GET";
	    public static const POST_METHOD:String = "POST";
	    
		private var _url:String;
		private var _loader:URLLoader;
		private var _request:URLRequest;
		private var _resultFormat:String;
		private var _responder:IResponder;
		private var _requestHeaders:Array = [];    	
		private var _method:String = POST_METHOD;
		private var _contentType:String = CONTENT_TYPE_FORM;
		private var _loaded:Boolean;
		private var _debug:Boolean;
		private var _asyncToken:Number;
		private var _id:String;

		public function HTTPService() 
		{
			_loaded = true;
		}

		public function send( params:Object = null, operationID:String = "" ):Boolean
		{
			_request = new URLRequest( _url );
			_loader = new URLLoader( _request );
			_request.contentType = _contentType;
			_request.url = _url;
			_request.data = params;
			_request.requestHeaders = _requestHeaders;
			_loader.addEventListener( Event.COMPLETE, result );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, fault );
			_loader.load( _request );
			return true;
		}
	
		public function loadWSDL(uri:String = null):void {}
		
		public function purge():void
		{
			if ( _loader )
			{
				_loader.removeEventListener( Event.COMPLETE, result );
				_loader.removeEventListener( IOErrorEvent.IO_ERROR, fault);
			}
			_responder = null;
			_request = null;
			_loader = null;								
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}		
		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function set loaded( value:Boolean ):void
		{
			_loaded = value;
		}
	
		public function get responder():IResponder
		{
			return _responder;
		}
				
		public function set responder( value:IResponder ):void
		{
			_responder = value;
		}
		
		public function get headers():Array
		{
			return _requestHeaders;
		}
		
		public function set headers( value:Array ):void
		{
			_requestHeaders = value;
		}		
		
		public function get resultFormat():String
		{
			return _resultFormat;
		}
				
		public function set resultFormat( value:String ):void
		{
			_resultFormat = value;
		}
				
		public function get url():String
		{
			return _url;
		}		
		
		public function set url( value:String ):void
		{
			_url = value;
		}		
		
		public function get contentType():String
		{
			return _contentType;
		}
				
		public function set contentType( value:String ):void
		{
			_contentType = value;
		}		
		
		public function get method():String
		{
			return _method;
		}		
		
		public function set method( value:String ):void
		{
			_method = value;
		}
		
		public function get wsdl():String
		{
			return "";
		}
		
		public function set wsdl( value:String ):void
		{
		}
		
		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}
		
		public function get asyncToken():Number
		{
			return _asyncToken;
		}
		
		public function set asyncToken(value:Number):void
		{
			_asyncToken = value;
		}			
		
		override public function toString() : String 
		{
			return getQualifiedClassName( this );
		}		
		
		private function fault( event:IOErrorEvent ):void
		{
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, fault);			
			Tracer.output( _debug, " HTTPService.FaultEvent(event) " + event.text, toString() );
			if ( _responder != null )
			{
				_responder.fault( new ResponderEvent( ResponderEvent.FAULT, false, false, {id: id, content: event.text }));
			}
			else
			{
				dispatchEvent( new ResponderEvent( ResponderEvent.FAULT, false, false, {id: id, content: event.text }));
			}				
		}

		
		private function result( event:Event ):void
		{
			_loader.removeEventListener( Event.COMPLETE, result );
			Tracer.output( _debug, " HTTPService.ResultEvent(event)", toString() );
			if ( _responder != null )
			{
				_responder.result( new ResponderEvent( ResponderEvent.FAULT, false, false, {id: id, content: _loader.data }));
			}
			else
			{
				dispatchEvent( new ResponderEvent( ResponderEvent.FAULT, false, false, { id: id, content: _loader.data }));
			}				
		}
	}
}
