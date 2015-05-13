﻿package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var bg: Lvl1;
		var pass: Boolean = false;
		var man: Man;

		public function Level1(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			//super(main, mechanics, pauseMenu);
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
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			
			pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);

		}
	}
/*
	function interaction() {
		if ( man.x == VER VALOR ) {
			if ( main.controls.ekeydown && pass == false) {
				pass = true;
				//start dialog animation
			}
			else if(main.controls.ekeydown && pass == true) {
				//start filler dialog animation
			}
		}
	}*/

	/*function onFinish(e: Event) {
		this.main.stage.alpha -= 0.5 // change this value as per the speed of fade required

		if ( this.main.stage.alpha <= 0 ) {
		    this.main.stage.visible = false
		    this.main.stage.alpha = 1 ;
		    removeEventListener(Event.ENTER_FRAME, onFinish); // TODO: CHECK EVENTS ENTER_FRAME
		}
	}*/
}
