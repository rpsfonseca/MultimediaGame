package {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;

	public class Level1 extends MovieClip {
		var leftkeydown: Boolean = false;
		var upkeydown: Boolean = false;
		var rightkeydown: Boolean = false;
		var downkeydown: Boolean = false;
		var main: Main;

		public function Level1(main: Main) {
			this.main = main;
			var char: Char = new Char();
			var bg: Lvl1 = new Lvl1();
			main.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			main.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
			this.addChild(bg);
			this.addChild(char);
			char.x = 400;
			char.y = 650;
			bg.y = 720;
			char.addEventListener(Event.ENTER_FRAME, AnimateChar);
			function AnimateChar(e: Event) {
				if (rightkeydown) {
					char.x += 4;
					char.scaleX = 1;
					char.gotoAndStop(2);
				} else if (leftkeydown) {
					char.x -= 4;
					char.scaleX = -1;
					char.gotoAndStop(2);
				} else {
					char.gotoAndStop(1);
				}
			}
		}

		//Keys Pressed Function

		function checkKeysDown(event: KeyboardEvent): void {
			if (event.keyCode == 37 || event.keyCode == 65) {
				leftkeydown = true;
			}
			if (event.keyCode == 38 || event.keyCode == 87) {
				upkeydown = true;
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				rightkeydown = true;
			}
			if (event.keyCode == 40 || event.keyCode == 83) {
				downkeydown = true;
			}
		}

		//Keys Released Function

		function checkKeysUp(event: KeyboardEvent): void {
			if (event.keyCode == 37 || event.keyCode == 65) {
				leftkeydown = false;
			}
			if (event.keyCode == 38 || event.keyCode == 87) {
				upkeydown = false;
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				rightkeydown = false;
			}
			if (event.keyCode == 40 || event.keyCode == 83) {
				downkeydown = false;
			}
		}
	}
}