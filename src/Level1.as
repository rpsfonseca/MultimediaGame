package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var char: Char;
		var bg: Lvl1;
		var paused = false;
		var opBtn: OpBtn = new OpBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var resBtn: ResBtn = new ResBtn();

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

			main.addEventListener(Event.ENTER_FRAME, pauseGame);
		}

		public function pauseGame(e: KeyboardEvent) {
			if (main.controls.pkeydown) {
				if (!paused) {
					this.addChild(opBtn);
					this.addChild(quitBtn);
					this.addChild(resBtn);
					opBtn.addEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
					quitBtn.addEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
					resBtn.addEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

				    this.paused = true;
				}
				else {
					this.removeChild(opBtn);
					this.removeChild(quitBtn);
					this.removeChild(resBtn);
					opBtn.removeEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
					quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
					resBtn.removeEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

				    this.paused = false;
				}
			}
		}

		function opBtnClick(e: MouseEvent): void {
			
		}

		function quitBtnClick(e: MouseEvent): void {
			fscommand("quit");
		}
		
		function resBtnClick(e: MouseEvent): void {
			this.removeChild(opBtn);
			this.removeChild(quitBtn);
			this.removeChild(resBtn);
			opBtn.removeEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
			quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
			resBtn.removeEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

		    this.paused = false;
		}
	}
}