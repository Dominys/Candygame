package
{
	//import flash.events.*;
	import flash.media.*;
	//import game_screen.*;
	// import gs.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.TextFormat;
	import gs.easing.Back;
	import gs.easing.Linear;
	import gs.easing.Quad;
	import gs.TweenMax;
	import flash.text.TextField;
	import fl.video.VideoEvent;
	import fl.video.FLVPlayback;
	import sm.display.sizedImage;
	import Math;
	
	public class game_screen extends game_screenClip
	{
		private const STATUS_IDLE:Number = 0;
		private var ballInsertedInThisTurn:Boolean = true;
		private const STATUS_FINISHED:Number = 6;
		private const STATUS_RED_TURN:Number = 1;
		private var time_almost_up:Boolean = false;
		private var current_player:String = "";
		private const STATUS_4INAROW:Number = 4;
		private const STATUS_RESET:Number = 5;
		private const STATUS_YELLOW_TURN:Number = 2;
		private const STATUS_NOMOREPOSSIBILITIES:Number = 3;
		private var status:Number = 0;
		private var LightupTube:Number = 0;
		public var candymachine;
		public var closeMessage;
		
		public function game_screen()
		{
			status = STATUS_IDLE;
			time_almost_up = false;
			current_player = "";
			ballInsertedInThisTurn = true;
			if (globals.dictionary)
			{
				if (globals.dictionary.getKey("room" + globals.config.room + "_status") == "time_almost_up")
				{
					time_almost_up = true;
				}
			}
			globals.status = globals.STATUS_INGAME;
			globals.scoreA = 0;
			globals.scoreB = 0;
			LightupTube = 0;
			globals.score_counterA.show();
			globals.score_counterB.show();
			globals.ctrls.addEventListener("ball", ball, false, 0, true);
			globals.ctrls.addEventListener("release", release, false, 0, true);
			globals.ctrls.addEventListener("SetLightTube", SetLight, false, 0, true);
			current_player = "yellow";
			AllLightOff();
			TweenMax.delayedCall(4, show_trytomake4inarow);
			TweenMax.delayedCall(0.5, nextPlayer);
			closeMessage.alpha = 0;
			/*_loc_1 = globals.game.leds.led;
			   for each (_loc_2 in _loc_1)
			   {
			
			   globals.ctrls.setLight(_loc_2.@index, true);
			 }*/
			
			//LightupTube = 1;
			//globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 1, newState: true}));
			
			return;
		} // end function
		
		public function SetLight(event:CustomEvent):void
		{
			var property:XML;
			var Leds:XMLList = globals.game.leds.led;
			for each (property in Leds)
			{
				if (property.@tube == event.data.tube)
				{
					globals.ctrls.setLight(property.@index, event.data.newState);
				}
			}
			return;
		}
		
		public function SetRandomTubeLight():void
		{
			TweenMax.killDelayedCallsTo(SetRandomTubeLight);
			var R:int;
			do {
					R = (Math.random() * 6) + 1;					
			}while (candymachine.CheckTubeFull(R) || (LightupTube == R));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", { tube: LightupTube , newState: false } ));
			LightupTube = R;
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", { tube: LightupTube , newState: true } ));			
			TweenMax.delayedCall(2, SetRandomTubeLight);
		}
		
		public function AllLightOff():void
		{
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 1, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 2, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 3, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 4, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 5, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 6, newState: false}));
			globals.ctrls.dispatchEvent(new CustomEvent("SetLightTube", {tube: 7, newState: false}));
		}
		
		override protected function timeisalmostup(event:Event):void
		{
			time_almost_up = true;
			globals.showOverlay(new timealmostup());
			globals.countdown.start(globals.dictionary.getKey("room" + globals.config.room + "_countdown"));
			globals.sandTimer.stop();
			return;
		} // end function
		
		private function release(event:Event):void
		{
			candymachine.release();
			TweenMax.delayedCall(4, show_trytomake4inarow);
			TweenMax.delayedCall(0.5, nextPlayer);
			return;
		} // end function
		
		private function show4inarow():void
		{
			var _loc_1:* = null;
			_loc_1 = new pointscored();
			_loc_1.play();
			if (globals.dictionary)
			{
				globals.dictionary.addKey("showcontrol", "candygame_team_won");
			}
			candymachine.show4inarow();
			return;
		} // end function
		
		override protected function countdown(event:CustomEvent):void
		{
			if (this.status != STATUS_FINISHED)
			{
				globals.countdown.setSeconds(event.data.value);
			}
			return;
		} // end function
		
		private function switchPlayer(param1:Number = 1.5):void
		{
			//TweenMax.killDelayedCallsTo(SetRandomTubeLight);
			if (current_player == "red")
			{
				current_player = "yellow";
				status = STATUS_YELLOW_TURN;
				TweenMax.delayedCall(param1, showYellowTeamsTurn);
				globals.score_counterA.unhilite();
				globals.score_counterB.hilite();
			}
			else
			{
				current_player = "red";
				status = STATUS_RED_TURN;
				TweenMax.delayedCall(param1, showRedTeamsTurn);
				globals.score_counterA.hilite();
				globals.score_counterB.unhilite();
			}
			TweenMax.delayedCall(0.5, SetRandomTubeLight);
			return;
		} // end function
		
		private function yellow_team_4_in_a_row()
		{
			globals.showOverlay(new yellow_team_4inarow());
			return;
		} // end function
		
		override protected function reset(event:Event):void
		{
			TweenMax.killDelayedCallsTo(nextPlayer);
			TweenMax.killDelayedCallsTo(showYellowTeamsTurn);
			TweenMax.killDelayedCallsTo(showRedTeamsTurn);
			TweenMax.killDelayedCallsTo(globals.showOverlay);
			globals.countdown.hide();
			globals.sandTimer.hide();
			globals.score_counterA.hide();
			globals.score_counterB.hide();
			globals.showScreen(new idle_screen());
			return;
		} // end function
		
		private function red_team_4_in_a_row()
		{
			globals.showOverlay(new red_team_4inarow());
			return;
		} // end function
		
		function showYellowTeamsTurn()
		{
			globals.showOverlay(new yellow_team());
			return;
		} // end function
		
		function showRedTeamsTurn()
		{
			globals.showOverlay(new red_team());
			return;
		} // end function
		
		override protected function timeisup(event:Event):void
		{
			this.status = STATUS_FINISHED;
			TweenMax.killDelayedCallsTo(nextPlayer);
			TweenMax.killDelayedCallsTo(showYellowTeamsTurn);
			TweenMax.killDelayedCallsTo(showRedTeamsTurn);
			TweenMax.killDelayedCallsTo(globals.showOverlay);
			globals.countdown.hide();
			globals.sandTimer.hide();
			globals.score_counterA.hide();
			globals.score_counterB.hide();
			globals.showScreen(new completed_screen());
			return;
		} // end function
		
		override protected function enterframe(event:Event):void
		{
			if (globals.ctrls.gateOpen == true)
			{
				if (closeMessage.alpha < 1)
				{
					closeMessage.alpha = closeMessage.alpha + 0.025;
				}
			}
			else if (closeMessage.alpha > 0)
			{
				closeMessage.alpha = closeMessage.alpha - 0.025;
			}
			return;
		} // end function
		
		override protected function cleanup(event:Event):void
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			super.cleanup(event);
			TweenMax.killDelayedCallsTo(nextPlayer);
			TweenMax.killDelayedCallsTo(showYellowTeamsTurn);
			TweenMax.killDelayedCallsTo(showRedTeamsTurn);
			globals.countdown.hide();
			globals.sandTimer.hide();
			globals.score_counterA.hide();
			globals.score_counterB.hide();
			globals.ctrls.removeEventListener("ball", ball);
			globals.ctrls.removeEventListener("release", release);
			globals.ctrls.removeEventListener("SetLightTube", SetLight);
			_loc_2 = globals.game.leds.led;
			for each (_loc_3 in _loc_2)
			{
				
				globals.ctrls.setLight(_loc_3.@index, false);
			}
			return;
		} // end function
		
		private function show_pulllever()
		{
			globals.showOverlay(new pull_lever());
			return;
		} // end function
		
		private function show_trytomake4inarow()
		{
			globals.showOverlay(new trytomake4inarow());
			return;
		} // end function
		
		private function nextPlayer(param1:Number = 0):void
		{
			TweenMax.killDelayedCallsTo(nextPlayer);
			if (!time_almost_up)
			{
				ballInsertedInThisTurn = false;
				switchPlayer(param1);
				
			}
			else
			{
				this.status = STATUS_FINISHED;
				globals.countdown.hide();
				globals.sandTimer.hide();
				globals.showScreen(new completed_screen());
			}
			return;
		} // end function
		
		
		private function showCompleted():void
		{
			globals.countdown.hide();
			globals.sandTimer.hide();
			globals.score_counterA.hide();
			globals.score_counterB.hide();
			globals.showScreen(new completed_screen());
			return;
		} // end function
		
		
		private function ball(event:CustomEvent):void
		{
			var Color:String;
			var ScoreSound;
			var _loc_4:* = undefined;
			if (candymachine.CheckTubeFull(event.data.tube))
				return;
			if ((status == STATUS_RED_TURN || status == STATUS_YELLOW_TURN) && ballInsertedInThisTurn == false)
			{
				
				ballInsertedInThisTurn = true;
				if ((status == STATUS_RED_TURN))
				{
					if (event.data.tube == LightupTube)
					{
						Color = "red";
						ScoreSound = new pointscored();
						TweenMax.delayedCall(0.2, globals.addPointsToScore, [1, 1]);
						ScoreSound.play();
					}
					else
					{
						Color = "yellow";
						ScoreSound = new pointlost();
						TweenMax.delayedCall(0.2, globals.addPointsToScore, [-1, 1]);
						ScoreSound.play();
					}
				}
				if (status == STATUS_YELLOW_TURN)
				{
					if (event.data.tube == LightupTube)
					{
						Color = "yellow";
						ScoreSound = new pointscored();
						TweenMax.delayedCall(0.2, globals.addPointsToScore, [1, 2]);
						ScoreSound.play();
					}
					else
					{
						Color = "red";
						ScoreSound = new pointlost();
						TweenMax.delayedCall(0.2, globals.addPointsToScore, [-1, 2]);
						ScoreSound.play();
					}
				}
				
				candymachine.addBall(event.data.tube, Color);
				_loc_4 = candymachine.check4inarow();
				if (_loc_4 != "")
				{
					status = STATUS_4INAROW;
					if (_loc_4 == "red")
					{
						TweenMax.delayedCall(0.7, red_team_4_in_a_row);
					}
					if (_loc_4 == "yellow")
					{
						TweenMax.delayedCall(0.7, yellow_team_4_in_a_row);
					}
					TweenMax.delayedCall(0.5, show4inarow);
					if (_loc_4 == "red")
					{
						TweenMax.delayedCall(1, globals.addPointsToScore, [1, 1]);
					}
					if (_loc_4 == "yellow")
					{
						TweenMax.delayedCall(1, globals.addPointsToScore, [1, 2]);
					}
					TweenMax.delayedCall(10, show_pulllever);
					TweenMax.killDelayedCallsTo(SetRandomTubeLight);
					AllLightOff();
				}
				else
				{
					
					TweenMax.killDelayedCallsTo(SetRandomTubeLight);
					AllLightOff();
					nextPlayer(1.1);
				}
			}
			return;
		} // end function
	
	}
}
