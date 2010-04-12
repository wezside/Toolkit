package test.com.wezside.sample.accordion 
{
	import gs.TweenLite;
	import gs.TweenMax;
	import gs.easing.Cubic;

	import com.wezside.components.accordion.AccordionItem;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionAnimationItem extends AccordionItem 
	{
		public function AccordionAnimationItem()
		{
			super( );
		}

		override public function set selected( value:Boolean ):void
		{
			if ( value )
			{
				if ( !_selected )
				{		
				content.alpha = 1;
				content.visible = true;				
				for ( var i:int = 0; i < Sprite( content ).numChildren; ++i ) 
				{
					var child:SimpleButton = Sprite( content ).getChildAt( i ) as SimpleButton;
					var originY:int = child.y;
					child.y += 40;
					child.filters = [new BlurFilter( 8, 8, 2 )];
					TweenMax.to( child, 0.5, { blurFilter:{ blurX:0, blurY: 0 }, delay: (i*0.1), y: originY });
				}
				TweenLite.to( maskSprite, 0.5, { height: content.height, ease: Cubic.easeInOut });
				}				
			}
			else
			{
				TweenLite.to( maskSprite, 0.5, { height: 0, ease: Cubic.easeInOut });	
			}			
			_selected = value;		
		}		
		
	}
}
