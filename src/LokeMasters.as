package
{
	import org.flixel.*;
	import com.godstroke.LokeMasters.MenuState
	[SWF(width="300", height="300", backgroundColor="#FFFFFF")]
	[Frame(factoryClass="Preloader")]

	public class LokeMasters extends FlxGame
	{
		public function LokeMasters()
		{
			super(300,300,MenuState,1);
			
			showLogo = false;
		}
	}
}
