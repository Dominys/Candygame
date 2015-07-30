package {
	import flash.display.*;
	import flash.ui.*;
	import net.hires.debug.*;
	import sm.game.*;
	
	public class main extends MovieClip {
		public var progress_bar: progressBarClip;
		public var overlay: MovieClip;
		public var scoreCounterA: scoreCounterClipA;
		public var screen: MovieClip;
		public var scoreCounterB: scoreCounterClipB;
		private var debugON: Boolean = false;
		private var ctrls: controls;
		public var popup: MovieClip;
		public var sand_Timer: sandTimer;

		public function main() {
			debugON = false;
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			globals.screen = screen;
			globals.overlay = overlay;
			globals.popup = popup;
			globals.score_counterA = scoreCounterA;
			globals.score_counterB = scoreCounterB;
			if (debugON == true) {
				this.addChild(new Stats());
			}
			Mouse.hide();
			stage.displayState = StageDisplayState.FULL_SCREEN;
			var xml = new xmlLoader("config.xml", configLoaded, NotLoaded);
			return;
		} // end function

		private function configLoaded(data: XML): void {
			globals.config = data;
			globals.alert("Config.xml is loaded");
			var xml = new xmlLoader("game.xml", gameLoaded, NotLoaded);
			return;
		} // end function

		private function gameLoaded(data: XML): void {
			globals.game = data;
			globals.alert("game.xml is loaded");
			globals.ctrls = new controls();
			globals.showScreen(new connecting_screen());
			return;
		} // end function

		private function NotLoaded(data: String): void {
			globals.alert(data, true);
			return;
		} // end function

	}
}