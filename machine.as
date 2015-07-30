package
{
	import flash.display.*;
	import flash.media.*;
	import gs.*;
	import gs.easing.*;
	
	public class machine extends MovieClip
	{
		public var ignoreLever:Boolean = false;
		public var tube1:tubeClip;
		public var tube2:tubeClip;
		public var tube4:tubeClip;
		public var tube5:tubeClip;
		public var tube6:tubeClip;
		public var tube7:tubeClip;
		public var tube3:tubeClip;
		private var arr4inarow:Array;
		private const STATUS_OPEN:Object = 0;
		private const STATUS_CLOSED:Object = 1;
		private var status:Object = 0;
		
		public function machine()
		{
			status = STATUS_OPEN;
			ignoreLever = false;
			if (globals.ctrls.gateOpen)
			{
				status = STATUS_OPEN;
			}
			else
			{
				status = STATUS_CLOSED;
			}
			if (ignoreLever)
			{
				status = STATUS_CLOSED;
			}
			globals.ctrls.addEventListener("SetLightTube", SetLight, false, 0, true)
			return;
		} // end function
		
		public function SetLight(event:CustomEvent):void
		{
			switch (event.data.tube)
			{
				case 1: 
					tube1.setLight(event.data.newState);
					break;
				case 2: 
					tube2.setLight(event.data.newState);
					break;
				case 3: 
					tube3.setLight(event.data.newState);
					break;
				case 4: 
					tube4.setLight(event.data.newState);
					break;
				case 5: 
					tube5.setLight(event.data.newState);
					break;
				case 6: 
					tube6.setLight(event.data.newState);
					break;
				case 7: 
					tube7.setLight(event.data.newState);
					break;
			
			}
		
		}
		
		public function release()
		{
			var _loc_1:* = null;
			if (ignoreLever)
			{
				return;
			}
			_loc_1 = new lockrelease();
			_loc_1.play();
			status = STATUS_CLOSED;
			tube1.releaseBalls();
			tube2.releaseBalls();
			tube3.releaseBalls();
			tube4.releaseBalls();
			tube5.releaseBalls();
			tube6.releaseBalls();
			tube7.releaseBalls();
			TweenMax.delayedCall(2, reset);
			return;
		} // end function
		
		public function show4inarow()
		{
			var _loc_1:* = undefined;
			_loc_1 = 0;
			while (_loc_1 < arr4inarow.length)
			{
				
				TweenMax.to(arr4inarow[_loc_1], 1.2, {colorMatrixFilter: {brightness: 1.6}, yoyo: 9, ease: Quad.easeIn});
				_loc_1 = _loc_1 + 1;
			}
			return;
		} // end function
		
		private function checkDiagonalLine_down(param1:String)
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			var _loc_5:* = undefined;
			arr4inarow = new Array();
			_loc_2 = 1;
			while (_loc_2 <= 4)
			{
				
				_loc_3 = 0;
				while (_loc_3 < 6)
				{
					
					_loc_4 = 0;
					_loc_5 = 0;
					while (_loc_5 < 4)
					{
						
						if (this["tube" + (_loc_2 + _loc_5)].arrBalls.length >= _loc_3 - _loc_5 + 1)
						{
							if (_loc_3 - _loc_5 >= 0)
							{
								if (this["tube" + (_loc_2 + _loc_5)].arrBalls[_loc_3 - _loc_5].color == param1)
								{
									_loc_4 = _loc_4 + 1;
									arr4inarow.push(this["tube" + (_loc_2 + _loc_5)].arrBalls[_loc_3 - _loc_5]);
								}
								else
								{
									_loc_4 = 0;
									arr4inarow = new Array();
								}
							}
							else
							{
								_loc_4 = 0;
								arr4inarow = new Array();
							}
							if (_loc_4 >= 4)
							{
								return true;
							}
						}
						_loc_5 = _loc_5 + 1;
					}
					_loc_3 = _loc_3 + 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			arr4inarow = new Array();
			return false;
		} // end function
		
		private function checkHorizontal():String
		{
			if (checkHorizontalLine("red"))
			{
				return "red";
			}
			if (checkHorizontalLine("yellow"))
			{
				return "yellow";
			}
			return "";
		} // end function
		
		private function checkDiagonal():String
		{
			if (checkDiagonalLine_down("red"))
			{
				return "red";
			}
			if (checkDiagonalLine_up("red"))
			{
				return "red";
			}
			if (checkDiagonalLine_down("yellow"))
			{
				return "yellow";
			}
			if (checkDiagonalLine_up("yellow"))
			{
				return "yellow";
			}
			return "";
		} // end function
		
		public function reset()
		{
			tube1.reset();
			tube2.reset();
			tube3.reset();
			tube4.reset();
			tube5.reset();
			tube6.reset();
			tube7.reset();
			status = STATUS_OPEN;
			return;
		} // end function
		
		private function checkHorizontalLine(param1:String)
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			arr4inarow = new Array();
			_loc_2 = 0;
			while (_loc_2 < 6)
			{
				
				_loc_3 = 0;
				_loc_4 = 1;
				while (_loc_4 <= 7)
				{
					
					if (this["tube" + _loc_4].arrBalls.length >= (_loc_2 + 1))
					{
						if (this["tube" + _loc_4].arrBalls[_loc_2].color == param1)
						{
							_loc_3 = _loc_3 + 1;
							arr4inarow.push(this["tube" + _loc_4].arrBalls[_loc_2]);
						}
						else
						{
							_loc_3 = 0;
							arr4inarow = new Array();
						}
					}
					else
					{
						_loc_3 = 0;
						arr4inarow = new Array();
					}
					if (_loc_3 >= 4)
					{
						return true;
					}
					_loc_4 = _loc_4 + 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			arr4inarow = new Array();
			return false;
		} // end function
		
		private function checkDiagonalLine_up(param1:String)
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			var _loc_5:* = undefined;
			arr4inarow = new Array();
			_loc_2 = 1;
			while (_loc_2 <= 4)
			{
				
				_loc_3 = 0;
				while (_loc_3 < 6)
				{
					
					_loc_4 = 0;
					_loc_5 = 0;
					while (_loc_5 < 4)
					{
						
						if (this["tube" + (_loc_2 + _loc_5)].arrBalls.length >= _loc_3 + _loc_5 + 1)
						{
							if (_loc_3 + _loc_5 <= 6)
							{
								if (this["tube" + (_loc_2 + _loc_5)].arrBalls[_loc_3 + _loc_5].color == param1)
								{
									_loc_4 = _loc_4 + 1;
									arr4inarow.push(this["tube" + (_loc_2 + _loc_5)].arrBalls[_loc_3 + _loc_5]);
								}
								else
								{
									_loc_4 = 0;
									arr4inarow = new Array();
								}
							}
							else
							{
								_loc_4 = 0;
								arr4inarow = new Array();
							}
							if (_loc_4 >= 4)
							{
								return true;
							}
						}
						_loc_5 = _loc_5 + 1;
					}
					_loc_3 = _loc_3 + 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			arr4inarow = new Array();
			return false;
		} // end function
		
		private function checkVertical():String
		{
			if (checkVerticalLine("red"))
			{
				return "red";
			}
			if (checkVerticalLine("yellow"))
			{
				return "yellow";
			}
			return "";
		} // end function
		
		public function check4inarow()
		{
			var _loc_1:* = undefined;
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			_loc_1 = checkHorizontal();
			if (_loc_1 != "")
			{
				return _loc_1;
			}
			_loc_2 = checkVertical();
			if (_loc_2 != "")
			{
				return _loc_2;
			}
			_loc_3 = checkDiagonal();
			if (_loc_3 != "")
			{
				return _loc_3;
			}
			return "";
		} // end function
		
		public function addBall(param1:int, param2:String)
		{
			switch (param1)
			{
				case 1: 
				{
					tube1.addBall(param2);
					break;
				}
				case 2: 
				{
					tube2.addBall(param2);
					break;
				}
				case 3: 
				{
					tube3.addBall(param2);
					break;
				}
				case 4: 
				{
					tube4.addBall(param2);
					break;
				}
				case 5: 
				{
					tube5.addBall(param2);
					break;
				}
				case 6: 
				{
					tube6.addBall(param2);
					break;
				}
				case 7: 
				{
					tube7.addBall(param2);
					break;
				}
				default: 
				{
					break;
				}
			}
			return;
		} // end function
		
		public function CheckTubeFull(tube:Number):Boolean
		{
			switch (tube)
			{
				case 1: 
				{
					return tube1.isFull();
					break;
				}
				case 2: 
				{
					return tube2.isFull();
					break;
				}
				case 3: 
				{
					return tube3.isFull();
					break;
				}
				case 4: 
				{
					return tube4.isFull();
					break;
				}
				case 5: 
				{
					return tube5.isFull();
					break;
				}
				case 6: 
				{
					return tube6.isFull();
					break;
				}
				case 7: 
				{
					return tube7.isFull();
					break;
				}
				default: 
				{
					return true;
				}
			}
		}
		
		private function checkVerticalLine(param1:String)
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			arr4inarow = new Array();
			_loc_2 = 1;
			while (_loc_2 <= 7)
			{
				
				_loc_3 = 0;
				_loc_4 = 0;
				while (_loc_4 < 6)
				{
					
					if (this["tube" + _loc_2].arrBalls.length >= (_loc_4 + 1))
					{
						if (this["tube" + _loc_2].arrBalls[_loc_4].color == param1)
						{
							_loc_3 = _loc_3 + 1;
							arr4inarow.push(this["tube" + _loc_2].arrBalls[_loc_4]);
						}
						else
						{
							_loc_3 = 0;
							arr4inarow = new Array();
						}
					}
					if (_loc_3 >= 4)
					{
						return true;
					}
					_loc_4 = _loc_4 + 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			arr4inarow = new Array();
			return false;
		} // end function
	
	}
}
