package {
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.filters.GlowFilter;
	import flash.events.TimerEvent;
	import flash.events.Event;

	public class FormatText {
		var main: Main;
		var txtLoader: URLLoader = new URLLoader();
		var lines: TextField = new TextField();
		var lineFormat: TextFormat = new TextFormat();
		var pixelFont = new PixelFont();
		var outline: GlowFilter = new GlowFilter(0x000000, 1.0, 8.0, 8.0, 4, 1);
		
		public function FormatText(main: Main) {
			this.main = main;
			lineFormat.size = 14;
			lineFormat.align = TextFormatAlign.CENTER;
			lineFormat.font = pixelFont.fontName;
			lineFormat.color = 0xFFFFFF;
		}
		
		function onLoaded(e: Event): void {
			lines.x = 200;
			lines.y = 650;
			lines.width = 800;
			lines.height = 100;
			lines.defaultTextFormat = lineFormat;
			lines.embedFonts = true;
			lines.antiAliasType = AntiAliasType.ADVANCED;
			lines.selectable = false;
			lines.filters = [outline];

			lines.text = ("Bouncer'	" + e.target.data);
			main.stage.addChild(lines);
			lines.wordWrap = true;
		}
	}
}