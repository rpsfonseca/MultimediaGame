﻿package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;

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
		var bullet: Bullet;
		var mcArray: Array = new Array();
		var i: Number = -1;
		var bulletSpeedx: Array = new Array();
		var bulletSpeedy: Array = new Array();

		public function Mechanics(man: Man, main: Main, bg: Lvl1) {
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

				if (speedX > 8) {
					man.gotoAndStop(4);
				} else
					man.gotoAndStop(3);
			} else if (speedX < 0) {

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
			if (main.controls.rkeydown) {
				man.rArm.alpha = 1;
				man.lArm.alpha = 1;
				ready = true;
				main.stage.addEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			} else {
				man.rArm.alpha = 0;
				man.lArm.alpha = 0;
				ready = false;
				main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			}
			
		}
		public function Shoot(e: MouseEvent): void {
			man.rArm.gotoAndPlay(1);
			man.lArm.gotoAndPlay(1);
			var newMC: Bullet = new Bullet();
			this.main.addChild(newMC);
			i++;
			mcArray[i]=newMC;
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
			for (var i=0;i<mcArray.length;i++){				
				mcArray[i].x += 100 * (bulletSpeedx[i]);
				mcArray[i].y += 100 * (bulletSpeedy[i]);
			}
		}
	}
}