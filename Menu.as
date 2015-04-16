package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent

	public class Menu extends MovieClip {
		public var main: Main;
		var newBtn: NewGameBtn = new NewGameBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var intro: Intro;
		var menuScr: MenuScr = new MenuScr();		
		var introTimer: Timer = new Timer(27000, 1);

		public function Menu(main: Main) {
			this.main = main;
			this.addChild(menuScr);
			this.addChild(newBtn);
			this.addChild(quitBtn);
			newBtn.x = 30;
			newBtn.y = 30;
			quitBtn.x = 30;
			quitBtn.y = 60;
			newBtn.addEventListener(MouseEvent.MOUSE_DOWN, newBtnClick);
			quitBtn.addEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
			introTimer.addEventListener(TimerEvent.TIMER, TimerHandler);
		}
		function newBtnClick(e: MouseEvent): void {
			intro = new Intro();
			this.removeChild(newBtn);
			this.removeChild(quitBtn);
			this.removeChild(menuScr);
			this.addChild(intro);
			newBtn.removeEventListener(MouseEvent.MOUSE_DOWN, newBtnClick);
			quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
			introTimer.start();
		}
		function quitBtnClick(e: MouseEvent): void {
			fscommand("quit");
		}

		function TimerHandler(event: TimerEvent): void {
			main.addChild(main.level1);
			main.removeChild(main.sights.sights);
			main.addChild(main.sights.sights);
			main.removeChild(main.menu);
		}
	}
}