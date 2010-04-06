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
package com.wezside.components.gallery 
{
	import com.wezside.utilities.date.DateUtils;
	import com.wezside.utilities.file.FileUtils;
	import com.wezside.utilities.imaging.ImageResize;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.2.0020
	 */
	public class Gallery extends Sprite 
	{

		
		private var rows:int;
		private var columns:int;
		private var items:Array = [];
		private var original:Array = [];
		private var currentRow:int;
		private var totalpages:Number;
		private var total:uint;
		private var dateUtils:DateUtils;
		private var largestItemWidth:Number = 0;
		private var largestItemHeight:Number = 0;
		
		// Constructor values
		private var horizontalGap:int;
		private var verticalgap:int;
		private var xOffset:Number;
		private var yOffset:Number;
		private var resizePolicy:String;
		private var resizeValue:Number;
		private var startX:int;
		private var reflectionHeightInRows:int;
		private var reflectionAlpha:Number;
		private var distributePolicy:String;
		private var target:String;
		private var horizontalAlign:String;
		private var thumbEnabled:Boolean;
		private var showArrangement:Boolean;
		
		// Getters and setters 
		private var _debug:Boolean;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _galleryItemClassList:Dictionary;

		public static const ITEM_SWF:String = "itemSWF";
		public static const ITEM_BLANK:String = "itemBlank";
		public static const ITEM_VIDEO:String = "itemVideo";
		public static const ITEM_IMAGE:String = "itemImage";
		public static const ITEM_COUNTDOWN:String = "itemCountdown";
		public static const ITEM_REFLECTION:String = "itemReflection";
		
		public static const RESIZE_WIDTH:String = "resizeToWidth";
		public static const RESIZE_HEIGHT:String = "resizeToHeight";
		public static const DISTRIBUTE_H:String = "distributeHorizontally";
		public static const DISTRIBUTE_V:String = "distributeVertically";
		public static const LEFT:String = "left";
		public static const CENTER:String = "center";
		
		public static const BLANK:String = "";
		public static const OVERLAY:String = "overlay";
		public static const LIGHTBOX:String = "lightbox";
		public static const VERSION:String = "0.2.0020";

		
		
		public function Gallery( dataprovider:Array, 
								 columns:int = 4, 
								 rows:int = 3, 
								 xOffset:int = 0, 
								 yOffset:int = 0, 
								 horizontalGap:int = 0, 
								 verticalgap:int = 0,
								 horizontalAlign:String = "left",
								 target:String = "",
								 reflectionHeightInRows:int = 0,
								 reflectionAlpha:Number = 0.3,
								 resizePolicy:String = "",
								 resizeValue:Number = -1,
								 distributePolicy:String = "",
								 showArrangement:Boolean = false,
								 stageWidth:Number = 550,
								 stageHeight:Number = 500,
								 thumbEnabled:Boolean = true,
								 debug:Boolean = false ) 
		{
			
			items = [];
			items = items.concat( dataprovider );	
			this.rows = rows;
			this.columns = columns;			
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			this.target = target;			
			this.horizontalAlign = horizontalAlign;
			this.horizontalGap = horizontalGap;
			this.verticalgap = verticalgap; 
			this.resizePolicy = resizePolicy;
			this.resizeValue = resizeValue;
			this.distributePolicy = distributePolicy;
			this.reflectionHeightInRows = reflectionHeightInRows;
			this.reflectionAlpha = reflectionAlpha;
			this.thumbEnabled = thumbEnabled;
			this.showArrangement = showArrangement;
			
			_debug = debug;
			_stageWidth = stageWidth;
			_stageHeight = stageHeight;
			_galleryItemClassList = new Dictionary();
			_galleryItemClassList[ ITEM_VIDEO ] = FLVGalleryItem;
			_galleryItemClassList[ ITEM_BLANK ] = BlankGalleryItem;
			_galleryItemClassList[ ITEM_IMAGE ] = ImageGalleryItem;
			_galleryItemClassList[ ITEM_COUNTDOWN ] = CountdownGalleryItem;
			
			startX = xOffset;
			currentRow = 0;
			visible = showArrangement;
			totalpages = Math.ceil( items.length / ( columns * rows )); 
			
			Tracer.output( _debug, " Gallery() totalpages: " + totalpages, toString() );
			
			var totalItems:Number = (( columns * rows * totalpages - 1 ) - ( items.length - 1 ));
			Tracer.output( _debug, " Gallery() totalItems: " + totalItems, toString() );
			
			if ( items.length < ( columns * rows * totalpages ))
				for ( var i:int = 0; i < totalItems ; i++ )
					items.push( { id: "blank_" + i, url: "", livedate: new Date() });
			
			total = items.length;			
			original = original.concat( items );
			
			if ( items.length == 0 )
				throw new Error( "Error: No items in dataprovider." );
			
			dateUtils = DateUtils.getInstance();
			addEventListener( Event.ADDED_TO_STAGE, create );
		}
		
				
		public function purge():void
		{
			for each ( var item:IGalleryItem in this )
			{
				item.purge();
				item.removeEventListener( Event.ENTER_FRAME, enterFrame );
				item.removeEventListener( GalleryEvent.ITEM_ERROR, itemError );
				item.removeEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );
				removeChild( item as DisplayObject );
			}
		}

		
		public function start( trans:IGalleryTransition = null ):void
		{
		}
		

		public function intro( trans:IGalleryTransition = null ):void
		{
			if ( trans )
			{
				trans.addEventListener( GalleryEvent.INTRO_COMPLETE, transitionComplete );
				trans.intro();
			}
			else
			{
				transitionComplete( new GalleryEvent( GalleryEvent.INTRO_COMPLETE ));
			}
		}

		
		public function outro( trans:IGalleryTransition = null ):void
		{
			if ( trans )
			{
				trans.addEventListener( GalleryEvent.OUTRO_COMPLETE, transitionComplete );
				trans.outro();
			}
			else
			{
				transitionComplete( new GalleryEvent( GalleryEvent.OUTRO_COMPLETE ));
			}
		}
			

		public function get stageWidth():Number
		{
			return _stageWidth;
		}
		
		
		public function set stageWidth( value:Number ):void
		{
			_stageWidth = value;
		}
		
		
		public function get stageHeight():Number
		{
			return _stageHeight;
		}
		
		
		public function set stageHeight( value:Number ):void
		{
			_stageHeight = value;
		}
		
		
		public function getRowHeight( row:uint ):Number
		{
			return ( row * verticalgap ) * largestItemHeight * 0.5;
		}


		public function get galleryItemClassList():Dictionary
		{
			return _galleryItemClassList;
		}
		
		
		public function set galleryItemClassList( value:Dictionary ):void
		{
			_galleryItemClassList = value;
		}
		
		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}


		/**
		 * A method to determine which type of video wall item to create. The date retrieved is 
		 * the difference between the server time and the livedate attribute specified in the XML node
		 * for each video within the football hd module. The format is [seconds, minutes, hours, days ]. 
		 */
		public function create( event:Event = null ):void
		{
			if( items.length != 0 )
			{
				var date:Date = original[ int( total - items.length ) ].livedate;
				switch ( FileUtils.getFileExtension( items[0].url ))
				{
					case "jpg":				
					case "png":				
					case "gif": dateUtils.testLiveDate( date ) ? createItem( ITEM_IMAGE ) : createItem( ITEM_COUNTDOWN ); break;						
					case "flv":
					case "mov":
					case "f4v": dateUtils.testLiveDate( date ) ? createItem( ITEM_VIDEO ) : createItem( ITEM_COUNTDOWN ); break;
					default: createItem( ITEM_BLANK ); break;
				}
			}
		}		
		
		
		private function createItem( type:String ):void
		{		
			var ItemClass:Class = galleryItemClassList[ type ] as Class;
			var item:IGalleryItem = new  ItemClass( type, _debug ) as IGalleryItem;
			item.addEventListener( GalleryEvent.ITEM_ERROR, itemError );
			item.addEventListener( GalleryEvent.ITEM_PROGRESS, itemProgress );
			item.addEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );
			item.load( items[0].url, items[0].livedate );						
		}

		
		private function itemError( event:GalleryEvent ):void
		{
			Tracer.output( _debug, " Gallery.itemError(event) " + event.data, toString(), Tracer.ERROR );
			createItem( ITEM_BLANK );	
		}
		
		
		private function itemProgress( event:GalleryEvent ):void
		{
			Tracer.output( _debug, " Gallery.itemProgress(" + event.data + ")", toString() );
			dispatchEvent( event );
			if ( int( event.data ) == 100 ) 
				IGalleryItem( event.currentTarget ).removeEventListener( GalleryEvent.ITEM_PROGRESS, itemLoaded );
		}

		
		/**
		 * <p>The gallery item was successfully loaded. A few things happens here:
		 * <ul> 
		 * <li>the default properties for each item is set</li>
		 * <li>The item is resized to what the resize policy might be</li>
		 * <li>Distribution alignment is done</li>
		 * <li>Reflection is created depending on reflactionAlpha and reflectionHeightnRows values</li>
		 * <li>Item is added to stage</li>
		 * <li>Creation is continued if more items are left in dataprovider</li>
		 * </ul>
		 * 	</p>
		 */
		private function itemLoaded( event:GalleryEvent ):void
		{
			IGalleryItem( event.currentTarget ).removeEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );

			// Set default item properties
			var index:int = total - items.length;
			var item:Sprite = event.currentTarget as Sprite;
			if ( thumbEnabled )
			{
				item.buttonMode = true;
				item.useHandCursor = true;
				item.addEventListener( MouseEvent.ROLL_OUT, itemRollOut );		
				item.addEventListener( MouseEvent.ROLL_OVER, itemRollOver );		
				item.addEventListener( MouseEvent.CLICK, itemClick );
			}		
			item.visible = true;
			item.name = String( index );
			
			// Draw bitmap at original size before resizing happens
			var bmp:BitmapData = new BitmapData( item.width, item.height, true, 0x000000FF );
			bmp.draw( item );

			// Resize item if policy is set	
			item = resize( item, resizePolicy, resizeValue ) as Sprite;

			// Used for distribution layout - to determine the width or height to distribute to
			largestItemWidth = item.width > largestItemWidth ? item.width : largestItemWidth;
			largestItemHeight = item.height > largestItemHeight ? item.height : largestItemHeight;
									
			// Create Reflection
			if ( reflectionHeightInRows > 0 )
			{
				var ratioA:int = rows - reflectionHeightInRows == currentRow ? 0 : 255;
				var ref:ReflectionItem = new ReflectionItem( ITEM_REFLECTION,  new Bitmap( bmp ), [ ratioA, 255 ], bmp.height, _debug );			
				ref.name = "reflection_" + index;
				ref = resize( ref, resizePolicy, resizeValue ) as ReflectionItem;
				ref = resize( ref, distributePolicy, largestItemWidth ) as ReflectionItem;
			}
			// Determine updates required for reflections
			switch ( IGalleryItem( item ).type )
			{
				case ITEM_SWF       :
				case ITEM_VIDEO     :
				case ITEM_COUNTDOWN : item.addEventListener( Event.ENTER_FRAME, enterFrame ); break;
			}
						
			if (( index + 1 ) % columns == 0 ) currentRow++;
			
			addChild( item );
			if ( reflectionHeightInRows > 0 ) addChild( ref );
			
			items.shift();
			items.length > 0 ?  create() : complete( );
		}
		
		
		private function enterFrame( event:Event ):void
		{
			var ref:ReflectionItem = getChildByName( "reflection_" + event.currentTarget.name ) as ReflectionItem;
			ref.update( event.currentTarget as IGalleryItem );
		}

		
		/**
		 * Lay the items out in the specified columns and rows including the reflections with their alpha 
		 * settings. 
		 * 
		 * TODO: Move distribute into arrange - should be part of the alignment logic
		 */
		private function arrange():void
		{
			var i:int;
			var item:Sprite;		
			var reflection:ReflectionItem;
			currentRow = 0;			
			
			for ( i = 0; i < total; ++i )
			{
				item = getChildByName( i.toString() ) as Sprite;				
				
				// Distribute to width/height/or from center
				item = resize( item, distributePolicy, distributePolicy == DISTRIBUTE_H ? largestItemWidth : largestItemHeight ) as Sprite;
				item.x += xOffset; 
				item.y += yOffset; 				
				
				if ( reflectionHeightInRows > 0 )
				{
					reflection = getChildByName( "reflection_" + i.toString() ) as ReflectionItem;
					reflection.alpha = (( rows - currentRow ) <= reflectionHeightInRows ) ? reflectionAlpha : 0;
					reflection.reflectionAlpha = reflection.alpha;					
					reflection = resize( reflection, distributePolicy, distributePolicy == DISTRIBUTE_H ? largestItemWidth : largestItemHeight ) as ReflectionItem;
					reflection.x += xOffset;								
					var posY:int = ( rows - currentRow ) * ( item.height + verticalgap ) * 2 - item.height;
					reflection.y += posY + yOffset - verticalgap;
				}
							
				if (( i + 1 ) % columns == 0 )
				{
					currentRow++;
					yOffset += largestItemHeight + verticalgap;
					xOffset = startX;
				}
				else
				{
					xOffset += largestItemWidth + horizontalGap;
				}					
			}
			
			dispatchEvent( new GalleryEvent( GalleryEvent.ARRANGE_COMPLETE ));
		}

		
		protected function transitionComplete(event:GalleryEvent):void
		{
			dispatchEvent( event );
		}
		
		
		protected function itemClick( event:MouseEvent ):void
		{
			switch ( target )
			{
				case BLANK   : navigateToURL( new URLRequest( "" ), "_blank");	break;
				case OVERLAY : break;
				case LIGHTBOX: break;
				default		 : dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_CLICK, false, false, int( event.currentTarget.name )));
			}
		}		
		
		
		protected function itemRollOver( event:MouseEvent ):void
		{
			var i:int;
			var item:IGalleryItem;
			var reflection:IGalleryItem;
			
			if ( event.currentTarget.name.indexOf( "reflection_" ) == -1 )
			{			
				for ( i = 0; i < total; ++i )
				{
					item = getChildByName( i.toString() ) as IGalleryItem;
					reflection = getChildByName( "reflection_" + i.toString() ) as IGalleryItem;
					
					// Rolled over item
					if ( item.name == event.currentTarget.name && event.currentTarget.name.indexOf( "reflection_" ) == -1 )
					{
//						item.rollOver();
						item.enable = true;
						if ( reflectionHeightInRows > 0 )
						{
							reflection = getChildByName( "reflection_" + item.name.toString() ) as IGalleryItem;
							reflection.enable = true;
						}
//						reflection.rollOver();
						dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_ROLLOVER, false, false, i ));
//						Tweener.addTween( item, {_tintBrightness: 0.0, time: 0.5, transition: "linear" } );
//						Tweener.addTween( reflection, {alpha: reflectionAlpha+0.3, time: 0.5, transition: "linear" } );						
					}

					if ( item.name != event.currentTarget.name && item.name != ( "reflection_" + item.name ))
					{
						item.enable = false;
//						reflection.rollOver();
//						Tweener.addTween(  item, { _saturation: 0, time: 1, transition: "linear" });
//						Tweener.addTween(  reflection, { _saturation: 0, time: 1, transition: "linear" });								
					}
				}
			}
		}
		

		protected function itemRollOut( event:MouseEvent ):void
		{
			var i:int;
			var item:IGalleryItem;		
			var reflection:IGalleryItem;	
			for ( i = 0; i < total; ++i )
			{
				item = getChildByName( i.toString() ) as IGalleryItem;	
				reflection = getChildByName( "reflection_" + i.toString() ) as IGalleryItem;
				item.rollOut();
				
				if  ( reflectionHeightInRows > 0 )
				{
					reflection = getChildByName( "reflection_" + item.name.toString() ) as IGalleryItem;
					reflection.enable = false;
				}
			/*
				if ( item.name != event.currentTarget.name )
				{
					item.rollOut();
//					reflection.rollOut();		
								
//					Tweener.addTween( item, {_saturation: 1, time: 1, transition: "linear" });
//					Tweener.addTween( reflection, { alpha: reflectionAlpha, _saturation: 1, time: 0.5, transition: "linear" });
				}
				else if ( item.name == event.currentTarget.name && event.currentTarget.name.indexOf( "reflection_" ) == -1 )
				{
					item.rollOut();
//					Tweener.addTween( item, {_tintBrightness: -0.3, time: 0.5, transition: "linear" } );
					if ( item.name.indexOf( "reflection_" ) == -1 )
						item.stop();
				}*/
			}			
		}

		
		private function complete():void
		{
			dispatchEvent( new GalleryEvent( GalleryEvent.LOAD_COMPLETE ));
			arrange();
			Tracer.output( _debug, " Gallery.complete()", toString() );
		}		
		
		
		private function resize( object:DisplayObject, policy:String, value:Number ):DisplayObject
		{
			var resizeUtil:ImageResize = new ImageResize();
			if ( policy == RESIZE_HEIGHT && value != -1 ) object = resizeUtil.resizeToHeight( object, value );
			if ( policy == RESIZE_WIDTH && value != -1 ) object = resizeUtil.resizeToWidth( object, value );
			if ( policy == DISTRIBUTE_H && value != -1 ) object = resizeUtil.distribute( object, value );
			if ( policy == DISTRIBUTE_V && value != -1 ) object = resizeUtil.distribute( object, value, ImageResize.DISTRIBUTE_TO_HEIGHT );
			resizeUtil = null;		 
			return object;	
		}
		
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
	}
}
