package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class Main extends MovieClip{
		var menu: Menu;
		var sights: Sights;
		var level1: Level1;
		
		public function Main() {
			menu = new Menu(this);
			sights = new Sights(this);
			level1 = new Level1(this);
			addChild(menu);
			addChild(sights.sights);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
	}
}
