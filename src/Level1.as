package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Level1 extends MovieClip {
		var main: Main;

		public function Level1(main: Main) {
			this.main = main;
			var char: Char = new Char();
			var bg: Lvl1 = new Lvl1();
			var orient: Number = 2;
			var jumping: Boolean = false;
			var gravity = 4;
			var speedX = 6;

			this.addChild(bg);
			this.addChild(char);
			char.x = 400;
			char.y = 650;
			bg.y = 720;

			//Gravity
			// Create and set the speedY property to 0
			char.speedY = 0
			// Create and set the jump impulsion
			char.impulsion = 36;
			// Add an enter frame event
			char.addEventListener(Event.ENTER_FRAME, GravityEnterFrame)
			function GravityEnterFrame(pEvent) {
				// On each frames...

				// Set the world gravity
				char.speedY += gravity;

				// Move the hero with his speedY
				char.y += char.speedY;

				// If the y property is larger than the floor position
				if (char.y > 650) {
					// Set the char on the floor
					char.y = 650;
					// Cancel the current speed
					char.speedY = 0;
					jumping = false;
				}
			}
			char.addEventListener(Event.ENTER_FRAME, MoveChar);
			function MoveChar(e: Event) {
				if (main.controls.upkeydown) {
					jumping = true;
					if (char.y == 650)
						char.speedY = -char.impulsion;
				}
				if (main.controls.rightkeydown) {
					if (orient == 1) {
						char.x -= 40;
						orient = 2;
					}
					if (char.x < 640 || bg.x <= -1320) {
						char.x += speedX;
						char.scaleX = 1;
					} else
						bg.x -= speedX;
				} else if (main.controls.leftkeydown) {
					if (orient == 2) {
						char.x += 40;
						orient = 1;
					}
					if (char.x > 100) {
						char.x -= speedX;
						char.scaleX = -1;
					}
				}
			}

			char.addEventListener(Event.ENTER_FRAME, AnimateChar);
			function AnimateChar(e: Event) {
				if (jumping)
					char.gotoAndStop(3);
				else if (main.controls.rightkeydown || main.controls.leftkeydown)
					char.gotoAndStop(2);
				else
					char.gotoAndStop(1);
			}
		}
	}
}