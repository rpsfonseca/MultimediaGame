package  {
	
	public class SlowMotion {
		var main: Main;
		
		public function SlowMotion(main: Main) {
			this.main = main;
		}
		
		function enterTheMatrix(mechanics: Mechanics, enemyMechs: Array){
			mechanics.speedX /= 4;
			for(var i: Number = 0; i < enemyMechs.length; i++) {
				enemyMechs[i].speedX /= 4;
			}
		}
	}
}