package {
	import flash.text.*;
	import flash.display.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.filters.GlowFilter;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class FormatText {
		var main: Main;
		var txtLoader: URLLoader = new URLLoader();
		var lines: TextField = new TextField();
		var lineFormat: TextFormat = new TextFormat();
		var pixelFont = new PixelFont();
		var outline: GlowFilter = new GlowFilter(0x000000, 1.0, 4.0, 4.0, 8, 1);
		var counter: int = 0;
		var delayTimer: Timer = new Timer(60);
		var string: String;
		var skip: Boolean = false;
		var nextline: Boolean = false;
		var namelabel: String;
		var title: TextField = new TextField();
		var titleFormat: TextFormat = new TextFormat();
		var titleOn: Boolean = false;
		var titleCounter: Number = 0;


		public function FormatText(main: Main) {
			this.main = main;
			lineFormat.size = 14;
			lineFormat.align = TextFormatAlign.LEFT;
			lineFormat.font = pixelFont.fontName;
			lineFormat.color = 0xFFFFFF;

			titleFormat.size = 60;
			titleFormat.align = TextFormatAlign.LEFT;
			titleFormat.font = pixelFont.fontName;
			titleFormat.color = 0xFFFFFF;
		}

		function onLoaded(e: Event): void {
			counter = 0;
			lines.text = namelabel;
			lines.x = 400;
			lines.y = 620;
			lines.width = 800;
			lines.height = 100;
			lines.defaultTextFormat = lineFormat;
			lines.embedFonts = true;
			lines.antiAliasType = AntiAliasType.ADVANCED;
			lines.selectable = false;
			lines.wordWrap = true;
			lines.filters = [outline];
			main.stage.addChild(lines);
			initText(e.target.data);
			main.level1.txtLoader.removeEventListener(Event.COMPLETE, onLoaded);
		}

		function initText(data: String): void {
			string = data;
			delayTimer.start();
			delayTimer.addEventListener(TimerEvent.TIMER, writeText);
		}

		function writeText(e: TimerEvent): void {
			if (counter <= string.length) {
				nextline = false;
				if (string.charAt(counter) == ' ')
					counter++;
				lines.text = namelabel + "\n\n" + string.substr(0, counter);
				counter++;
				if (main.controls.mousedown && !skip) {
					counter = string.length;
					skip = true;
				}
			} else {
				nextline = true;
				delayTimer.removeEventListener(TimerEvent.TIMER, writeText);
			}
		}

		function titleDisplay(e: Event) {
			if (!titleOn && main.level1.firstTime == true) {

				title.x = 800;
				title.y = 200;

				title.width = 800;
				title.height = 100;

				title.defaultTextFormat = titleFormat;
				title.embedFonts = true;
				title.antiAliasType = AntiAliasType.ADVANCED;
				title.selectable = false;
				title.wordWrap = true;
				title.filters = [outline];
				title.alpha = 0;
				title.text = "Out of Hand";
				main.stage.addChild(title);
				titleOn = true;

			} else if (titleCounter < 40 && main.level1.firstTime == true) {
				titleCounter++;
			} else if (titleCounter < 120 && title.alpha < 1 && main.level1.firstTime == true) {
				title.alpha += 0.0150;
				titleCounter++;
			} else if (titleCounter < 200 && main.level1.firstTime == true) {
				titleCounter++;
			} else if (title.alpha > 0 && main.level1.firstTime == true) {
				title.alpha -= 0.0150;
			} else {

				if (main.level1.firstTime == true) {
					main.stage.removeChild(title);
				}


				main.level1.removeEventListener(Event.ENTER_FRAME, titleDisplay);


			}
		}
	}
}