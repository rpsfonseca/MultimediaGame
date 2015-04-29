package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var char: Char;
		var bg: Lvl1;

		public function Level1(main: Main, mechanics: Mechanics) {
			this.main = main;
			char = new Char();
			bg = new Lvl1();
			this.mechanics = new Mechanics(char, this.main, bg);

			this.addChild(bg);
			this.addChild(char);
			char.x = 400;
			char.y = 650;
			bg.y = 720;

			char.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			char.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			char.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			char.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
		}
	}
}