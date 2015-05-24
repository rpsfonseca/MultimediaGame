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
		var enemy: Enemy;
		var enemyHealth: Number = 100;
		var enemymechs: EnemyMech;

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
			enemy = new Enemy();
			bg.addChild(enemy);
			enemy.x = 1400;
			enemy.y = -80;
			
			enemymechs = new EnemyMech(man, main, bg, enemy);
			
			this.addEventListener(Event.ENTER_FRAME, bulletCollision);
			enemy.gotoAndStop(1);



		}

		function bulletCollision(e: Event) {
			for (var j = 0; j < this.mechanics.mcArray.length; j++) {
				if (enemyHealth <= 0) {
					enemy.gotoAndStop(4);
					enemymechs.dead = true;
				} else if (mechanics.mcArray[j].hitTestObject(enemy)) {
					main.removeChild(mechanics.mcArray[j]);
					mechanics.bulletSpeedx[j] = mechanics.bulletSpeedx[mechanics.mcArray.length - 1];
					mechanics.bulletSpeedy[j] = mechanics.bulletSpeedy[mechanics.mcArray.length - 1];
					mechanics.mcArray[j] = mechanics.mcArray[mechanics.mcArray.length - 1]
					mechanics.mcArray.pop();
					mechanics.i--;
					enemy.gotoAndStop(2);
					enemyHealth -= 5;
				} else {
					enemy.gotoAndStop(1);
				}
			}
		}

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