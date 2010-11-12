package test.com.wezside.components.combo 
{
	import com.wezside.components.combo.ComboEvent;
	import com.wezside.components.decorators.shape.ShapeRectangle;
	import com.wezside.components.combo.ComboItem;
	import com.wezside.components.combo.Combo;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestCombo extends Sprite 
	{
		private var combo:Combo;

		public function VisualTestCombo()
		{
			
			combo = new Combo();
			combo.dropdownHeight = 200;
			combo.dropdownBackground = new ShapeRectangle( combo );
			combo.dropdownBackground.colours = [ 0xcccccc ];
			combo.dropdownBackground.alphas = [ 1 ];
			combo.dropdownBackground.height = combo.dropdownHeight;
			combo.defaultSelectedText = "Please choose a Category"; 
			
			combo.addItem( new ComboItem( "Cameras" )); 
			combo.addItem( new ComboItem( "Phones" )); 
			combo.addItem( new ComboItem( "TVs" )); 
			combo.addItem( new ComboItem( "Photo" )); 
			combo.addItem( new ComboItem( "Cameras" )); 
			combo.addItem( new ComboItem( "Phones" )); 
			combo.addItem( new ComboItem( "TVs" )); 
			combo.addItem( new ComboItem( "Photo" )); 
			combo.addItem( new ComboItem( "Cameras" )); 
			combo.addItem( new ComboItem( "Phones" )); 
			combo.addItem( new ComboItem( "TVs" )); 
			combo.addItem( new ComboItem( "Photo" )); 
			combo.addItem( new ComboItem( "Cameras" )); 
			combo.addItem( new ComboItem( "Phones" )); 
			combo.addItem( new ComboItem( "TVs" )); 
			combo.addItem( new ComboItem( "Photo" )); 
			combo.addItem( new ComboItem( "Cameras" )); 
			combo.addItem( new ComboItem( "Phones" )); 
			combo.addItem( new ComboItem( "TVs" )); 
			combo.addItem( new ComboItem( "Photo" )); 
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
