package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;
		var bg: Lvl1;

		public function Level1(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			this.main = main;
			man = new Man();
			bg = new Lvl1();
			this.mechanics = new Mechanics(man, this.main, bg);

			this.addChild(bg);
			this.addChild(man);
			man.x = 400;
			man.y = 650;
			bg.y = 720;
			
			this.addChild(pauseMenu);

			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);

			pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);
		}
	}
}