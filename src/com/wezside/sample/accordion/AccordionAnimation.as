package com.wezside.sample.accordion 
{
	import gs.TweenLite;
	import gs.TweenMax;

	import com.wezside.components.accordion.Accordion;
	import com.wezside.components.accordion.AccordionEvent;
	import com.wezside.components.accordion.AccordionItem;
	import com.wezside.components.accordion.IAccordionItem;

	import mx.effects.easing.Cubic;

	import flash.filters.BlurFilter;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionAnimation extends Accordion 
	{

		private var _duration:Number = 0.5;

		
		public function AccordionAnimation()
		{
			super( );
			this.alpha = 0;
			this.visible = false;
		}

		override public function arrange():void
		{
			var ypos:Number = 0;
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var item:IAccordionItem = getChildAt( i ) as IAccordionItem;
				if ( item )
				{
					TweenLite.to( item, _duration, { y: ypos, ease: Cubic.easeInOut });
					ypos += item.height + verticalGap;
				}
			}			
		}
		
		public function show():void
		{
			this.alpha = 1;
			this.visible = true;			
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var child:AccordionItem = getChildAt( i ) as AccordionItem;
				if ( child )
				{
					child.alpha = 0;
					var originY:int = child.y;
					child.y += 40;
					child.filters = [ new BlurFilter( 8, 8, 2 )];
					
					if ( i == this.numChildren-1 )
						TweenMax.to( child, 0.5, { blurFilter:{ blurX:0, blurY: 0 }, alpha: 1, delay: (i*0.1), y: originY, onComplete: showComplete });
					else
						TweenMax.to( child, 0.5, { blurFilter:{ blurX:0, blurY: 0 }, alpha: 1, delay: (i*0.1), y: originY });
					
				}
			}				
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function set duration( value:Number ):void
		{
			_duration = value;
		}
		
		private function showComplete():void
		{ 
			dispatchEvent( new AccordionEvent( AccordionEvent.SHOW_COMPLETE ));
		}
	}
}
