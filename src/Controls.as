package {
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;

	public class Controls extends MovieClip {
		var main: Main;

		public var leftkeydown: Boolean = false;
		public var upkeydown: Boolean = false;
		public var rightkeydown: Boolean = false;
		public var downkeydown: Boolean = false;
		public var capslockdown: Boolean = false;
		public var pkeydown: Boolean = false;
		public var enterkeydown: Boolean = false;
		public var spacekeydown: Boolean = false;
		public var rkeydown: Boolean = false;
		public var ekeydown: Boolean = false;

		public function Controls(main: Main) {
			this.main = main;
			main.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			main.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);

		}
		public function checkKeysDown(event: KeyboardEvent): void {
			if (event.keyCode == 65) {
				leftkeydown = true;
			}
			if (event.keyCode == 87) {
				upkeydown = true;
			}
			if (event.keyCode == 68) {
				rightkeydown = true;
			}
			if (event.keyCode == 83) {
				downkeydown = true;
			}
			if (event.keyCode == 20) {
				if (capslockdown)
					capslockdown = false;
				else
					capslockdown = true;
			}
			if (event.keyCode == 80 || event.keyCode == 27) {
				if (pkeydown)
					pkeydown = false;
				else
					pkeydown = true;
			}
			if (event.keyCode == 13) {
				enterkeydown = true;
			}
			if (event.keyCode == 32) {
				spacekeydown = true;
			}
			if (event.keyCode == 82) {
				if (rkeydown)
					rkeydown = false;
				else
					rkeydown = true;
			}
			if(event.KeyCode == 69) {
				if(ekeydown)
					ekeydown = false;
				else
					ekeydown = true;
			}
		}

		public function checkKeysUp(event: KeyboardEvent): void {
			if (event.keyCode == 65) {
				leftkeydown = false;
			}
			if (event.keyCode == 87) {
				upkeydown = false;
			}
			if (event.keyCode == 68) {
				rightkeydown = false;
			}
			if (event.keyCode == 83) {
				downkeydown = false;
			}
			if (event.keyCode == 13) {
				enterkeydown = false;
			}
			if (event.keyCode == 32) {
				spacekeydown = false;
			}
		}
	}
}
