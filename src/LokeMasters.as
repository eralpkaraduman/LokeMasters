package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class LokeMasters extends FlxGame
	{
		public function LokeMasters()
		{
			super(320,240,MenuState,2);
			showLogo = false;
		}
	}
}
