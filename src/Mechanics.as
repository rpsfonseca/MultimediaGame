package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;

	public class Mechanics {
		var main: Main;
		var bg: Lvl2;
		var man: Man;
		var orient: Number = 2;
		var jumping: Boolean = false;
		var gravity = 4;
		var speedX = 0;
		var accelX = 1;
		var manSpeed: Number;
		var maxSpeed = 18;
		var walkSpeed = 8;
		var speedY = 0;
		var impulsion = 40;
		var border1 = 0;
		var border2 = 1324;
		var dx: Number;
		var dy: Number;
		var ready: Boolean;
		var bullet: Bullet;
		var mcArray: Array = new Array();
		var i: Number = -1;
		var bulletSpeedx: Array = new Array();
		var bulletSpeedy: Array = new Array();

		public function Mechanics(man: Man, main: Main, bg: Lvl2) {
			this.main = main;
			this.bg = bg;
			this.man = man;
			bullet = new Bullet();
		}

		public function Gravity(e: Event) {

			speedY += gravity;
			man.y += speedY;

			if (man.y > 650) {
				man.y = 650;
				speedY = 0;
				jumping = false;
			}
			main.stage.focus = main.stage;
		}

		public function Move(e: Event) {
			if ((man.x >= 640 && bg.x > -1324 && speedX > 0) || (man.x < 400 && bg.x < -10 && speedX < 0))
				bg.x -= speedX;
			else if (man.x > 0) {
				if (man.x < 80) {
					man.x = 80;
				}
				man.x += speedX;
				if (man.x > 1100) {
					man.x = 1100;
				}
			}


			if (main.controls.spacekeydown) {
				jumping = true;
				if (man.y == 650)
					speedY = -impulsion;
			}

			if (main.controls.rightkeydown && speedX < manSpeed) {
				speedX += accelX;
			} else if (main.controls.leftkeydown && speedX > -manSpeed && man.x > 40) {
				speedX -= accelX;
			} else if (speedX < 0) {
				speedX += 1;
			} else if (speedX > 0) {
				speedX -= 1;
			}
		}

		public function Animate(e: Event) {
			if (ready)
				man.gotoAndStop(6);
			else if (jumping)
				man.gotoAndStop(2);
			else if (speedX > 0) {
				if (orient == 1) {
					man.x -= 40;
					orient = 2;
					man.scaleX = 1;
				}
				if (speedX > 8) {
					man.gotoAndStop(4);
				} else {
					man.gotoAndStop(3);
				}
			} else if (speedX < 0) {
				if (orient == 2) {
					man.x += 40;
					orient = 1;
					man.scaleX = -1;
				}
				if (speedX < -8) {
					man.gotoAndStop(4);
				} else {
					man.gotoAndStop(3);
				}
			} else
				man.gotoAndStop(1);
		}

		public function ToggleSprint(e: Event) {
			if (main.controls.capslockdown) {
				manSpeed = maxSpeed;
				accelX = 2;
			} else {
				manSpeed = walkSpeed;
				accelX = 1;
			}
		}

		public function ToggleReady(e: Event): void {
			if (main.controls.rkeydown) {
				ready = true;
				man.gotoAndStop(6);
				maxSpeed = 12;
				walkSpeed = 12;
				main.stage.addEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			} else {
				ready = false;
				maxSpeed = 18;
				walkSpeed = 8;
				main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			}
			if (ready) {
				dx = main.stage.mouseX - man.x + 15;
				dy = main.stage.mouseY - man.y + 115;
				if ((Math.atan2(dy, dx) * 180 / Math.PI) > -90 && (Math.atan2(dy, dx) * 180 / Math.PI) < 90) {
					man.rArm.rotation = (Math.atan2(dy, dx) * 180 / Math.PI);
					man.lArm.rotation = man.rArm.rotation;
					if (orient == 1) {
						man.x -= 40;
						orient = 2;
						man.scaleX = 1;
					}

				} else {
					man.rArm.rotation = (Math.atan2(dy, -dx) * 180 / Math.PI);
					man.lArm.rotation = man.rArm.rotation;

					if (orient == 2) {
						man.x += 40;
						orient = 1;
						man.scaleX = -1;
					}
				}
			}
		}
		public function Shoot(e: MouseEvent): void {
			man.rArm.gotoAndPlay(1);
			man.lArm.gotoAndPlay(1);
			var newMC: Bullet = new Bullet();
			this.main.addChild(newMC);
			i++;
			mcArray[i] = newMC;
			mcArray[i].rotation = Math.atan2(dy, dx) * 180 / Math.PI;
			mcArray[i].x = man.x + 20;
			mcArray[i].y = man.y - 120;
			bulletSpeedx[i] = dx;
			bulletSpeedy[i] = dy;
			var normal: Number;
			normal = Math.sqrt(Math.pow(bulletSpeedx[i], 2) + Math.pow(bulletSpeedy[i], 2));
			bulletSpeedx[i] /= normal;
			bulletSpeedy[i] /= normal;
			main.stage.addEventListener(Event.ENTER_FRAME, BulletMove);
		}

		public function BulletMove(e: Event): void {
			for (var i = 0; i < mcArray.length; i++) {
				mcArray[i].x += 100 * (bulletSpeedx[i]);
				mcArray[i].y += 100 * (bulletSpeedy[i]);
			}
		}
	}
}