package actors
{
	
	import flash.display.MovieClip;
	
	
	public class PowerUp extends MovieClip 
	{		
		public function PowerUp() 
		{
			addChild(new PowerUpArt())
			this.x= 550;
			this.y= 300;
		}
	}
	
}
