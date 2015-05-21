package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Alley extends MovieClip {
		var main: Main;
		var mechanics: Mechanics;
		var man: Man;
		var bg: Lvl;
		var fadeout: Boolean = false;
		var fadein: Boolean = false;
		var color: Color = new Color();
		var txtLoader: URLLoader = new URLLoader();
		var formatText: FormatText;
		var textonscreen: Boolean = false;
		var line: Number = 1;

		public function Alley(main: Main, mechanics: Mechanics, pauseMenu: PauseMenu) {
			this.main = main;
			man = new Man();
			bg = new AlleyLvl();
			formatText = new FormatText(main);
			this.mechanics = new Mechanics(man, this.main, bg);

			this.addChild(bg);
			this.addChild(man);
			man.y = 500;
			bg.y = 720;

			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Gravity);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Move);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.Animate);
			man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleSprint);
			//man.addEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);

			this.mechanics.ground = 500;
			this.mechanics.border1 = 0;
			this.mechanics.border2 = 1280;
			this.mechanics.lim1 = 500;
			this.mechanics.lim2 = 900;
			this.addEventListener(Event.ENTER_FRAME, move2Lvl1);
			
			
			color.brightness = 0;

			this.addEventListener(Event.ENTER_FRAME, Smile);

		}

		function Smile(e: Event) {
			if ((Math.sqrt(Math.pow(man.x - (bg.x + bg.smile.x), 2))) < 200) {
				if (!textonscreen) {
					txtLoader.addEventListener(Event.COMPLETE, formatText.onLoaded);
					textonscreen = true;
					if (line == 1) {
						txtLoader.load(new URLRequest(".\\Lines\\smile1.txt"));
					} else {
						txtLoader.load(new URLRequest(".\\Lines\\smile2.txt"));
						main.pass = true;
					}
				}
				if (line == 1) {
					if (formatText.nextline && main.controls.mousedown) {
						line = 2;
						txtLoader.removeEventListener(Event.COMPLETE, formatText.onLoaded);
						textonscreen = false;
						main.stage.removeChild(formatText.lines);
					}
				}
			} else {
				if (textonscreen) {
					txtLoader.removeEventListener(Event.COMPLETE, formatText.onLoaded);
					textonscreen = false;
					main.stage.removeChild(formatText.lines);
				}
			}
			if (fadeout && textonscreen) {
				txtLoader.removeEventListener(Event.COMPLETE, formatText.onLoaded);
				textonscreen = false;
				main.stage.removeChild(formatText.lines);
			}
		}

		function move2Lvl1(e: Event) {
			if (main.controls.downkeydown) {
				fadeout = true;
			}
			if (fadeout) {
				main.controls.rkeydown = false;
				if (bg.alpha > 0) {
					if (bg.alpha == 1) {
						main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, main.controls.checkKeysDown);
						this.removeEventListener(Event.ENTER_FRAME, Smile);
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
						//man.removeEventListener(Event.ENTER_FRAME, this.mechanics.ToggleReady);
						this.removeChild(man);
						main.removeChild(main.alley);
						main.removeChild(main.sights.sights);
						main.level1 = new Level1(main, mechanics, main.pauseMenu);
						color.brightness = -1;
						main.level1.man.transform.colorTransform = color;
						main.addChild(main.level1);
						main.addChild(main.sights.sights);
						main.level1.bg.x = -1332;
						main.level1.man.x = 1050;
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
	}
}