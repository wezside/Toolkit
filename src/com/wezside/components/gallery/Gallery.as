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
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.gallery.collection.ClassCollection;
	import com.wezside.components.gallery.item.BlankGalleryItem;
	import com.wezside.components.gallery.item.CountdownGalleryItem;
	import com.wezside.components.gallery.item.FLVGalleryItem;
	import com.wezside.components.gallery.item.GalleryItemClass;
	import com.wezside.components.gallery.item.IGalleryItem;
	import com.wezside.components.gallery.item.ImageGalleryItem;
	import com.wezside.components.gallery.item.MovieClipGalleryItem;
	import com.wezside.components.gallery.item.ReflectionItem;
	import com.wezside.components.gallery.layout.GridReflectionLayout;
	import com.wezside.components.gallery.transition.IGalleryTransition;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.date.DateUtil;
	import com.wezside.utilities.file.FileUtil;
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
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version 0.2.0020
	 */
	public class Gallery extends UIElement 
	{

		
		private var rows:int;
		private var columns:int;
		private var items:Array = [];
		private var original:Array = [];
		private var currentRow:int;
		private var totalpages:Number;
		private var total:uint;
		private var dateUtils:DateUtil;
		private var largestItemWidth:Number = 0;
		private var largestItemHeight:Number = 0;
		
		// Constructor values
		private var horizontalGap:int;
		private var verticalgap:int;
		private var resizePolicy:String;
		private var resizeValue:Number;

		private var reflectionAlpha:Number;
		private var distributePolicy:String;
		private var target:String;
		private var horizontalAlign:String;
		private var showArrangement:Boolean;
		private var reflectionHeightInRows:int;
		
		// Getters and setters 
		private var _debug:Boolean;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _selectedIndex:int;
		private var _thumbEnabled:Boolean;
		private var _classCollection:ClassCollection;


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

		public static const STATE_ROLLOVER:String = "stateRollover";
		public static const STATE_ROLLOUT:String = "stateRollout";
		public static const STATE_SELECTED:String = "stateSelected";		
		private var _transition:IGalleryTransition;

		
		public function Gallery( dataprovider:Array, 
								 columns:int = 4, 
								 rows:int = 3, 
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
			this.target = target;			
			this.horizontalAlign = horizontalAlign;
			this.horizontalGap = horizontalGap;
			this.verticalgap = verticalgap; 
			this.resizePolicy = resizePolicy;
			this.resizeValue = resizeValue;
			this.distributePolicy = distributePolicy;
			this.reflectionHeightInRows = reflectionHeightInRows;
			this.reflectionAlpha = reflectionAlpha;
			this.showArrangement = showArrangement;
			
			_debug = debug;
			_stageWidth = stageWidth;
			_stageHeight = stageHeight;
			_thumbEnabled = thumbEnabled;
			
			layout = new GridReflectionLayout( this );
			
			_classCollection = new ClassCollection();
			_classCollection.push( new GalleryItemClass( [], ITEM_BLANK, BlankGalleryItem ));
			_classCollection.push( new GalleryItemClass( ["swf"], ITEM_SWF, MovieClipGalleryItem ));
			_classCollection.push( new GalleryItemClass( ["flv"], ITEM_VIDEO, FLVGalleryItem ));
			_classCollection.push( new GalleryItemClass( ["jpg", "gif", "png", "bmp"], ITEM_IMAGE, ImageGalleryItem ));
			_classCollection.push( new GalleryItemClass( ["countdown"], ITEM_COUNTDOWN, CountdownGalleryItem  ));

			currentRow = 0;
			visible = showArrangement;
			totalpages = Math.ceil( items.length / ( columns * rows )); 
			
			Tracer.output( _debug, " Total pages " + totalpages, toString() );
			
			var remainingItems:Number = (( columns * rows * totalpages ) - ( items.length ));		
			if ( items.length < ( columns * rows * totalpages ))
				for ( var i:int = 0; i < remainingItems ; i++ )
					items.push( { id: "blank_" + i, url: "", livedate: new Date() });
						
			total = items.length;			
			original = original.concat( items );
			
			Tracer.output( _debug, " Total gallery items " + total, toString() );
			if ( items.length == 0 )
				throw new Error( "Error: No items in dataprovider." );
			
			dateUtils = new DateUtil();
		}
						
		override public function purge():void
		{
			super.purge();
			for each ( var item:IGalleryItem in this )
			{
				item.purge();
				item.removeEventListener( Event.ENTER_FRAME, enterFrame );
				item.removeEventListener( GalleryEvent.ITEM_ERROR, itemError );
				item.removeEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );
				removeChild( item as DisplayObject );
			}
		}

		public function addCustomItem( id:String, clazz:Class, fileAssociation:Array ):void
		{
			_classCollection.push( new GalleryItemClass( fileAssociation, id, clazz ));
		}

		public function show():void
		{
			visible = true;			
			if ( _transition )
			{
				_transition.addEventListener( GalleryEvent.INTRO_COMPLETE, transitionComplete );
				_transition.intro();
			}
			else
			{
				transitionComplete( new GalleryEvent( GalleryEvent.INTRO_COMPLETE ));
			}
		}

		
		public function hide():void
		{
			if ( _transition )
			{
				_transition.addEventListener( GalleryEvent.OUTRO_COMPLETE, transitionComplete );
				_transition.outro();
			}
			else
			{
				transitionComplete( new GalleryEvent( GalleryEvent.OUTRO_COMPLETE ));
			}
		}
			
		public function get transition():IGalleryTransition
		{
			return _transition;
		}
		
		public function set transition( value:IGalleryTransition ):void
		{
			_transition = value;
			_transition.rows = rows;
			_transition.reflectionHeightInRows = reflectionHeightInRows;
			_transition.columns = columns;
			_transition.stageWidth = _stageWidth;
			_transition.stageHeight = _stageHeight;
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex( value:int ):void
		{
			_selectedIndex = value;
			var item:IGalleryItem = getChildByName( _selectedIndex.toString() ) as IGalleryItem;
			if ( item )	item.state = STATE_SELECTED;
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

		public function get thumbEnabled():Boolean
		{
			return _thumbEnabled;
		}
		
		/**
		 * TODO: Only need to do this for interactive items, thus not for Blank, CountDown etc.
		 */
		public function set thumbEnabled( value:Boolean ):void
		{
			_thumbEnabled = value;
			var item:Sprite;			
			if ( !_thumbEnabled )
			{
			
				var i:int;
				for ( i = 0; i < total; ++i )
				{
					item = getChildByName( i.toString() ) as Sprite;
					item.buttonMode = false;
					item.useHandCursor = false;
					item.removeEventListener( MouseEvent.ROLL_OUT, itemRollOut );		
					item.removeEventListener( MouseEvent.ROLL_OVER, itemRollOver );	
					item.removeEventListener( MouseEvent.ROLL_OVER, itemRollOver );	
				}
			}
			else
			{
				var k:int;			
				for ( k = 0; k < total; ++k )
				{
					item = getChildByName( i.toString() ) as Sprite;
					item.buttonMode = true;
					item.useHandCursor = true;
					item.addEventListener( MouseEvent.ROLL_OUT, itemRollOut );		
					item.addEventListener( MouseEvent.ROLL_OVER, itemRollOver );	
					item.addEventListener( MouseEvent.ROLL_OVER, itemRollOver );	
				}				
			}
		}

		/**
		 * A method to determine which type of video wall item to create. The date retrieved is 
		 * the difference between the server time and the livedate attribute specified in the XML node
		 * for each video within the football hd module. The format is [seconds, minutes, hours, days ]. 
		 */
		public function create( event:Event = null ):void
		{
			if ( items.length != 0 )
			{
				var date:Date = original[ int( total - items.length ) ].livedate;
				var extension:String = FileUtil.getFileExtension( items[0].url );
				dateUtils.testLiveDate( date ) ? createItem( extension ) : createItem( "countdown" );
			}
		}
		
		override protected function arrangeComplete( event:UIElementEvent ):void 
		{
			dispatchEvent( new GalleryEvent( GalleryEvent.ARRANGE_COMPLETE ));
		}
				
		
		private function createItem( fileExtension:String = "" ):void
		{		
			var ItemClass:Class = _classCollection.find( fileExtension ).clazz as Class;
			var item:IGalleryItem = new  ItemClass( fileExtension, _debug ) as IGalleryItem;
			item.addEventListener( GalleryEvent.ITEM_ERROR, itemError );
			item.addEventListener( GalleryEvent.ITEM_PROGRESS, itemProgress );
			item.addEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );
			item.load( items[0].url, items[0].livedate, items[0].linkageID );
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
			if ( _thumbEnabled )
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
						
			// Distribute item			
			item = resize( item, distributePolicy, distributePolicy == DISTRIBUTE_H ? largestItemWidth : largestItemHeight ) as Sprite;
									
			// Create Reflection
			if ( reflectionHeightInRows > 0 )
			{
				var ratioA:int = rows - reflectionHeightInRows == currentRow ? 0 : 255;
				var ref:ReflectionItem = new ReflectionItem( ITEM_REFLECTION,  new Bitmap( bmp ), [ ratioA, 255 ], bmp.height, _debug );			
				ref.name = "reflection_" + index;				
				ref.alpha = (( rows - currentRow ) <= reflectionHeightInRows ) ? reflectionAlpha : 0;
				
				// Resize reflection
				ref = resize( ref, resizePolicy, resizeValue ) as ReflectionItem;
				
				// Distribute reflection
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

		
		protected function transitionComplete( event:GalleryEvent ):void
		{
			dispatchEvent( event );
		}
		
		
		protected function itemClick( event:MouseEvent ):void
		{
			
			var iterator:IIterator = iterator( UIElement.ITERATOR_CHILDREN );			
			while( iterator.hasNext())
			{
				var item:IGalleryItem = iterator.next() as IGalleryItem;
				if ( event.currentTarget.name != item.name.toString() )
					item.reset();
			}

			IGalleryItem( event.currentTarget ).state = STATE_SELECTED;
			
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
			var item:IGalleryItem;
			var reflection:IGalleryItem;
			var iterator:IIterator = iterator( UIElement.ITERATOR_CHILDREN );
		
			if ( event.currentTarget.name.indexOf( "reflection_" ) == -1 )
			{			
				while( iterator.hasNext())
				{
					item = iterator.next() as IGalleryItem;
					if ( item.name == event.currentTarget.name  )
					{
						item.state = STATE_ROLLOVER;
						if ( reflectionHeightInRows > 0 )
						{
							reflection = iterator.next() as IGalleryItem;
							reflection = getChildByName( "reflection_" + item.name.toString() ) as IGalleryItem;
							reflection.state = STATE_ROLLOVER;
						}
						dispatchEvent( new GalleryEvent( GalleryEvent.ITEM_ROLLOVER, false, false, iterator.index() ));
					}

					if ( item.name != event.currentTarget.name )
					{
						item.state = STATE_ROLLOUT;
					}
				}
			}
			iterator = null;
		}
		

		protected function itemRollOut( event:MouseEvent ):void
		{
			var item:IGalleryItem;		
			var reflection:IGalleryItem;	
			var iterator:IIterator = iterator( UIElement.ITERATOR_CHILDREN );
			
			while( iterator.hasNext())
			{
				item = iterator.next() as IGalleryItem;	
				item.state = STATE_ROLLOUT;
				
				if  ( reflectionHeightInRows > 0 )
				{
					reflection = iterator.next() as IGalleryItem;
					reflection = getChildByName( "reflection_" + item.name.toString() ) as IGalleryItem;
					reflection.state = STATE_ROLLOUT;
				}
			}			
		}

		
		private function complete():void
		{
			GridReflectionLayout( layout ).horizontalGap = horizontalGap;
			GridReflectionLayout( layout ).verticalGap = verticalgap;
			GridReflectionLayout( layout ).largestItemWidth = largestItemWidth;
			GridReflectionLayout( layout ).largestItemHeight = largestItemHeight;
			GridReflectionLayout( layout ).rows = rows;
			GridReflectionLayout( layout ).columns = columns;
			GridReflectionLayout( layout ).reflectionHeightInRows = reflectionHeightInRows;
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
