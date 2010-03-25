package com.wezside.sample.accordion 
{
	import com.wezside.components.accordion.AccordionItem;
	import com.wezside.components.accordion.IAccordionItem;
	import com.wezside.components.accordion.Accordion;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SimpleAccordion extends Sprite
	{
		
		
		public function SimpleAccordion() 
		{
			init();	
		}

		private function init():void 
		{
			
			var item1:IAccordionItem = new AccordionItem();
			item1.header = createSprite( 0xff0000 );
			item1.content = createSprite( 0xcccccc, 200, 50 );
			
			var item2:IAccordionItem = new AccordionItem();
			item2.header = createSprite( 0xff00ff );
			item2.content = createSprite( 0x666666, 200, 100 );
			
			var accordion:Accordion = new Accordion( );
			accordion.addItem( item1 );
			accordion.addItem( item2 );
			
			addChild( accordion );
		}
		
		
		private function createSprite( c:uint, w:int = 200, h:int = 30, x:int = 0, y:int = 0 ):Sprite
		{
			var content:Sprite = new Sprite();
			content.graphics.beginFill( c );
			content.graphics.drawRect( x, y, w, h );
			content.graphics.endFill();

			return content; 			
		}
	}
}
