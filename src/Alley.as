package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Alley extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;
		var bg: Aly;
		var pass: Boolean;

		public function Alley(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			pass = false;
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

	function interaction(){
		if( main.x == ) //inserir raio e / ou posiçao de interaçao
			if(main.controls.ekeydown && pass == false){
				pass = true;
				//start animation for password
			}
			else if(main.controls.ekeydown && pass == true){
				//start filler animation
			}
	}
}
