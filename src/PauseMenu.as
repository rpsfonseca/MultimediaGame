﻿package {
	import flash.display.MovieClip;
	import flash.system.fscommand;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class PauseMenu extends MovieClip{
		var main: Main;
		var paused = false;
		var pauseTimer: Timer = new Timer(33, 0);
		var opBtn: QuitBtn = new QuitBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var resBtn: QuitBtn = new QuitBtn();

		public function PauseMenu(main: Main) {
			this.main = main;
			pauseTimer.start();
		}
		public function pauseGame(e: TimerEvent) {
			if (main.controls.pkeydown) {
				if (!paused) {
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
					stage.frameRate = 0;
				}
			} else if (paused) {
				this.removeChild(opBtn);
				this.removeChild(quitBtn);
				this.removeChild(resBtn);
				opBtn.removeEventListener(MouseEvent.MOUSE_DOWN, opBtnClick);
				quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
				resBtn.removeEventListener(MouseEvent.MOUSE_DOWN, resBtnClick);

				this.paused = false;
				stage.frameRate = 30;
			}
		}

		function opBtnClick(e: MouseEvent): void {

		}

		function quitBtnClick(e: MouseEvent): void {
			fscommand("quit");
		}

		function resBtnClick(e: MouseEvent): void {
			main.controls.pkeydown = false;
		}
	}

}