package test.com.wezside.components.combo 
{
	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.combo.Combo;
	import com.wezside.components.combo.ComboEvent;
	import com.wezside.components.combo.ComboItem;
	import com.wezside.utilities.manager.style.IStyleManager;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestCombo extends Sprite 
	{
		private var combo:Combo;
		private var style:LatinStyle;
		private var styleManager:IStyleManager;

		public function VisualTestCombo()
		{
			style = new LatinStyle();
			style.addEventListener( Event.COMPLETE, styleReady );
		}

		private function styleReady(event:Event):void 
		{
			
			styleManager = event.target as IStyleManager;
			combo = new Combo();
			combo.dropdownHeight = 200;
			combo.selectedStyleName = "combo";
			combo.defaultSelectedText = "Please choose a Category"; 
			combo.styleManager = styleManager;			
			
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			combo.addItem( new ComboItem( "Photo", "combo" )); 
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			
			
			combo.build();
			combo.setStyle();
			combo.arrange();
			combo.addEventListener( ComboEvent.ITEM_SELECTED, itemSelected );			
			addChild( combo );
		}

		private function itemSelected(event:ComboEvent):void 
		{
			trace( event.item.index, event.item.text );
		}
	}
}
