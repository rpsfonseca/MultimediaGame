package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class Main extends MovieClip{
		var menu: Menu;
		var sights: Sights;
		var level1: Level1;
		var controls: Controls;
		
		public function Main() {
			controls = new Controls(this);
			menu = new Menu(this);
			sights = new Sights(this);
			level1 = new Level1(this);
			addChild(controls);
			addChild(menu);
			addChild(sights.sights);
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
	}
}
