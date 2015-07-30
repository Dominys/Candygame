package roshen
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import gs.*;
    import gs.easing.*;

    public class sandtimer extends MovieClip
    {
        public var time_arrow:MovieClip;
        public var sand_top:MovieClip;
        private var timer:Timer;
        private var emptyYpos:Number = 209;
        public var sandline:MovieClip;
        public var sand:MovieClip;
        public var autoHide:Boolean = true;
        private var top_full_Ypos:Number = 96;
        public var arcHolder:MovieClip;
        private var fullYdiff:Number = -43;
        private var time:Number;
        private var top_emptyYdiff:Number = 43;

        public function sandtimer()
        {
            fullYdiff = -43;
            emptyYpos = 209;
            top_full_Ypos = 96;
            top_emptyYdiff = 43;
            autoHide = true;
            globals.sandTimer = this;
            reset();
            this.alpha = 0;
            this.visible = false;
            return;
        }// end function

        private function updateArrowPosition(event:TimerEvent = null) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_2 = timer.currentCount / timer.repeatCount;
            _loc_3 = 157;
            _loc_4 = 158;
            time_arrow.x = _loc_3 + Math.sin(_loc_2 * (Math.PI * 2)) * 142.5;
            time_arrow.y = _loc_4 - Math.cos(_loc_2 * (Math.PI * 2)) * 142.5;
            time_arrow.rotation = _loc_2 * 360;
            arcHolder.graphics.clear();
            arcHolder.graphics.lineStyle(2.7, 12724259);
            drawArc(_loc_3 + 0.7, _loc_4 - 0.7, 123.77, -90 / 360, _loc_2, 100);
            return;
        }// end function

        public function resume()
        {
            if (timer)
            {
                timer.start();
            }
            return;
        }// end function

        private function completed() : void
        {
            if (autoHide)
            {
                hide();
            }
            dispatchEvent(new Event("sandtimerUp"));
            return;
        }// end function

        public function start(param1:int = 60)
        {
            reset();
            TweenMax.killTweensOf(sand);
            TweenMax.killTweensOf(this);
            TweenMax.killTweensOf(sand_top);
            TweenMax.killTweensOf(sandline);
            TweenMax.to(this, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:0.1});
            sandline.alpha = 0.5;
            timer = new Timer(1000 / stage.frameRate, param1 * stage.frameRate);
            timer.addEventListener(TimerEvent.TIMER, updateArrowPosition, false, 0, true);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, sandtimerUp, false, 0, true);
            timer.start();
            TweenMax.to(sand, param1, {y:emptyYpos + fullYdiff, ease:Linear.easeNone});
            TweenMax.to(sand_top, param1, {y:top_full_Ypos + top_emptyYdiff, ease:Linear.easeNone});
            TweenMax.to(sandline, 0.2, {alpha:1, ease:Linear.easeNone});
            TweenMax.to(sandline, 0.5, {overwite:false, alpha:0, ease:Linear.easeNone, delay:param1 - 0.15});
            updateArrowPosition();
            return;
        }// end function

        public function reset()
        {
            sand.y = emptyYpos;
            sand_top.y = top_full_Ypos;
            sandline.alpha = 0;
            if (timer)
            {
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, updateArrowPosition);
                timer.removeEventListener(TimerEvent.TIMER_COMPLETE, sandtimerUp);
            }
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
                timer.stop();
            }
            TweenMax.to(this, 0.4, {autoAlpha:0, ease:Linear.easeNone});
            return;
        }// end function

        private function sandtimerUp(event:TimerEvent) : void
        {
            TweenMax.delayedCall(1, completed);
            return;
        }// end function

        public function pauze()
        {
            if (timer)
            {
                timer.stop();
            }
            return;
        }// end function

    }
}
