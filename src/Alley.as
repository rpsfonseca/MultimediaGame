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

		public function Alley(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			pass = false;
			this.main = main;
			man = new Man();
			bg = new AlleyLvl();
			this.mechanics = new Mechanics(man, this.main, bg);
						
			this.addChild(bg);
			this.addChild(man);
			man.x = 400;
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
