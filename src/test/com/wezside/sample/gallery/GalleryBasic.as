/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
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
package test.com.wezside.sample.gallery
{
	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.utilities.date.DateUtil;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * <p>A basic example of creating a gallery using the Scaffold-Gallery component. This example
	 * only creates a 4 column and 2 row gallery component with a single row reflection.</p>
	 * 
	 * @author Wesley.Swanepoel
	 * @version 0.1.001
	 */
	public class GalleryBasic extends Sprite 
	{
		
		// Property to hold the FlashVar value of "id"
		protected var id:String;
		
		// Property to hold the FlashVar value of "xmlFile"
		protected var xmlFile:String;
		
		// Points to the ID attribute in the gallery.xml file
		// This way we can target specific galleries within the same XML file. The default is "basic".
		protected static const DEFAULT_ID:String = "basic";
		
		// Default XML file to load should no FlashVar be specified.		
		protected static const DEFAULT_XMLFILE:String = "xml/gallery.xml";
		
		// Number of columns the gallery will have. This could be dynamically set too but for this
		// example we static values. 
		protected static const COLUMNS:uint = 3;
		
		// Number of rows the gallery will require
		protected static const ROWS:uint = 2;
		
		// Array to hold the images to load
		protected var items:Array;
		
		// Instance of the gallery component
		protected var gallery:Gallery;
		
		// XML object to store original loaded data in
		protected var xml:XML;
		
		// Keep a copy of the original deserialized XML data
		protected var original:Array = [];
		
		// The current page index. For this example we assume there is isn't more than one page. 
		protected var currentPageIndex:int = 0;
		
		// Preloader instance
		protected var preloader:Preloader;

		private var dateUtils:DateUtil;
		
		
		public function GalleryBasic():void
		{
			dateUtils = new DateUtil();
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}
		
				
		protected function error( event:IOErrorEvent ):void
		{
			Tracer.output( true, " Some Error occured loading " + xmlFile + ". " + event.text, toString() );
		}
		
		
		/**
		 * <p>Load of gallery XML file complete. Deserialize the gallery items into a dataprovider the Gallery component
		 * understands. Search for the ID node in the XML that matches the id value specified and store these values
		 * into an associative array. This array will be the original and shouldn't change. Copies are made using the 
		 * populateGallery() method.</p>   
		 */
		protected function complete( event:Event ):void
		{
			xml = XML( event.currentTarget.data );
			for each ( var item:XML in xml.section.( @id == id ).gallery.item )
					original.push({ id: item.@id,	
							   		url: item.@url,
							   		livedate: dateUtils.convertDate( item.@livedate || "2001-01-01 00:00:00" ) });
			createGallery();
		}
		
		
		/**
		 * <p>This method resets the dataprovider array and populate it with the items specified in the XML file 
		 * based on the pageIndex. It then creates a new Gallery instance with 4 columns and 2 rows and some additional settings. The gallery items
		 * will be resized to 80 pixels and height.</p> 
		 */
		protected function createGallery():void
		{
			items = [];
			items = populateGallery( currentPageIndex );			
			gallery = new Gallery( items, COLUMNS, ROWS, 2, 2, "left", "custom", 1, 0.3, Gallery.RESIZE_HEIGHT, 80, Gallery.DISTRIBUTE_H, false, 550, 500, true, false );
			gallery.x = 50;
			gallery.y = 30;
			gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, galleryArrangeComplete );
			gallery.create();
			addChildAt( gallery, 0 );
			
			createPreloader();
		}
		
		
		protected function createPreloader():void
		{
			preloader = new Preloader();
			preloader.x = 230;
			preloader.y = 110;
			preloader.start();
			addChild( preloader );
		}

		
		protected function galleryArrangeComplete( event:GalleryEvent ):void
		{
			Tracer.output( true, " SampleBasic.galleryArrangeComplete(event)", toString() );
			preloader.visible = false;
			gallery.visible = true;
		}


		/**
		 * <p>Populate an array with the gallery items specified in the XML file as per the current
		 * page index. For this example the livedate of the item will be in the past. The livedate 
		 * feature is a way to show that some gallery item is coming and not yet completed for this 
		 * sample.</p> 
		 */
		protected function populateGallery( pageIndex:int = 0 ):Array
		{
			var arr:Array = [];
			for ( var i:int = ( pageIndex * ( COLUMNS * ROWS )); i < original.length ; i++ ) 
				if ( arr.length < ( COLUMNS * ROWS ))
					arr.push({ id: original[i].id,	
							   url: original[i].url,
							   livedate: original[i].livedate });							   
			return arr;				
		}		
		
		
		protected function purge():void
		{
			preloader.purge();
			gallery.purge();
			gallery.removeEventListener( GalleryEvent.ARRANGE_COMPLETE, galleryArrangeComplete );
			removeChildAt( 0 );
			removeChild( preloader );
			gallery = null;
			preloader = null;
		}
		
		
		/**
		 * <p>This method is invoked as soon as this has been added to the stage. FlashVars are checked
		 * to see if the HTML container page specified an XML file different to the default which 
		 * is defined by the constants DEFAULT_ID or DEFAULT_XMLFILE.</p>
		 */
		private function stageInit(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
						
			id = this.loaderInfo.parameters.id as String;
			if ( id == null ) id = DEFAULT_ID;
			
			xmlFile = this.loaderInfo.parameters.xmlFile as String;
			if ( xmlFile == null ) xmlFile = DEFAULT_XMLFILE;
			loadXML( xmlFile );
		}
		
		
		private function loadXML( url:String ):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, complete, false, 0, true );
			loader.addEventListener( IOErrorEvent.IO_ERROR, error, false, 0, true );
			loader.load( new URLRequest( url ) );
		}		
	}
}
