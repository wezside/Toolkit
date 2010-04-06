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
package com.wezside.sample.gallery 
{
	import gs.TweenMax;
	import gs.easing.Cubic;

	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.gallery.IGalleryItem;
	import com.wezside.components.gallery.IGalleryTransition;
	import com.wezside.components.gallery.ReflectionItem;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class DefaultTransition extends Sprite implements IGalleryTransition 
	{


		private var transitionEventType:String;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _galleryInstance:Gallery;
		private var _direction:String = "left";
		
		private var columns:int;
		private var rows:int;
		private var total:int;

		
		public function DefaultTransition( columns:int, rows:int ) 
		{
			this.columns = columns;
			this.rows = rows;
			this.total = columns * rows;
		}

		public function intro():void
		{
			transition( "intro", _direction );
		}		
		
		
		public function outro():void
		{
			transition( "outro", _direction );
		}		
		
		
		public function get direction():String
		{
			return _direction;
		}
		
		
		public function set direction( value:String ):void
		{
			_direction = value;
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
		
		public function get galleryInstance():Gallery
		{
			return _galleryInstance;
		}
		
		public function set galleryInstance( value:Gallery ):void
		{
			_galleryInstance = value;
		}
		
		/**
		 * <p>
		 * This method is used as a transition for the gallery items. A combination of type and direction
		 * distinguishes using different formulas to calculate the direction of the items animating in and out.
		 * The method getColumn is used to retrieve all items within a given column.
		 * </p><p></p>
		 * <p>
		 * Upon successful completion animation either the INTRO_COMPLETE method or the OUTRO_COMPLETE method is 
		 * dispatched. 
		 * </p><p></p>
		 * @param type Type of transition. Similar calculations are required for this transition so one method is used.  
		 * @param direction Indicates the direction of the animation
		 */
		private function transition( type:String = "intro", direction:String = "left" ):void
		{
			
			var i:int;
			var endPos:int;
			var delay:Number = 0;
			var item:DisplayObject;
			var reflection:DisplayObject;

			TweenMax.resumeAll();
			
			for ( var k : int = 0; k < columns; k++ ) 
			{
				
				var arr:Array = getColumn( k );
				
				for ( i = 0; i < arr.length; ++i )
				{
					item = arr[i].item as DisplayObject;
					reflection = arr[i].reflection as DisplayObject;	

					if ( direction == "left" ) delay = ( arr.length - i ) * 0.05 + k * 0.2;
					if ( direction == "right" ) delay = ( arr.length - i ) * 0.05 + ( columns - k ) * 0.2;
					
					if ( item && item.name.indexOf( "reflection_" ) == -1 )
					{
						if ( type == "intro" )
						{
							endPos = item.x;
							item.x = _stageWidth + 100;
							item.visible = true;
							transitionEventType = GalleryEvent.INTRO_COMPLETE;
						} 
						else if ( type == "outro" )
						{
							if ( direction == "left" ) endPos = -item.width - _stageWidth - 100;
							if ( direction == "right" ) endPos = _stageWidth;
							transitionEventType = GalleryEvent.OUTRO_COMPLETE;
						}
						
						var lastItem:Boolean = false;
						if ( direction == "left" ) lastItem =  k + 1 == columns;
						if ( direction == "right" ) lastItem =  k == 0;
						
						if ( lastItem && i + 1 == arr.length )
							TweenMax.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut, onComplete: transitionComplete });
						else
							TweenMax.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
					}
						
					if ( reflection != null && reflection.name.indexOf( "reflection_" ) != -1 )
					{
						if ( type == "intro" )
						{
							if ( direction == "left" )
							{
								endPos = reflection.x;
								reflection.x = _stageWidth + 100;
							}
							if ( direction == "right" )
							{
								endPos = _stageWidth + 100; 
							}
						}
						
						if ( type == "outro" )
						{
							if ( direction == "left" ) endPos = -item.width - _stageWidth - 100;
							if ( direction == "right" ) endPos = _stageWidth + 100;
						}
						
						TweenMax.to( reflection, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
					}
				}
			}			
		}
		
		
		private function transitionComplete():void
		{
			dispatchEvent( new GalleryEvent( transitionEventType ));
		}		
		
				
		private function getColumn( index:int ):Array
		{
			var i:int;
			var itemIndex:int = 0;
			var item:IGalleryItem;
			var reflection:ReflectionItem;
			var arr:Array = [];
			
			for ( i = 0; i < total; ++i )
			{
				item = _galleryInstance.getChildByName( i.toString() ) as IGalleryItem;
				reflection = _galleryInstance.getChildByName( "reflection_" + i.toString()) as ReflectionItem;
				
				if (( ( columns - index ) + itemIndex ) % columns == 0 )
					arr.push( { item: item, reflection: reflection });

				if ( item.name.indexOf("reflection_") == -1 ) itemIndex++;
			}
			return arr;
		}
	}
}
