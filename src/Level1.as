package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.KeyboardEvent;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Level1 extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var bg: Lvl;
		var man: Man;
		var fadeout: Boolean = false;
		var fadein: Boolean = false;
		var color: Color = new Color();
		var bouncer: Enemy;
		var txtLoader: URLLoader = new URLLoader();
		var formatText: FormatText;
		var textinscreen: Boolean = false;

		public function Level1(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			this.main = main;
			man = new Man();
			bg = new Lvl1();
			this.mechanics = new Mechanics(man, this.main, bg);
			formatText = new FormatText(main);

			this.addChild(bg);
			this.addChild(man);

			man.x = 400;
			man.y = 650;
			bg.y = 720;

			this.addChild(pauseMenu);

			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			this.mechanics.ground = 650;
			this.mechanics.border1 = 0;
			this.mechanics.border2 = -1324;
			this.mechanics.lim1 = 80;
			this.mechanics.lim2 = 1150;

			pauseMenu.pauseTimer.addEventListener(TimerEvent.TIMER, pauseMenu.pauseGame);
			this.addEventListener(Event.ENTER_FRAME, move2Alley);
			this.addEventListener(Event.ENTER_FRAME, move2Bar);

			color.brightness = 0;

			this.addEventListener(Event.ENTER_FRAME, Bouncer);
			bouncer = new Enemy();
			bg.addChild(bouncer);
			bouncer.gotoAndStop(1);
			bouncer.x = 2535;
			bouncer.y = -80;
			bouncer.scaleX = -1;

		}

		function Bouncer(e: Event) {
			if ((Math.sqrt(Math.pow(man.x - (bg.x + bouncer.x), 2))) < 200) {
				if (!textinscreen) {
					txtLoader.addEventListener(Event.COMPLETE, formatText.onLoaded);
					textinscreen = true;
				}
				if (!main.pass) {
					txtLoader.load(new URLRequest(".\\Lines\\bouncer1.txt"));
				} else {
					txtLoader.load(new URLRequest(".\\Lines\\bouncer2.txt"));
				}
			} else {
				if (textinscreen) {
					txtLoader.removeEventListener(Event.COMPLETE, formatText.onLoaded);
					textinscreen = false;
					main.stage.removeChild(formatText.lines);
				}
			}
			if (fadeout && textinscreen) {
				txtLoader.removeEventListener(Event.COMPLETE, formatText.onLoaded);
				textinscreen = false;
				main.stage.removeChild(formatText.lines);
			}
		}

		function move2Alley(e: Event) {
			if (man.x > 900 && man.x < 1200) {
				if (main.controls.upkeydown) {
					fadeout = true;
					this.removeEventListener(Event.ENTER_FRAME, move2Bar);
					main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
					this.removeEventListener(Event.ENTER_FRAME, Bouncer);
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
				if (fadeout) {
					main.controls.rkeydown = false;
					if (bg.alpha > 0) {
						color.brightness -= 0.033;
						man.transform.colorTransform = color;
						bg.alpha -= 0.033;
					} else {
						if (!fadein) {
							removeChild(bg);
							man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
							man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
							man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
							man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
							man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
							removeChild(man);
							main.removeChild(main.level1);
							main.removeChild(main.sights.sights);
							main.alley = new Alley(main, mechanics, main.pauseMenu);
							main.alley.bg.alpha = 0;
							color.brightness = -1;
							main.alley.man.transform.colorTransform = color;
							main.addChild(main.alley);
							main.addChild(main.sights.sights);
							main.alley.man.x = 400;
							fadein = true;
						} else {
							main.alley.bg.alpha += 0.033;
							if (color.brightness < 0)
								color.brightness += 0.033;
							main.alley.man.transform.colorTransform = color;
							if (main.alley.bg.alpha == 1) {
								this.removeEventListener(Event.ENTER_FRAME, move2Alley);
								main.stage.addEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
							}
						}
					}
				}
			}
		}

		function move2Bar(e: Event) {
			if (main.pass && man.x > 1140) {
				fadeout = true;
				this.removeEventListener(Event.ENTER_FRAME, move2Alley);
			}
			if (fadeout) {
				main.controls.rkeydown = false;
				if (bg.alpha > 0) {
					if (bg.alpha == 1) {
						main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
						this.removeEventListener(Event.ENTER_FRAME, Bouncer);
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
						removeChild(bg);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Move);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
						man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
						removeChild(man);
						main.removeChild(main.level1);
						main.removeChild(main.sights.sights);
						main.bar = new Bar(main, mechanics, main.pauseMenu);
						main.bar.bg.alpha = 0;
						color.brightness = -1;
						main.bar.man.transform.colorTransform = color;
						main.addChild(main.bar);
						main.addChild(main.sights.sights);
						main.bar.man.x = 400;
						fadein = true;
					} else {
						main.bar.bg.alpha += 0.033;
						if (color.brightness < 0)
							color.brightness += 0.033;
						main.bar.man.transform.colorTransform = color;
						if (main.bar.bg.alpha == 1) {
							this.removeEventListener(Event.ENTER_FRAME, move2Bar);
							main.stage.addEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
						}
					}
				}
			}
		}
	}



	/*
	function interaction() {
		if ( man.x == VER VALOR ) {
			if ( main.controls.ekeydown && pass == false) {
				pass = true;
				//start dialog animation
			}
			else if(main.controls.ekeydown && pass == true) {
				//start filler dialog animation
			}
		}
	}*/

	/*function onFinish(e: Event) {
		this.main.stage.alpha -= 0.5 // change this value as per the speed of fade required

		if ( this.main.stage.alpha <= 0 ) {
		    this.main.stage.visible = false
		    this.main.stage.alpha = 1 ;
		    removeEventListener(Event.ENTER_FRAME, onFinish); // TODO: CHECK EVENTS ENTER_FRAME
		}
	}*/
}