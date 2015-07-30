package roshen
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import gs.*;
    import gs.easing.*;

    public class countdowntimer extends MovieClip
    {
        public var time_arrow:MovieClip;
        private var starttime:Number = 0;
        private var timer:Timer;
        private var secondsCounter2:counter;
        private var secondsCounter:counter;
        public var numbersHolder:MovieClip;
        public var arcHolder:MovieClip;
        private var startSeconds:Number = 0;
        private var frameRate:Number = 29;

        public function countdowntimer()
        {
            frameRate = 29;
            starttime = 0;
            startSeconds = 0;
            globals.countdown = this;
            secondsCounter = new counterClip();
            secondsCounter.flipspeed = 0.6;
            secondsCounter.x = 0;
            secondsCounter.y = 0;
            secondsCounter.scaleX = 1.2;
            secondsCounter.scaleY = 1.2;
            numbersHolder.addChild(secondsCounter);
            secondsCounter2 = new counterClip();
            secondsCounter2.x = 82;
            secondsCounter2.y = 0;
            secondsCounter2.scaleX = 1.2;
            secondsCounter2.scaleY = 1.2;
            numbersHolder.addChild(secondsCounter2);
            reset();
            return;
        }// end function

        private function updateArrowPosition(event:TimerEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_2 = getTimer() - starttime;
            _loc_3 = _loc_2 / 1000 / startSeconds;
            if (_loc_3 > 1)
            {
                _loc_3 = 1;
            }
            _loc_4 = 157;
            _loc_5 = 158;
            time_arrow.x = _loc_4 + Math.sin(_loc_3 * (Math.PI * 2)) * 142.5;
            time_arrow.y = _loc_5 - Math.cos(_loc_3 * (Math.PI * 2)) * 142.5;
            time_arrow.rotation = _loc_3 * 360;
            arcHolder.graphics.clear();
            arcHolder.graphics.lineStyle(2.7, 12724259);
            drawArc(_loc_4 + 0.7, _loc_5 - 0.7, 123.77, -90 / 360, _loc_3, 100);
            return;
        }// end function

        public function start(param1:int = 60)
        {
            if (stage)
            {
                if (stage.frameRate)
                {
                    frameRate = stage.frameRate;
                }
            }
            starttime = getTimer();
            startSeconds = param1;
            TweenMax.to(this, 0.4, {autoAlpha:1, ease:Linear.easeNone});
            timer = new Timer(1000 / frameRate, (param1 - 1) * frameRate);
            timer.addEventListener(TimerEvent.TIMER, updateArrowPosition, false, 0, true);
            timer.start();
            return;
        }// end function

        public function reset()
        {
            this.visible = false;
            if (timer)
            {
                timer.removeEventListener(TimerEvent.TIMER, updateArrowPosition);
                timer.stop();
            }
            secondsCounter.setValue(0);
            secondsCounter2.setValue(0);
            return;
        }// end function

        private function drawArc(param1, param2, param3, param4, param5, param6)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            _loc_7 = 2 * Math.PI;
            _loc_8 = param5 / param6;
            _loc_9 = param1 + Math.cos(param4 * _loc_7) * param3;
            _loc_10 = param2 + Math.sin(param4 * _loc_7) * param3;
            arcHolder.graphics.moveTo(_loc_9, _loc_10);
            _loc_11 = 1;
            while (_loc_11 <= param6)
            {
                
                _loc_12 = param4 + _loc_11 * _loc_8;
                _loc_9 = param1 + Math.cos(_loc_12 * _loc_7) * param3;
                _loc_10 = param2 + Math.sin(_loc_12 * _loc_7) * param3;
                arcHolder.graphics.lineTo(_loc_9, _loc_10);
                _loc_11 = _loc_11 + 1;
            }
            return;
        }// end function

        public function hide()
        {
            if (timer)
            {
                timer.removeEventListener(TimerEvent.TIMER, updateArrowPosition);
                timer.stop();
            }
            TweenMax.killTweensOf(this);
            TweenMax.to(this, 0.4, {autoAlpha:0, ease:Linear.easeNone});
            return;
        }// end function

        public function setSeconds(param1:Number)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (isNaN(param1))
            {
                param1 = 0;
            }
            TweenMax.to(this, 0.4, {autoAlpha:1, ease:Linear.easeNone});
            _loc_2 = (param1 - param1 % 10) / 10;
            _loc_3 = param1 % 10;
            secondsCounter.setValue(_loc_2);
            secondsCounter2.setValue(_loc_3);
            if (param1 == 0)
            {
                TweenMax.delayedCall(1, hide);
            }
            return;
        }// end function

    }
}
