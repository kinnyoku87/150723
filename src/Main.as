package
{
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	
	import initializers.Initializer150723_A;
	
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.core.MobilePlatform;
	import org.agony2d.logging.FlashTextLogger;
	
	[SWF(width="450", height="800", backgroundColor = "0x0", frameRate="30")]
	public class Main extends Sprite
	{
		public function Main()
		{
			var logger:FlashTextLogger;
			
//			logger = new FlashTextLogger(stage, true, 220, 440, 770, true);
//			Agony.getLog().logger = logger;
//			logger.visible = true;
			
			if(Multitouch.maxTouchPoints == 0){
				Agony.startup(1080, 1920, new DesktopPlatform, stage, Initializer150723_A);
				//			Security.allowDomain("*");
			}
			else{
				Agony.startup(1080, 1920, new MobilePlatform(false), stage, Initializer150723_A);
			}
		}
	}
}