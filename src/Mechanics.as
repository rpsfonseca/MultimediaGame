﻿package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;

	public class Mechanics {
		var main: Main;
		var bg: Lvl;
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
		var border1: Number;
		var border2: Number;
		var lim1: Number;
		var lim2: Number;
		var dx: Number;
		var dy: Number;
		var ready: Boolean;
		var bullet: Bullet;
		var mcArray: Array = new Array();
		var i: Number = -1;
		var bulletSpeedx: Array = new Array();
		var bulletSpeedy: Array = new Array();
		var ground: Number;
		var shootArmSwitch: Boolean = false;
		var shootFunction: Boolean = false;

		public function Mechanics(man: Man, main: Main, bg: Lvl) {
			this.main = main;
			this.bg = bg;
			this.man = man;
			bullet = new Bullet();
		}

		public function Gravity(e: Event) {

			speedY += gravity;
			man.y += speedY;

			if (man.y > ground) {
				man.y = ground;
				speedY = 0;
				jumping = false;
			}
			main.stage.focus = main.stage;
		}

		public function Move(e: Event) {
			if ((man.x >= 640 && bg.x > border2 && speedX > 0) || (man.x < 560 && bg.x < border1 && speedX < 0))
				bg.x -= speedX;
			else if (man.x > 0) {
				man.x += speedX;
				if (man.x < lim1) {
					man.x = lim1;
					speedX = 0;
				}
				if (man.x > lim2) {
					man.x = lim2;
					speedX = 0;
				}
			}

			if (main.controls.spacekeydown) {
				jumping = true;
				if (man.y == ground)
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
			if (ready) {
				if (speedX != 0) {
					man.gotoAndStop(8);
				} else {
					man.gotoAndStop(7);
				}
			} else if (jumping)
				man.gotoAndStop(2);
			else if (speedX > 0) {
				if (orient == 1) {
					man.x -= 40;
					orient = 2;
					man.scaleX = 1;
				}
				if (speedX > 10) {
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
				if (speedX < -10) {
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
				accelX = 2;
			}
		}

		public function ToggleReady(e: Event): void {
			if (main.controls.rkeydown) {
				ready = true;
				if (speedX != 0) {
					man.gotoAndStop(8);
					man.rArm.x = 70;
					man.rArm.y = -102;
					man.lArm.x = 66;
					man.lArm.y = -100;
				} else {
					man.gotoAndStop(7);
					man.rArm.x = 16;
					man.rArm.y = -116;
					man.lArm.x = 14;
					man.lArm.y = -118;
				}
				maxSpeed = 16;
				walkSpeed = 16;
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
			if (!shootFunction) {
				main.stage.addEventListener(Event.ENTER_FRAME, BulletMove);
				shootFunction = true;
			}
			if (shootArmSwitch) {
				man.rArm.gotoAndPlay(2);
				shootArmSwitch = false;
			} else {
				man.lArm.gotoAndPlay(2);
				shootArmSwitch = true;
			}
			var newMC: Bullet = new Bullet();
			main.addChild(newMC);
			i++;
			mcArray[i] = newMC;
			mcArray[i].rotation = Math.atan2(dy, dx) * 180 / Math.PI;
			if (speedX != 0) {
				if (shootArmSwitch) {
					if (orient == 2)
						mcArray[i].x = man.x + 20;
					else
						mcArray[i].x = man.x - 20;
					mcArray[i].y = man.y - 100;
				} else {
					if (orient == 2)
						mcArray[i].x = man.x + 20;
					else
						mcArray[i].x = man.x - 20;
					mcArray[i].y = man.y - 110;
				}
			} else {
				if (shootArmSwitch) {
					if (orient == 2)
						mcArray[i].x = man.x + 20;
					else
						mcArray[i].x = man.x - 20;
					mcArray[i].y = man.y - 140;
				} else {
					if (orient == 2)
						mcArray[i].x = man.x + 20;
					else
						mcArray[i].x = man.x - 20;
					mcArray[i].y = man.y - 130;
				}
			}
			bulletSpeedx[i] = dx;
			bulletSpeedy[i] = dy;
			var normal: Number;
			normal = Math.sqrt(Math.pow(bulletSpeedx[i], 2) + Math.pow(bulletSpeedy[i], 2));
			bulletSpeedx[i] /= normal;
			bulletSpeedy[i] /= normal;
		}

		public function BulletMove(e: Event): void {
			for (var j = 0; j < mcArray.length; j++) {
				mcArray[j].x += 80 * (bulletSpeedx[j]);
				mcArray[j].y += 80 * (bulletSpeedy[j]);
				if (mcArray[j].x > 1280 || mcArray[j].x < 0 || mcArray[j].y < 0 || mcArray[j].y > 720) {
					main.removeChild(mcArray[j]);
					bulletSpeedx[j] = bulletSpeedx[mcArray.length - 1];
					bulletSpeedy[j] = bulletSpeedy[mcArray.length - 1];
					mcArray[j] = mcArray[mcArray.length - 1]
					mcArray.pop();
					i--;
				}
			}
		}
	}
}