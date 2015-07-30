package
{
	import flash.display.*;
	import flash.media.*;
	import gs.*;
	import gs.easing.*;
	
	public class tube extends MovieClip
	{
		public var ignoreLever:Boolean = false;
		private const ballHeight:Object = 84;
		public var shade:MovieClip;
		private var LightState:Boolean;
		//private var index:Number;
		public var lightRing:MovieClip;
		private const maxBalls:Object = 6;
		private const minY:Object = -100;
		private const maxY:Object = 448;
		public var arrBalls:Array;
		public var ballHolder:MovieClip;
		
		public function tube()
		{
			//this.index = index;
			ignoreLever = false;
			arrBalls = new Array();
			shade.alpha = 0;
			shade.scaleX = 0.01;
			shade.scaleY = 0.01;
			return;
		} // end function
		
		public function setLight(newState:Boolean)
		{
			LightState = newState;
			if (newState)
			{
				lightRing.alpha = 1;
			}
			else
			{
				lightRing.alpha = 0.4;
			}
		}
		
		public function addBall(color:String)
		{
			var Ball;
			
			if (isFull())
			{
				return;
			}
			switch (color)
			{
				case "red":
					Ball = new redBall();
					break;
				case "yellow":
					Ball = new yellowBall();
					break;
				default:
					return;
			}
			Ball.y = minY;
			Ball.x = 0;
			this.ballHolder.addChild(Ball);
			if (globals.ctrls.gateOpen && ignoreLever == false)
			{
				TweenMax.to(Ball, 1, {y: 700, ease: Quad.easeIn, onComplete: removeBall, onCompleteParams: [Ball]});
			}
			else
			{
				TweenMax.to(Ball, 2.3, {y: maxY - arrBalls.length * ballHeight, ease: Bounce.easeOut});
				arrBalls.push(Ball);
				if (arrBalls.length == 1)
				{
					TweenMax.to(shade, 2.3, {scaleX: 1, scaleY: 1, alpha: 1, ease: BounceHarder.easeOut});
				}
				var DropSound = new tube_drop();
				DropSound.play();
			}
			return;
		} // end function
		
		public function reset():void
		{
			arrBalls = new Array();
			while (this.ballHolder.numChildren > 0)
			{
				
				this.ballHolder.removeChildAt(0);
			}
			return;
		} // end function
		
		public function releaseBalls()
		{
			var _loc_1:* = undefined;
			_loc_1 = 0;
			TweenMax.killTweensOf(shade);
			shade.alpha = 0;
			shade.scaleX = 0.01;
			shade.scaleY = 0.01;
			_loc_1 = 0;
			while (_loc_1 < arrBalls.length)
			{
				
				TweenMax.to(arrBalls[_loc_1], 1, {y: 700, ease: Quad.easeIn, delay: 0.1 * _loc_1, onComplete: removeBall, onCompleteParams: [arrBalls[_loc_1]]});
				_loc_1 = _loc_1 + 1;
			}
			TweenMax.delayedCall(2, reset);
			return;
		} // end function
		
		private function removeBall(param1):void
		{
			this.ballHolder.removeChild(param1);
			return;
		} // end function
		
		public function hiliteBall(param1:int = 1, param2:int = 2)
		{
			if (arrBalls.length >= param1)
			{
				TweenMax.to(arrBalls[(param1 - 1)], 1.2, {colorMatrixFilter: {brightness: 1.9}, yoyo: param2, ease: Quad.easeIn});
			}
			return;
		} // end function
		
		public function isFull():Boolean
		{
			if (arrBalls.length >= maxBalls)
			{
				return true;
			}
			return false;
		} // end function
	
	}
}
