package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class Game extends MovieClip {
		var menu: Menu;
		var sight: Sight;

		public function Game() {
			menu = new Menu(this);
			sight = new Sight(this);
			stage.displayState = StageDisplayState.FULL_SCREEN;

		}
	}
}