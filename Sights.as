package {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.display.DisplayObjectContainer;

	public class Sights {
		var main: Main;
		var sights: SightDot = new SightDot();

		public function Sights(main: Main) {
			this.main = main;
			sights.mouseEnabled = false;
			sights.mouseChildren = false;
			Mouse.hide();
			main.stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMovement);

			function MouseMovement(e:MouseEvent): void {
				sights.x = main.mouseX;
				sights.y = main.mouseY;
				e.updateAfterEvent();
			}
		}
	}
}