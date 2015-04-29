package {

	import flash.events.Event;

	public class Engine {
		var main: Main;
		var bg: Lvl1;
		var char: Char;
		var orient: Number = 2;
		var jumping: Boolean = false;
		var gravity = 4;
		var speedX = 6;
		var speedY = 0;
		var impulsion = 30;

		public function Engine(char: Char, main: Main, bg: Lvl1) {
			this.char = char;
			this.main = main;
			this.bg = bg;
		}

		function Gravity(pEvent) {

			speedY += gravity;

			// Move the hero with his speedY
			char.y += char.speedY;

			// If the y property is larger than the floor position
			if (char.y > 650) {
				// Set the char on the floor
				char.y = 650;
				// Cancel the current speed
				speedY = 0;
				jumping = false;
			}
		}
		function Move(e: Event) {
			if (main.controls.upkeydown) {
				jumping = true;
				if (char.y == 650)
					speedY = -impulsion;
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

		function Animate(e: Event) {
			if (jumping)
				char.gotoAndStop(3);
			else if (main.controls.rightkeydown || main.controls.leftkeydown)
				char.gotoAndStop(2);
			else
				char.gotoAndStop(1);
		}

	}

}