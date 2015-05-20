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

	public class Menu extends MovieClip {
		public var main: Main;
		var newBtn: NewGameBtn = new NewGameBtn();
		var quitBtn: QuitBtn = new QuitBtn();
		var intro: Intro;
		var menuScr: MenuScr = new MenuScr();
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
			main.stage.addEventListener(Event.ENTER_FRAME, checkSkip);
		}

		function quitBtnClick(e: MouseEvent): void {
			NativeApplication.nativeApplication.exit();
		}

		function checkSkip(event: Event): void {
			if ((this.intro.currentFrame == 830) || (main.controls.enterkeydown)){
				Skip_Intro();
			}
		}

		function Skip_Intro(): void {
			this.removeChild(intro);
			main.addChild(main.level1);
			main.removeChild(main.sights.sights);
			main.addChild(main.sights.sights);
			main.stage.removeEventListener(Event.ENTER_FRAME, checkSkip);
			main.removeChild(main.menu);
		}

		function onSoundLoaded(event: Event): void {
			menuSound = cityAmbience.play();
			myTransform.volume = 0.1;
			menuSound.soundTransform = myTransform;
		}
	}
}