package {
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;

	public class Menu extends MovieClip {
		public var main: Main;
		var newBtn: NewGameBtn = new NewGameBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var intro: Intro;
		var menuScr: MenuScr = new MenuScr();

		var cityAmbience: Sound = new Sound();

		var request: URLRequest = new URLRequest(".\\sound\\menu.mp3");
		var myTransform = new SoundTransform();
		var menuSound: SoundChannel = new SoundChannel();
		var fadeLevelIn: Boolean = false;


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
			cityAmbience.addEventListener(Event.COMPLETE, onSoundLoaded);
			cityAmbience.load(request);

		}

		function newBtnClick(e: MouseEvent): void {
			this.addEventListener(Event.ENTER_FRAME, Fade2Intro);
		}

		function Fade2Intro(e: Event) {
			if (newBtn.alpha > 0) {
				newBtn.alpha -= 0.033;
				quitBtn.alpha -= 0.033;
				newBtn.mouseEnabled = false;
				quitBtn.mouseEnabled = false;
			} else {
				intro = new Intro();
				this.removeChild(newBtn);
				this.removeChild(quitBtn);
				this.removeChild(menuScr);
				this.addChild(intro);
				newBtn.removeEventListener(MouseEvent.MOUSE_DOWN, newBtnClick);
				quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
				main.stage.addEventListener(Event.ENTER_FRAME, checkSkip);
				this.removeEventListener(Event.ENTER_FRAME, Fade2Intro);
			}
		}

		function quitBtnClick(e: MouseEvent): void {
			NativeApplication.nativeApplication.exit();
		}

		function checkSkip(event: Event): void {
			if ((this.intro.currentFrame == 800) || (main.controls.enterkeydown)) {
				this.addEventListener(Event.ENTER_FRAME, Skip_Intro);
			}
		}

		function Skip_Intro(e: Event): void {
			if (intro.alpha > 0) {
				intro.alpha -= 0.016;
			} else {
				if (!fadeLevelIn) {
					this.removeChild(intro);
					main.level1 = new Level1(main, main.mechanics, main.pauseMenu,true);
					main.addChild(main.level1);
					main.level1.alpha = 0;
					main.removeChild(main.sights.sights);
					main.addChild(main.sights.sights);
					main.stage.removeEventListener(Event.ENTER_FRAME, checkSkip);
					main.removeChild(main.menu);
					fadeLevelIn = true;
				} else if (main.level1.alpha < 1){
					main.level1.alpha += 0.016;
				} else
					this.removeEventListener(Event.ENTER_FRAME, Skip_Intro);
			}
		}

		function onSoundLoaded(event: Event): void {
			menuSound = cityAmbience.play();
			myTransform.volume = 0.1;
			menuSound.soundTransform = myTransform;
		}
	}
}