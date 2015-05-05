package {
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class Mechanics {
		var main: Main;
		var bg: Lvl1;
		var man: Man;
		var orient: Number = 2;
		var jumping: Boolean = false;
		var gravity = 4;
		var speedX = 0;
		var accelX = 1;
		var maxSpeed = 6;
		var speedY = 0;
		var impulsion = 40;
		var border1 = 0;
		var border2 = 1324;
		var dx: Number;
		var dy: Number;
		var ready: Boolean;

		public function Mechanics(man: Man, main: Main, bg: Lvl1) {
			this.main = main;
			this.bg = bg;
			this.man = man;
		}

		public function Gravity(e: Event) {

			speedY += gravity;
			man.y += speedY;

			if (man.y > 650) {
				man.y = 650;
				speedY = 0;
				jumping = false;
			}
		}

		public function Move(e: Event) {
			if ((man.x >= 640 && bg.x > -1324 && speedX > 0) || (man.x < 400 && bg.x < -10 && speedX < 0))
				bg.x -= speedX;
			else if (man.x > 0 || man.x < 1280)
				man.x += speedX;

			if (main.controls.spacekeydown) {
				jumping = true;
				if (man.y == 650)
					speedY = -impulsion;
			}

			if (main.controls.rightkeydown && speedX < maxSpeed) {
				speedX += accelX;
			} else if (main.controls.leftkeydown && speedX > -maxSpeed && man.x > 40) {
				speedX -= accelX;
			} else if (speedX < 0) {
				speedX += 1;
			} else if (speedX > 0) {
				speedX -= 1;
			}

			/*dx = main.stage.mouseX - man.x;
			dy = main.stage.mouseY - man.y + 120;
			man.rotation = (Math.atan2(dy, dx) * 180 / Math.PI);*/
		}

		public function Animate(e: Event) {
			if (jumping)
				man.gotoAndStop(2);
			else if (speedX > 0) {
				if (orient == 1) {
					man.x -= 40;
					orient = 2;
				}
				man.scaleX = 1;
				if (speedX > 6) {
					man.gotoAndStop(4);
				} else
					man.gotoAndStop(3);
			} else if (speedX < 0) {
				if (orient == 2) {
					man.x += 40;
					orient = 1;
				}
				man.scaleX = -1;
				if (speedX < -6) {
					man.gotoAndStop(4);
				} else
					man.gotoAndStop(3);
			} else
			if (ready)
				man.gotoAndStop(6);
			else
				man.gotoAndStop(1);
		}

		public function ToggleSprint(e: Event) {
			if (main.controls.capslockdown) {
				maxSpeed = 14;
				accelX = 2;
			} else {
				maxSpeed = 6;
				accelX = 1;
			}
		}
		public function ReadyStance(e: Event): void {
			dx = main.stage.mouseX - man.x + 15;
			dy = main.stage.mouseY - man.y + 115;
			man.arms.rotation = (Math.atan2(dy, dx) * 180 / Math.PI);
			if (speedX == 0) {
				man.arms.alpha = 1;
				ready = true;
			} else {
				man.arms.alpha = 0;
				ready = false;
			}
		}
	}
}