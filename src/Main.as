﻿package {
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class Main extends MovieClip {
		var menu: Menu;
		var sights: Sights;
		var level1: Level1;
		var controls: Controls;
		var mechanics: Mechanics;
		var pauseMenu: PauseMenu;
		
		public function Main() {
			controls = new Controls(this);
			menu = new Menu(this);
			sights = new Sights(this);
			pauseMenu = new PauseMenu(this);
			level1 = new Level1(this, mechanics, pauseMenu);
			addChild(controls);
			addChild(menu);
			addChild(sights.sights);
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
	}
}
