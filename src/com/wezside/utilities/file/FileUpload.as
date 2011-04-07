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
package com.wezside.utilities.file 
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FileUpload extends Sprite
	{

		private var url:String = "http://somedomain.com/uploadscript";
		private var uploadURL:URLRequest;
		private var fileRef:FileReference;
		private var _filename:String;
		private var _file:FileReference;

		
		public function FileUpload( url:String = "" ) 
		{
			if ( url != "" ) this.url = url;	
			_filename = "";
		}

		
		public function getImage( event:MouseEvent = null ):void
		{
			uploadURL = new URLRequest( );
			uploadURL.url = url;
                       			 			
			_file = new FileReference( ); 			
			configureListeners( _file );
			file.browse( getTypes());
		}
		
		public function upload():void
		{
			fileRef.upload( uploadURL );	
		}

		public function get filename():String
		{
			return _filename;
		}
		
		public function set filename( value:String ):void
		{
			_filename = value;
		}
		
		public function get file():FileReference
		{
			return _file;
		}
		
		public function set file( value:FileReference ):void
		{
			_file = value;
		}

		public function destroy():void
		{
			_filename = "";
			removeListeners( _file );
			_file = null;
		}

		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}

		private function selectHandler( event:Event ):void 
		{
			fileRef = FileReference( event.target );
			dispatchEvent( new FileUploadEvent( FileUploadEvent.SELECT ));			
			dispatchEvent( new FileUploadEvent( FileUploadEvent.PROGRESS, false, false, 0 ));
		}	

		private function uploadedFileLoadedIntoMemory( event:Event ):void
		{

		}

		private function getImageTypeFilter():FileFilter 
		{
			return new FileFilter( "Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png" );
		}
		
		private function getTypes():Array 
		{
			var allTypes:Array = new Array( getImageTypeFilter() );
			return allTypes;
		}      
		
		private function configureListeners(dispatcher:IEventDispatcher):void 
		{
			dispatcher.addEventListener( Event.CANCEL, cancelHandler );
			dispatcher.addEventListener( Event.COMPLETE, completeHandler );
			dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			dispatcher.addEventListener( Event.OPEN, openHandler );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			dispatcher.addEventListener( Event.SELECT, selectHandler );
			dispatcher.addEventListener( DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataHandler );
		}
		
		private function removeListeners(dispatcher:IEventDispatcher):void 
		{
			dispatcher.removeEventListener( Event.CANCEL, cancelHandler );
			dispatcher.removeEventListener( Event.COMPLETE, completeHandler );
			dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			dispatcher.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			dispatcher.removeEventListener( Event.OPEN, openHandler );
			dispatcher.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
			dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			dispatcher.removeEventListener( Event.SELECT, selectHandler );
			dispatcher.removeEventListener( DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataHandler );
		}

		private function cancelHandler(event:Event):void 
		{
			trace( "cancelHandler: " + event );
		}

		private function completeHandler( event:Event ):void 
		{
			trace( "completeHandler: " + event );
			dispatchEvent( new FileUploadEvent( FileUploadEvent.COMPLETE ));
		}

		private function uploadCompleteDataHandler( event:DataEvent ):void 
		{
			dispatchEvent( new FileUploadEvent( FileUploadEvent.DATA_COMPLETE, false, false, event.data ));
		}

		private function httpStatusHandler( event:HTTPStatusEvent ):void 
		{
			trace( "httpStatusHandler: " + event );
		}

		private function ioErrorHandler(event:IOErrorEvent):void 
		{
			trace( "ioErrorHandler: " + event );
		}

		private function openHandler(event:Event):void 
		{
			trace( "openHandler: " + event );
		}

		private function progressHandler( event:ProgressEvent ):void 
		{
			var percent:uint = ( event.bytesLoaded / event.bytesTotal ) * 100;
			dispatchEvent( new FileUploadEvent( FileUploadEvent.PROGRESS, false, false, percent ));
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void 
		{
			trace( "securityErrorHandler: " + event );
		}
	}
}
