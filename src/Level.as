package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;


    public function Level(main: Main, mechanics: Mechanics, man: Man){
      this.main = main;
      man = new Man();



      this.addChild(man);
      pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);
      man.mouseEnabled = false;
      this.addChild(pauseMenu);

      man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);





    }
