package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.desktop.NativeApplication;

	public class PauseMenu extends MovieClip{
		var main: Main;
		var paused = false;
		var pauseTimer: Timer = new Timer(33, 0);
		var resBtn: ResBtn = new ResBtn();
		var opBtn: OptBtn = new OptBtn();
		var quitBtn: QuitBtn = new QuitBtn();

		public function PauseMenu(main: Main) {
			this.main = main;
			pauseTimer.start();
		}
		public function pauseGame(e: TimerEvent) {
			if (main.controls.pkeydown) {
				if (!paused) {
					this.main.level1.man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
					//this.main.level1.man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
					this.main.level1.man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
					this.main.level1.man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ReadyStance);

					this.addChild(opBtn);
					this.addChild(quitBtn);
					this.addChild(resBtn);
					resBtn.x = 30;
					opBtn.x = 30;
					quitBtn.x = 30;
					resBtn.y = 30;
					opBtn.y = 60;
					quitBtn.y = 90;
					opBtn.addEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
					quitBtn.addEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
					resBtn.addEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

					this.paused = true;
					//stage.frameRate = 0;
				}
			} else if (paused) {
				this.removeChild(opBtn);
				this.removeChild(quitBtn);
				this.removeChild(resBtn);
				opBtn.removeEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
				quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
				resBtn.removeEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

				this.main.level1.man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
				//this.main.level1.man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
				this.main.level1.man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
				this.main.level1.man.addEventListener(Event.ENTER_FRAME, this.mechanics.ReadyStance);


				this.paused = false;
				//stage.frameRate = 30;
			}
		}

		function opBtnClick(e: MouseEvent): void {

		}

		function quitBtnClick(e: MouseEvent): void {
			NativeApplication.nativeApplication.exit();
		}

		function resBtnClick(e: MouseEvent): void {
			main.controls.pkeydown = false;
		}
	}

}