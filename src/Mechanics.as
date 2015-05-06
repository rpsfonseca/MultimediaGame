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
			else if (man.x > 0){
				if(man.x <80){
					man.x = 80;
				}
				man.x += speedX;
				if(man.x >1100){
					man.x = 1100;
				}
			}
				

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
				if (speedX > 8) {
					man.gotoAndStop(4);
				} else
					man.gotoAndStop(3);
			} else if (speedX < 0) {
				if (orient == 2) {
					man.x += 40;
					orient = 1;
				}
				man.scaleX = -1;
				if (speedX < -8) {
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
				maxSpeed = 18;
				accelX = 2;
			} else {
				maxSpeed = 8;
				accelX = 1;
			}
		}

		public function ToggleReady(e: Event): void {
			dx = main.stage.mouseX - man.x + 15;
			dy = main.stage.mouseY - man.y + 115;
			if ((Math.atan2(dy, dx) * 180 / Math.PI) > -90 && (Math.atan2(dy, dx) * 180 / Math.PI) < 90) {
				man.rArm.rotation = (Math.atan2(dy, dx) * 180 / Math.PI);
				man.lArm.rotation = man.rArm.rotation;
				
			} else {
				man.rArm.rotation = -(Math.atan2(dy, dx) * 180 / Math.PI);
				man.lArm.rotation = man.rArm.rotation;
				
			}
			if (main.controls.rkeydown) {
				man.rArm.alpha = 1;
				man.lArm.alpha = 1;
				ready = true;
			} else {
				man.rArm.alpha = 0;
				man.lArm.alpha = 0;
				ready = false;
			}
			main.stage.addEventListener(MouseEvent.MOUSE_DOWN, Shoot);
		}
		public function Shoot(e: MouseEvent): void {
			man.rArm.gotoAndPlay(1);
			man.lArm.gotoAndPlay(1);
		}
	}
}