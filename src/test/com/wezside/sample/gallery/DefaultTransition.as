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
	import gs.TweenMax;
	import gs.easing.Cubic;

	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.gallery.item.IGalleryItem;
	import com.wezside.components.gallery.item.ReflectionItem;
	import com.wezside.components.gallery.transition.IGalleryTransition;
	import com.wezside.components.gallery.transition.Transition;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class DefaultTransition extends Transition implements IGalleryTransition 
	{

		private var _direction:String;
		private var _type:String;

		
		public function DefaultTransition( decorated:IUIDecorator ) 
		{
			super( decorated );
		}
		
		override public function intro():void
		{
			_type = "intro";
			_direction = "left";
			arrange();
		}
		
		override public function outro():void
		{
			_type = "outro";
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
		override public function arrange( event:UIElementEvent = null ):void
		{
			
			var i:int;
			var endPos:int;
			var delay:Number = 0;
			
			var itemIterator:Object;
			var item:DisplayObject;
			var reflection:DisplayObject;

			TweenMax.resumeAll();
			
			for ( var k:int = 0; k < columns; k++ ) 
			{
				var collection:ICollection = getColumn( k );
				var iterator:ArrayIterator = collection.iterator() as ArrayIterator;
				
				while ( iterator.hasNext() )
				{
					itemIterator = iterator.next();					
					item = itemIterator.item;
					
					if ( reflectionHeightInRows > 0 )
						reflection = itemIterator.reflection as DisplayObject;	

					// Set the delay based on the direction 
					if ( _direction == "left" ) delay = ( iterator.length() - iterator.index() ) * 0.05 + k * 0.2;
					if ( _direction == "right" ) delay = ( iterator.length() - iterator.index() ) * 0.05 + ( columns - k ) * 0.2;
					
					if ( item  )
					{
						if ( _type == "intro" )
						{
							endPos = item.x;
							item.x = stageWidth + 100;
							item.visible = true;
							transEvent = new GalleryEvent( GalleryEvent.INTRO_COMPLETE );
						} 
						else if ( _type == "outro" )
						{
							if ( direction == "left" ) endPos = -item.width - stageWidth - 100;
							if ( direction == "right" ) endPos = stageWidth;
							transEvent = new GalleryEvent( GalleryEvent.OUTRO_COMPLETE );
						}
						
						var lastItem:Boolean = false;
						if ( direction == "left" ) lastItem =  k + 1 == columns;
						if ( direction == "right" ) lastItem =  k == 0;
						
						if ( lastItem && iterator.index() + 1 == iterator.length() )
							TweenMax.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut, onComplete: transitionComplete });
						else
							TweenMax.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
					}
						
					if ( reflection  )
					{
						if ( _type == "intro" )
						{
							if ( direction == "left" )
							{
								endPos = reflection.x;
								reflection.x = stageWidth + 100;
							}
							if ( direction == "right" )
							{
								endPos = stageWidth + 100; 
							}
						}
						
						if ( _type == "outro" )
						{
							if ( direction == "left" ) endPos = -item.width - stageWidth - 100;
							if ( direction == "right" ) endPos = stageWidth + 100;
						}						
						TweenMax.to( reflection, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
					}
				}
			}			
		}
		
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction( value:String ):void
		{
			_direction = value;
		}
				
		private function getColumn( index:int ):ICollection
		{
			
			var item:IGalleryItem;
			var reflection:IGalleryItem;
			var collection:Collection = new Collection();
			var iterator:IIterator = decorated.iterator( UIElement.ITERATOR_CHILDREN );
						
			while ( iterator.hasNext())
			{
				item = iterator.next() as IGalleryItem;
			
				if ( reflectionHeightInRows > 0 )
					reflection = iterator.next() as IGalleryItem;
				
				trace((( columns - index )));
				trace((( columns - index ) + iterator.index() ));
				
				
				
				if (( ( columns - index ) + iterator.index() - 1 ) % columns == 0 )
				{
//					trace( item.name );
					collection.push({ item: item, reflection: reflection });
				}
			}
			return collection;
		}

	}
}
