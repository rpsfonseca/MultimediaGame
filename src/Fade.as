package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Fade extends MovieClip {
		var main: Main;
		var pauseMenu: PauseMenu;
		var mechanics: Mechanics;
		var level: Level;

		public function Fade(main: Main, level: Level) {
			this.main = main;
			this.level = level;
		}


		function fadeOutLevel1() {
			if ((level.intro.currentFrame >= 50) && (level.intro.currentFrame < 80)) {
				main.fade.alpha += 0.033;
			}
		}

	}