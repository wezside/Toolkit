package test.com.wezside.utilities.imaging 
{
	import com.wezside.utilities.imaging.GraphicsEx;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestGraphicsEx extends Sprite 
	{

		private var square:GraphicsEx;
		private var circle:GraphicsEx;


		public function VisualTestGraphicsEx()
		{
			square = new GraphicsEx( graphics );
			square.beginFill( 0xff0000, 1 );
			square.drawRect( 0, 0, 200, 40 );
			square.clear();
			
			circle = new GraphicsEx( graphics );
			circle.concat( square );
			circle.beginFill( 0xfff );
			circle.drawCircle( 100, 100, 50 );
		}
	}
}
