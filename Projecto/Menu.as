package {
	import flash.events.MouseEvent
	import flash.system.fscommand;
	public class Menu {
		public var game: Game;
		public function quitBtnClicked(e: MouseEvent): void {
			fscommand("quit");
		}
		public function startBtnClicked(e: MouseEvent): void {
			game.quit_btn.removeEventListener(MouseEvent.CLICK, quitBtnClicked);
			game.opt_btn.removeEventListener(MouseEvent.CLICK, optBtnClicked);
			game.start_btn.removeEventListener(MouseEvent.CLICK, startBtnClicked);
			game.gotoAndStop(3);
		}
		public function optBtnClicked(e: MouseEvent): void {
			game.quit_btn.removeEventListener(MouseEvent.CLICK, quitBtnClicked);
			game.opt_btn.removeEventListener(MouseEvent.CLICK, optBtnClicked);
			game.start_btn.removeEventListener(MouseEvent.CLICK, optBtnClicked);
			game.gotoAndStop(2);
			game.back_btn.addEventListener(MouseEvent.CLICK, backBtnClicked);
		}
		public function backBtnClicked(e: MouseEvent): void {
			game.back_btn.removeEventListener(MouseEvent.CLICK, backBtnClicked);
			game.gotoAndStop(1);
			game.quit_btn.addEventListener(MouseEvent.CLICK, quitBtnClicked);
			game.opt_btn.addEventListener(MouseEvent.CLICK, optBtnClicked);
			game.start_btn.addEventListener(MouseEvent.CLICK, startBtnClicked);
		}
		public function Menu(game: Game) {
			game.gotoAndStop(1);
			this.game = game;
			game.quit_btn.addEventListener(MouseEvent.CLICK, quitBtnClicked);
			game.opt_btn.addEventListener(MouseEvent.CLICK, optBtnClicked);
			game.start_btn.addEventListener(MouseEvent.CLICK, startBtnClicked);
		}
	}
}