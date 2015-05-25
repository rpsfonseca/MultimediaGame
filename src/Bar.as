package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.KeyboardEvent;

	public class Bar extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;
		var bg: Lvl;
		var fadeout: Boolean = false;
		var fadein: Boolean = false;
		var color: Color = new Color();
		var enemyArray: Array = new Array();
		var enemyHealth: Array = new Array();
		var enemymechs: Array = new Array();
		var boss: Boss;
		var counter: Number = 0;
		var health: Number = 100;

		public function Bar(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			main.pass = true;
			this.main = main;
			man = new Man();
			bg = new Lvl2();
			this.mechanics = new Mechanics(man, this.main, bg);

			this.addChild(bg);
			this.addChild(man);
			man.y = 680;
			bg.y = 720;

			this.addChild(pauseMenu);

			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			this.mechanics.ground = 680;
			this.mechanics.border1 = 0;
			this.mechanics.border2 = -2500;
			this.mechanics.lim1 = 80;
			this.mechanics.lim2 = 1150;
			//this.addEventListener(Event.ENTER_FRAME, move2Lvl1);

			color.brightness = 0;

			boss = new Boss();
			boss.x = 3400;
			boss.y = -80;

			bg.addChild(boss);

			for (counter = 0; counter < 8; counter++) {
				var newEnemy: Enemy = new Enemy();
				bg.addChild(newEnemy);
				enemyArray[counter] = newEnemy;
				if (enemyArray[counter].x != 3400)
					enemyArray[counter].x = 2630 + (150 * counter);
				else
					enemyArray[counter].x = 3800;
				enemyArray[counter].y = -80;
				enemyArray[counter].gotoAndStop(1);
				enemyArray[counter].scaleX = -1;
				enemyHealth[counter] = 50;
				enemymechs[counter] = new EnemyMech(man, main, bg, enemyArray[counter]);
			}


			//this.addEventListener(Event.ENTER_FRAME, bulletCollision);
			/*enemy = new Enemy();
			bg.addChild(enemy);
			enemy.x = 1400;
			enemy.y = -80;*/

			this.addEventListener(Event.ENTER_FRAME, bulletCollision);
			//this.addEventListener(Event.ENTER_FRAME, enemyCollision);
			//enemy.gotoAndStop(1);

		}

		function bulletCollision(e: Event) {
			if (mechanics.i-- > 0) {
				for (var j = 0; j < this.mechanics.mcArray.length; j++) {
					for (var k = 0; k < enemyArray.length; k++) {
						trace("mcArray" + mechanics.mcArray[j]);
						trace("enemy" + enemyArray[k]);
						if (enemyHealth[k] <= 0) {
							enemyArray[k].gotoAndStop(4);
							enemymechs[k].dead = true;
						} else if (mechanics.mcArray[j].hitTestObject(enemyArray[k])) {
							main.removeChild(mechanics.mcArray[j]);
							mechanics.bulletSpeedx[j] = mechanics.bulletSpeedx[mechanics.mcArray.length - 1];
							mechanics.bulletSpeedy[j] = mechanics.bulletSpeedy[mechanics.mcArray.length - 1];
							mechanics.mcArray[j] = mechanics.mcArray[mechanics.mcArray.length - 1];
							mechanics.mcArray.pop();
							mechanics.i--;
							enemyArray[k].gotoAndStop(2);
							enemyHealth[k] -= 5;
						} else {
							enemyArray[k].gotoAndStop(1);
						}
					}
				}
			}
		}
		/*
		function enemyCollision(e: Event) {
			if (enemymechs.dead == false) {
				if (Math.sqrt(Math.pow(man.x - (bg.x + enemy.x), 2)) < 5) {
					health -= 5;
				}
				if (health <= 0) {
					trace("mataram me");
					// por animaçao de estar morto / por fps a 0 mas ter cuidado com as frames
				}
			}
		}*/


		/*function move2Lvl1(e: Event) {
			if (main.controls.downkeydown) {
				fadeout = true;
			}
			if (fadeout) {
				main.controls.rkeydown = false;
				if (bg.alpha > 0) {
					if (bg.alpha == 1) {
						main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
						main.controls.leftkeydown = false;
						main.controls.upkeydown = false;
						main.controls.rightkeydown = false;
						main.controls.downkeydown = false;
						main.controls.capslockdown = false;
						main.controls.pkeydown = false;
						main.controls.enterkeydown = false;
						main.controls.spacekeydown = false;
						main.controls.rkeydown = false;
						main.controls.ekeydown = false;
					}
					color.brightness -= 0.033;
					man.transform.colorTransform = color;
					bg.alpha -= 0.033;
				} else {
					if (!fadein) {
						this.removeChild(this.bg);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
						this.removeChild(man);
						main.removeChild(main.alley);
						main.removeChild(main.sights.sights);
						main.level1 = new Level1(main, mechanics, main.pauseMenu);
						color.brightness = -1;
						main.level1.man.transform.colorTransform = color;
						main.addChild(main.level1);
						main.addChild(main.sights.sights);
						main.level1.bg.x = -1332;
						main.level1.man.x = 1100;
						fadein = true;
						main.level1.bg.alpha = 0;
						main.level1.man.brightness = -1;
					} else {
						main.level1.bg.alpha += 0.033;
						if (color.brightness < 0)
							color.brightness += 0.033;
						main.level1.man.transform.colorTransform = color;
						if (main.level1.bg.alpha == 1) {
							this.removeEventListener(Event.ENTER_FRAME, move2Lvl1);
							main.stage.addEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
						}
					}
				}
			}
		}
		/*function interaction(){
		if( main.x == 100) //inserir raio e / ou posiçao de interaçao
			if(main.controls.ekeydown && pass == false){
				pass = true;
				//start animation for password
			} else if(main.controls.ekeydown && pass == true){
				//start filler animation
			}
		}*/
	}

	/*function onFinish(e: Event) {
		this.main.stage.alpha -= 0.5 // change this value as per the speed of fade required

		if ( this.main.stage.alpha <= 0 ) {
		    this.main.stage.visible = false
		    this.main.stage.alpha = 1 ;
		    removeEventListener(Event.ENTER_FRAME, onFinish); // TODO: CHECK EVENTS ENTER_FRAME
		}
	}*/


}