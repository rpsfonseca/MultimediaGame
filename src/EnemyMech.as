package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;

	public class EnemyMech {
		var main: Main;
		var bg: Lvl;
		var man: Man;
		var enemy: Enemy;
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

		public function EnemyMech(man: Man, main: Main, bg: Lvl, enemy: Enemy) {
			this.main = main;
			enemy = enemy;
			this.main.bg.addChild(enemy);
			bullet = new Bullet();
		}

		public function Move(e: Event) {
			// Make enemy follow man, if he is near
			if ( Math.sqrt(Math.pow(man.x,2) + Math.pow(enemy.x, 2)) < 10 ) {
				
				// Change animation direction accordingly to move 
				if (main.mechanics.speedX < 0) {
					enemy.scaleX = -1;
				} else if (main.mechanics.speedX > 0) {
					enemy.scaleX = 1;
				}
				enemy.x += main.mechanics.speedX;
			}
		}
	}
}