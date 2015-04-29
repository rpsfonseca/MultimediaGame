package {
	import flash.display.MovieClip;
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

	public class Menu extends MovieClip {
		public var main: Main;
		var newBtn: NewGameBtn = new NewGameBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var intro: Intro;
		var menuScr: MenuScr = new MenuScr();
		var introTimer: Timer = new Timer(1000, 1);
		var cityAmbience: Sound = new Sound();
		var request: URLRequest = new URLRequest("C:\\Users\\Pedro\\Documents\\OutOfHand\\MultimediaGame\\sound\\menu.mp3");
		var myTransform = new SoundTransform();
		var menuSound:SoundChannel = new SoundChannel();



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
			cityAmbience.addEventListener(Event.COMPLETE, onSoundLoaded);
			cityAmbience.load(request);

		}
		
		function newBtnClick(e: MouseEvent): void {
			intro = new Intro();
			this.removeChild(newBtn);
			this.removeChild(quitBtn);
			this.removeChild(menuScr);
			this.addChild(intro);
			newBtn.removeEventListener(MouseEvent.MOUSE_DOWN, newBtnClick);
			quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, quitBtnClick);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, checkSkip);
			introTimer.start();
		}
		function quitBtnClick(e: MouseEvent): void {
			NativeApplication.nativeApplication.exit();
		}

		function TimerHandler(event: TimerEvent): void {
			Skip_Intro();
		}
		function checkSkip(event: KeyboardEvent): void {
			if (event.keyCode == 13) {
				Skip_Intro();
			}
		}
		function Skip_Intro(): void {
			introTimer.stop();
			this.removeChild(intro);
			main.addChild(main.level1);
			main.removeChild(main.sights.sights);
			main.addChild(main.sights.sights);
			main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkSkip);
			introTimer.removeEventListener(TimerEvent.TIMER, TimerHandler);
			main.removeChild(main.menu);
		}

		function onSoundLoaded(event: Event): void {
			menuSound = cityAmbience.play();
			myTransform.volume = 0.1;
			menuSound.soundTransform = myTransform;
		}
	}
}