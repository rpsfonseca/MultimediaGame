package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Fade extends MovieClip {
		var main: Main;
    var pauseMenu: PauseMenu;
    var mechanics: Mechanics;
    var level1: Level1;

		public function Fade(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu, level1: Level1) {

		}


    function fadeOutLevel1(event: Event) {
			if ((level1.intro.currentFrame >= 50) && (level1.intro.currentFrame < 80)) {
				main.fade.alpha += 0.033;
			}
		}

	}
