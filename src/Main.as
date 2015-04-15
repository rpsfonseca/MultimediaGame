package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class Main extends MovieClip{
		var menu: Menu;
		var sights: Sights;
		
		public function Main() {
			menu = new Menu(this);
			sights = new Sights(this);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}

	}
	
}
