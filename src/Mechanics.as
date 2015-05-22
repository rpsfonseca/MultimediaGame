package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;

	public class Mechanics {
		var main: Main;
		var bg: Lvl;
		var man: Man;
		var orient: Number = 2;
		var jumping: Boolean = false;
		var gravity = 3;
		var speedX = 0;
		var accelX = 2;
		var manSpeed: Number;
		var maxSpeed = 22;
		var walkSpeed = 12;
		var speedY = 0;
		var impulsion = 30;
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
		var slide: Boolean = false;

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
				if (man.y == ground) {
					if (!slide) {
						speedY = -impulsion;
						jumping = true;
						if (ready) {
							slide = true;
							if (main.controls.leftkeydown)
								speedX -= 15;
							else if (main.controls.rightkeydown)
								speedX += 15;
						}
					}
				}
			}

			if (!slide) {
				if (main.controls.rightkeydown && speedX < manSpeed) {
					speedX += accelX;
				} else if (main.controls.leftkeydown && speedX > -manSpeed && man.x > 40) {
					speedX -= accelX;
				}
			}
			if (speedX < 0) {
				speedX += 1;
			} else if (speedX > 0) {
				speedX -= 1;
			}
		}

		public function Animate(e: Event) {
			if (ready) {
				//code in ToggleReady function
			} else if (jumping)
				man.gotoAndStop(2);
			else if (speedX > 0) {
				if (orient == 1) {
					man.x -= 40;
					orient = 2;
					man.scaleX = 1;
				}
				if (speedX > 12) {
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
				if (speedX < -12) {
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
				if (slide) {
					if ((speedX < 0 && orient == 2) || (speedX > 0 && orient == 1)) {
						man.gotoAndStop(10);
						man.rArm.x = 4;
						man.rArm.y = -22;
						man.lArm.x = -5;
						man.lArm.y = -16;
					} else if ((speedX < 0 && orient == 1) || (speedX > 0 && orient == 2)) {
						man.gotoAndStop(9);
						man.rArm.x = 70;
						man.rArm.y = -50;
						man.lArm.x = 66;
						man.lArm.y = -48;
					}
					if (!jumping && main.controls.spacekeydown && speedX > -4 && speedX < 4) {
						slide = false;
						main.controls.spacekeydown = false;
					}
				} else if (jumping) {
					if ((speedX < 0 && orient == 2) || (speedX > 0 && orient == 1)) {
						man.gotoAndStop(10);
						man.rArm.x = 4;
						man.rArm.y = -22;
						man.lArm.x = -5;
						man.lArm.y = -16;
					} else if ((speedX < 0 && orient == 1) || (speedX > 0 && orient == 2)) {
						man.gotoAndStop(9);
						man.rArm.x = 70;
						man.rArm.y = -50;
						man.lArm.x = 66;
						man.lArm.y = -48;
					}
				} else if (speedX != 0) {
					man.gotoAndStop(8);
					man.rArm.x = 66;
					man.rArm.y = -112;
					man.lArm.x = 84;
					man.lArm.y = -116;
				} else {
					man.gotoAndStop(7);
					man.rArm.x = 8;
					man.rArm.y = -122;
					man.lArm.x = 24;
					man.lArm.y = -128;
				}
				maxSpeed = 18;
				walkSpeed = 18;
				main.stage.addEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			} else {
				ready = false;
				maxSpeed = 22;
				walkSpeed = 12;
				main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, Shoot);
			}
			if (ready) {
				dx = main.stage.mouseX - (man.rArm.x + 15 + man.x);
				dy = main.stage.mouseY - (man.rArm.y + man.y);
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