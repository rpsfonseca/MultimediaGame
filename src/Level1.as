package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var bg: Lvl;
		var pass: Boolean = false;
		var entering: Boolean = false;
		var man: Man;

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
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			this.mechanics.ground = 650;
			this.mechanics.border1 = 0;
			this.mechanics.border2 = -1324;
			this.mechanics.lim1 = 80;
			this.mechanics.lim2 = 1100;


			pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);
			this.addEventListener(Event.ENTER_FRAME, move2Alley);

		}

		function move2Alley(e: Event) {
			if (man.x > 900 && man.x < 1200) {
				if (main.controls.upkeydown) {
					entering = true;
				}
				if (entering) {
					main.controls.rkeydown = false;
					if (bg.alpha > 0) {
						man.alpha -= 0.033;
						bg.alpha -= 0.033;
						this.mechanics.speedX = 0;
						this.mechanics.speedY = 0;
						man.scaleX = 1;
						man.gotoAndStop(6);
						man.y -= 6;
					} else {
						removeChild(bg);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
						removeChild(man);
						main.removeChild(main.level1);
						main.removeChild(main.sights.sights);
						main.alley = new Alley(main, mechanics, main.pauseMenu);
						main.addChild(main.alley);
						main.alley.man.x = 400;
						main.addChild(main.sights.sights);
						removeEventListener(Event.ENTER_FRAME, move2Alley);
					}
				}
			}
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