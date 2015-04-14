package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;

	public class Game extends MovieClip {
		var menu: Menu;
		public function Game() {
			menu = new Menu(this);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
	}
}