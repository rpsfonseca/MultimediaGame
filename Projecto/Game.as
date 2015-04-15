package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;

	public class Game extends MovieClip {
		var menu: Menu;
		public function Game() {
			menu = new Menu(this);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}

		var sight:SightDot = new SightDot();

		sight.mouseEnabled=false;

		stage.addEventListener(MouseEvent.ROLL_OUT,stageOut);
		stage.addEventListener(MouseEvent.ROLL_OVER,stageOver);
		stage.addEventListener(MouseEvent.MOUSE_MOVE,stageMove);

		function stageOver(e:MouseEvent):void {
			this.addChild(sight);
			sight.x=stage.mouseX;
			sight.y=stage.mouseY;
			Mouse.hide();
		}

		function stageOut(e:MouseEvent):void {
			if(this.contains(sight)){
				this.removeChild(sight);
				Mouse.show();
			}
		}

		function stageMove(e:MouseEvent):void {
			sight.x=stage.mouseX;
			sight.y=stage.mouseY;
			e.updateAfterEvent();
		}
	}
}