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
	import com.wezside.data.collection.DictionaryCollection;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.decorators.layout.DistributeLayout;
	import com.wezside.components.decorators.layout.GridReflectionLayout;
	import com.wezside.components.gallery.item.BlankGalleryItem;
	import com.wezside.components.gallery.item.CountdownGalleryItem;
	import com.wezside.components.gallery.item.FLVGalleryItem;
	import com.wezside.components.gallery.item.GalleryItemClass;
	import com.wezside.components.gallery.item.IGalleryItem;
	import com.wezside.components.gallery.item.ImageGalleryItem;
	import com.wezside.components.gallery.item.MovieClipGalleryItem;
	import com.wezside.components.gallery.item.ReflectionItem;
	import com.wezside.components.gallery.transition.IGalleryTransition;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.IDictionaryCollection;
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

		public static const ITEM_SWF:String = "itemSWF";
		public static const ITEM_BLANK:String = "itemBlank";
		public static const ITEM_VIDEO:String = "itemVideo";
		public static const ITEM_IMAGE:String = "itemImage";
		public static const ITEM_COUNTDOWN:String = "itemCountdown";
		public static const ITEM_REFLECTION:String = "itemReflection";
		
		public static const RESIZE_WIDTH:String = "resizeToWidth";
		public static const RESIZE_HEIGHT:String = "resizeToHeight";
		public static const LEFT:String = "left";
		public static const CENTER:String = "center";
		
		public static const BLANK:String = "";
		public static const HREF:String = "HREF";
		public static const LIGHTBOX:String = "lightbox";
		public static const VERSION:String = "0.5.0002";		

		public static const STATE_ROLLOVER:String = "stateRollover";
		public static const STATE_ROLLOUT:String = "stateRollout";
		public static const STATE_SELECTED:String = "stateSelected";
		
		private var items:ICollection;
		private var original:ICollection;
		private var currentRow:int;
		private var totalpages:Number;
		private var total:uint;
		private var dateUtils:DateUtil;
		private var largestItemWidth:Number = 0;
		private var largestItemHeight:Number = 0;
		
		// Getters and setters 
		private var _debug:Boolean = false;
		private var _stageWidth:Number = 550;
		private var _stageHeight:Number = 400;
		private var _selectedIndex:int;
		private var _thumbWidth:Number = 80;
		private var _thumbHeight:Number = 80;
		private var _reflectionRowHeight:int = 0;
		private var _thumbEnabled:Boolean = true;
		private var _classCollection:IDictionaryCollection;
		private var _transition:IGalleryTransition;

		private var _target:String = "";
		private var _resizePolicy:String = RESIZE_HEIGHT;
		private var _reflectionAlpha:Number = 0.3;
		
		
		public function Gallery() 
		{
			// Default Layout decorator
			layout = new GridReflectionLayout( this );		
			GridReflectionLayout( layout ).columns = 4;
			GridReflectionLayout( layout ).rows = 3;
			GridReflectionLayout( layout ).horizontalGap = 0;
			GridReflectionLayout( layout ).verticalGap = 0;
			
			// Initialize Classes that will represent the different type of IGalleryItems	
			_classCollection = new DictionaryCollection();
			addCustomItem( ITEM_BLANK, BlankGalleryItem, [] );
			addCustomItem( ITEM_SWF, MovieClipGalleryItem, ["swf"] );
			addCustomItem( ITEM_VIDEO, FLVGalleryItem, ["flv"] );
			addCustomItem( ITEM_IMAGE, ImageGalleryItem, ["jpg", "gif", "png", "bmp"] );
			addCustomItem( ITEM_COUNTDOWN, CountdownGalleryItem, ["countdown"] );
			dateUtils = new DateUtil();
		}
		
		
		public function init( items:ICollection ):void
		{			
			this.items = items;
			currentRow = 0;
			visible = false;
			totalpages = Math.ceil( items.length / ( columns * rows )); 
						
			Tracer.output( _debug, " Total pages " + totalpages, toString() );
			
			// Determine how many Blank Items to create 
			var remainingItems:Number = (( columns * rows * totalpages ) - ( items.length ));
				
			if ( items.length < ( columns * rows * totalpages ))
				for ( var i:int = 0; i < remainingItems ; i++ )
					items.addElement({ id: "blank_" + i, url: "", livedate: new Date() });
			
			// Get the total items with blank items included
			total = items.length;
			
			// Duplicate the dataprovider
			original = new Collection();
			original = items.clone();
						
			// TODO: If creation policy is JIT then we need a cap on items created to be equal to columns * rows
			
			Tracer.output( _debug, " Total gallery items " + total, toString() );
			if ( items.length == 0 )
				throw new Error( "Error: No items in dataprovider." );			
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

		public function addCustomItem( id:String, clazz:Class, fileAssociation:Array, data:* = null ):void
		{
			_classCollection.addElement( id, new GalleryItemClass( fileAssociation, id, clazz, data ));	
		}

		public function show():void
		{
			visible = true;
			if ( _transition )
			{
				Tracer.output( _debug, " Gallery.show()", getQualifiedClassName( this ));
				_transition.addEventListener( GalleryEvent.INTRO_COMPLETE, transitionComplete );
				_transition.transitionIn();
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
				_transition.transitionOut();
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
			_transition.reflectionHeightInRows = _reflectionRowHeight;
			_transition.columns = columns;
			_transition.stageWidth = _stageWidth;
			_transition.stageHeight = _stageHeight;
			_transition.totalPages = totalpages;
			_transition.total = total;
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
			return ( row * verticalGap ) * largestItemHeight * 0.5;
		}

		public function get thumbEnabled():Boolean
		{
			return _thumbEnabled;
		}
		
		public function get rows():int
		{
			return layout.rows;
		}
		
		public function set rows( value:int ):void
		{
			layout.rows = value;
		}
		
		public function get columns():int
		{
			return layout.columns;
		}
		
		public function set columns( value:int ):void
		{
			layout.columns = value;
		}
		
		public function get verticalGap():int
		{
			return layout.verticalGap;
		}
		
		public function set verticalGap( value:int ):void
		{
			layout.verticalGap = value;
		}
		
		public function get horizontalGap():int
		{
			return layout.horizontalGap;
		}
		
		public function set horizontalGap( value:int ):void
		{
			layout.horizontalGap = value;
		}
		
		public function get resizePolicy():String
		{
			return _resizePolicy;
		}
		
		public function set resizePolicy( value:String ):void
		{
			_resizePolicy = value;
		}
		
		public function get reflectionRowHeight():int
		{
			return _reflectionRowHeight;
		}
		
		public function set reflectionRowHeight( value:int ):void
		{
			_reflectionRowHeight = value;
		}
		
		public function get thumbHeight():int
		{
			return _thumbHeight;
		}
		
		public function set thumbHeight( value:int ):void
		{
			_thumbHeight = value;
		}
		
		public function get thumbWidth():int
		{
			return _thumbWidth;
		}
		
		public function set thumbWidth( value:int ):void
		{
			_thumbWidth = value;
		}
		
		override public function set debug( value:Boolean ):void
		{
			_debug = value;
			super.debug = value;
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
		public function create():void
		{
			if ( items.length != 0 )
			{
				var data:* = original.getElementAt( int( total - items.length )).data;
				var date:Date = original.getElementAt( int( total - items.length )).livedate;
				var extension:String = FileUtil.getFileExtension( items.getElementAt( 0 ).url );
				dateUtils.testLiveDate( date ) ? createItem( extension, data ) : createItem( "countdown", data );
			}
		}
		
		override protected function arrangeComplete( event:UIElementEvent ):void 
		{
			dispatchEvent( new GalleryEvent( GalleryEvent.ARRANGE_COMPLETE ));
		}
		
		private function createItem( fileExtension:String = "", data:* = null ):void
		{		
			var clazzItem:GalleryItemClass = _classCollection.getElement( parseType( fileExtension ));
			var ItemClass:Class = clazzItem.clazz as Class;
			var item:IGalleryItem = new  ItemClass( fileExtension, _debug ) as IGalleryItem;
			item.data = data ? data : clazzItem.data;
			item.addEventListener( GalleryEvent.ITEM_ERROR, itemError );
			item.addEventListener( GalleryEvent.ITEM_PROGRESS, itemProgress );
			item.addEventListener( GalleryEvent.ITEM_LOAD_COMPLETE, itemLoaded );
			item.load( items.getElementAt( 0 ).url, items.getElementAt( 0 ).livedate, items.getElementAt( 0 ).linkageID, _thumbWidth, _thumbHeight );
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
		 * <li>Reflection is created depending on reflactionAlpha and reflectionHeightn_rows values</li>
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
			item = resize( item, _resizePolicy ) as Sprite;
			
			// Used for distribution layout - to determine the width or height to distribute to
			largestItemWidth = item.width > largestItemWidth ? item.width : largestItemWidth;
			largestItemHeight = item.height > largestItemHeight ? item.height : largestItemHeight;

			// Create Reflection
			if ( _reflectionRowHeight > 0 )
			{
				var ratioA:int = rows - _reflectionRowHeight == currentRow ? 0 : 255;
				var ref:ReflectionItem = new ReflectionItem( ITEM_REFLECTION,  new Bitmap( bmp ), [ ratioA, 255 ], bmp.height, _debug );			
				ref.name = "reflection_" + index;				
				ref.alpha = (( rows - currentRow ) <= _reflectionRowHeight ) ? _reflectionAlpha : 0;
				
				// Resize reflection
				ref = resize( ref, _resizePolicy ) as ReflectionItem;
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
			if ( _reflectionRowHeight > 0 ) addChild( ref );
			items.removeElementAt( 0 );
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

			IGalleryItem( event.currentTarget ).state = "";
			IGalleryItem( event.currentTarget ).state = STATE_SELECTED;
			
			switch ( _target )
			{
				case HREF	 : navigateToURL( new URLRequest( "" ), "_blank");	break;
				case LIGHTBOX: break;
				case BLANK   :
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
						if ( _reflectionRowHeight > 0 )
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
				
				if  ( _reflectionRowHeight > 0 )
				{
					reflection = iterator.next() as IGalleryItem;
					reflection = getChildByName( "reflection_" + item.name.toString() ) as IGalleryItem;
					reflection.state = STATE_ROLLOUT;
				}
			}			
		}

		
		private function complete():void
		{		
			Tracer.output( _debug, " Gallery.complete()", toString() );
			GridReflectionLayout( layout ).width = largestItemWidth;
			GridReflectionLayout( layout ).height = largestItemHeight;
			GridReflectionLayout( layout ).hasReflections = _reflectionRowHeight > 0;
			
			layout = new DistributeLayout( this.layout );
			DistributeLayout( layout ).width = largestItemWidth;
			DistributeLayout( layout ).height = largestItemHeight;

			dispatchEvent( new GalleryEvent( GalleryEvent.LOAD_COMPLETE ));
			build();
			setStyle();
			arrange();
			dispatchEvent( new GalleryEvent( GalleryEvent.ARRANGE_COMPLETE ));
		}		
				
		private function parseType( fileExtension:String ):String
		{
			if ( fileExtension == ITEM_BLANK ) return ITEM_BLANK;
			var type:String = ITEM_BLANK;			
			var key:String;
			var clazzItem:GalleryItemClass;
			var it:IIterator = _classCollection.iterator();
			while ( it.hasNext() )
			{
				key = it.next() as String;
				clazzItem = _classCollection.getElement( key ) as GalleryItemClass;
			
				var classIt:IIterator = clazzItem.fileExtension.iterator();
				var ext:String;
				while ( classIt.hasNext() )
				{
					ext = classIt.next() as String;
					if ( fileExtension == ext )
						type = clazzItem.id;
				}
				classIt.purge();
				classIt = null;
				ext = null;
			
				if ( type != "" && type != ITEM_BLANK )	break; 
			}			
			it.purge();
			it = null;
			clazzItem = null;
			return type;
		}		
		
		private function resize( object:DisplayObject, policy:String ):DisplayObject
		{
			var value:int = _resizePolicy == Gallery.RESIZE_HEIGHT ? _thumbHeight : _thumbWidth;			
			var resizeUtil:ImageResize = new ImageResize();
			if ( policy == RESIZE_HEIGHT && value != -1 ) object = resizeUtil.resizeToHeight( object, value );
			if ( policy == RESIZE_WIDTH && value != -1 ) object = resizeUtil.resizeToWidth( object, value );
			resizeUtil = null;		 
			return object;	
		}
		
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
	}
}
