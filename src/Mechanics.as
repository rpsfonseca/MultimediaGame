package {

	import flash.events.Event;

	public class Mechanics {
		var main: Main;
		var bg: Lvl1;
		var char: Char;
		var orient: Number = 2;
		var jumping: Boolean = false;
		var gravity = 4;
		var speedX = 0;
		var accelX = 1;
		var maxSpeed = 6;
		var speedY = 0;
		var impulsion = 30;
		var border1 = 0;
		var border2 = 640;

		public function Mechanics(char: Char, main: Main, bg: Lvl1) {
			this.main = main;
			this.bg = bg;
			this.char = char;
		}

		public function Gravity(e: Event) {

			speedY += gravity;
			char.y += speedY;

			if (char.y > 650) {
				char.y = 650;
				speedY = 0;
				jumping = false;
			}
		}

		public function Move(e: Event) {
			char.x += speedX;

			if (main.controls.upkeydown) {
				jumping = true;
				if (char.y == 650)
					speedY = -impulsion;
			}

			if (main.controls.rightkeydown && speedX < maxSpeed)  {
				speedX += accelX;
			} else if (main.controls.leftkeydown && speedX > -maxSpeed && char.x > 40) {
				speedX -= accelX;
			} else if (speedX <0) {
				speedX += accelX;
			} else if (speedX > 0) {
				speedX -= accelX;
			}
		}

		public function Animate(e: Event) {
			if (jumping)
				char.gotoAndStop(2);
			else if (speedX > 0) {
				if (orient == 1) {
					char.x -= 40;
					orient = 2;
				}
				char.scaleX = 1;
				if(speedX > 6){
					char.gotoAndStop(4);
				} else 
					char.gotoAndStop(3);
			}else if (speedX < 0) {
				if (orient == 2) {
					char.x += 40;
					orient = 1;
				}
				char.scaleX = -1;
				if(speedX < -6){
					char.gotoAndStop(4);
				} else 
					char.gotoAndStop(3);
			} else
				char.gotoAndStop(1);
		}

		public function ToggleSprint(e: Event) {
			if(main.controls.capslockdown){
				maxSpeed = 14;
				accelX = 2;
			} else {
				maxSpeed = 6;
				accelX = 1;
			}
		}
		
	}
}