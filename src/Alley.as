package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Alley extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;
		var bg: Lvl;
		var pass: Boolean;
		var entering: Boolean = false;

		public function Alley(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			pass = false;
			this.main = main;
			man = new Man();
			bg = new AlleyLvl();
			this.mechanics = new Mechanics(man, this.main, bg);

			this.addChild(bg);
			this.addChild(man);
			man.y = 500;
			bg.y = 720;

			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			this.mechanics.ground = 500;
			this.mechanics.border1 = 0;
			this.mechanics.border2 = 1280;
			this.mechanics.lim1 = 500;
			this.mechanics.lim2 = 900;
			this.addEventListener(Event.ENTER_FRAME, move2Lvl1);

		}

		function move2Lvl1(e: Event) {
			if (main.controls.downkeydown) {
				entering = true;
			}
			if (entering) {
				
				main.controls.rkeydown = false;
				if (bg.alpha > 0) {
					this.mechanics.ground = 800;
					man.alpha -= 0.033;
					bg.alpha -= 0.033;
					this.mechanics.speedX = 0;
					this.mechanics.speedY = 0;
					man.scaleX = 1;
					man.y += 4;
					man.gotoAndStop(5);
				} else {
					this.removeChild(this.bg);
					man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
					man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
					man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
					man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
					man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
					this.removeChild(man);
					main.removeChild(main.alley);
					main.removeChild(main.sights.sights);
					main.level1 = new Level1(main, mechanics, main.pauseMenu);
					main.addChild(main.level1);
					main.addChild(main.sights.sights);
					main.level1.bg.x = -1332;
					main.level1.man.x = 1100;
					this.removeEventListener(Event.ENTER_FRAME, move2Lvl1);

				}
			}
		}
		/*function interaction(){
		if( main.x == 100) //inserir raio e / ou posiçao de interaçao
			if(main.controls.ekeydown && pass == false){
				pass = true;
				//start animation for password
			} else if(main.controls.ekeydown && pass == true){
				//start filler animation
			}
		}*/
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