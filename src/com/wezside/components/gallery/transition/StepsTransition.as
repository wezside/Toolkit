package com.wezside.components.gallery.transition 
{
	import gs.TweenLite;
	import gs.easing.Cubic;

	import com.wezside.components.gallery.Gallery;
	import com.wezside.components.gallery.GalleryEvent;
	import com.wezside.components.gallery.item.IGalleryItem;
	import com.wezside.components.gallery.item.ReflectionItem;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class StepsTransition extends Transition 
	{
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		public function StepsTransition( decorated:Gallery )
		{
			super( decorated );
			_stageWidth = decorated.stageWidth;
			_stageHeight = decorated.stageHeight;
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
		override public function perform( type:String = "intro" ):void
		{
			
			var i:int;
			var endPos:int;
			var delay:Number = 0;
			var item:DisplayObject;
			var reflection:DisplayObject;

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
							eventType = GalleryEvent.INTRO_COMPLETE;
						} 
						else if ( type == "outro" )
						{
							if ( direction == "left" ) endPos = -item.width - _stageWidth - 100;
							if ( direction == "right" ) endPos = _stageWidth;
							eventType = GalleryEvent.OUTRO_COMPLETE;
						}
						
						var lastItem:Boolean = false;
						if ( direction == "left" ) lastItem =  k + 1 == columns;
						if ( direction == "right" ) lastItem =  k == 0;
						
						if ( lastItem && i + 1 == arr.length )
							TweenLite.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut, onComplete: transitionComplete });
//							Tweener.addTween( item, { x: endPos, time: 0.7, delay: delay, transition: Equations.easeInOutCubic, onComplete: transitionComplete });
						else
							TweenLite.to( item, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
//							Tweener.addTween( item, { x: endPos, time: 0.7, delay: delay, transition: Equations.easeInOutCubic });
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
						TweenLite.to( reflection, 0.7, { x: endPos, delay: delay, ease: Cubic.easeInOut });
//						Tweener.addTween( reflection, { x: endPos, time: 0.7, delay: delay, transition: Equations.easeInOutCubic });
					}
				}
			}			
		}
				
		private function getColumn( index:int ):Array
		{
			var itemIndex:int = 0;
			var item:IGalleryItem;
			var reflection:ReflectionItem;
			var arr:Array = [];			
			var it:IIterator = iterator();

			while ( it.hasNext() )
			{
				item = it.next() as IGalleryItem;
				
				if ( reflectionHeightInRows > 0 )
					reflection = it.next() as ReflectionItem;
				
				if (( ( columns - index ) + itemIndex ) % columns == 0 )
					arr.push({ item: item, reflection: reflection });

				if ( item.name.indexOf( "reflection_" ) == -1 ) itemIndex++;				
			}
			it.purge();
			it = null;
			item = null;
			return arr;
		}		
	}
}
