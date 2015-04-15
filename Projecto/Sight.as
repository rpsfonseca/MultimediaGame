package {

	import flash.events.MouseEvent;	
	import flash.events.Event;
	import flash.ui.MouseCursor;
	import flash.ui.Mouse;


	public class Sight {

		public var game: Game;
		
		var sight: SightDot = new SightDot();

		public function Sight(game: Game) {
			this.game = game;
			game.addChild(sight);
			sight.mouseEnabled=false;
			game.addEventListener(Event.ENTER_FRAME, BtnMovement);
		}
		
		public function BtnMovement(e: Event): void {
			sight.x = game.mouseX;
			sight.y = game.mouseY;
		}
			
		Mouse.hide();

	}

}