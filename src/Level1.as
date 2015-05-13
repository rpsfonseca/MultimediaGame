package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Level1 extends Level {
		var bg: Lvl1;
		var pass: Boolean;

		public function Level1(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			super(main,mechanics,pauseMenu);
			bg = new Lvl1();
			this.mechanics = new Mechanics(man, this.main, bg);

			this.addChild(bg);
			this.pass = false;

			man.x = 400;
			man.y = 650;
			bg.y = 720;

		}
	}

	function interaction() {
		if ( man.x == /* VER VALOR */ ) {
			if ( main.controls.ekeydown && pass == false) {
				pass = true;
				//start dialog animation
			}
			else if(main.controls.ekeydown && pass == true) {
				//start filler dialog animation
			}
		}
	}

	/*function onFinish(e: Event) {
		this.main.stage.alpha -= 0.5 // change this value as per the speed of fade required

		if ( this.main.stage.alpha <= 0 ) {
		    this.main.stage.visible = false
		    this.main.stage.alpha = 1 ;
		    removeEventListener(Event.ENTER_FRAME, onFinish); // TODO: CHECK EVENTS ENTER_FRAME
		}
	}*/
}
