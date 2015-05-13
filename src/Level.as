package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Level extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var pauseMenu: PauseMenu;


		public function Level(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			this.main = main;
			pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);
			this.addChild(main.pauseMenu);

			}
		}
	}