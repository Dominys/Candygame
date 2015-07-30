package 
{
    import flash.media.*;
    import gs.*;
    import gs.easing.*;
    import timealmostup.*;

    public class timealmostup extends timealmostupClip
    {

        public function timealmostup()
        {
            var CountdownSound = new countdownloop();
            CountdownSound.play();
            counter1.flipspeed = 0.6;
            var _loc_2 = globals.dictionary.getKey("room" + globals.config.room + "_countdown");
            TweenMax.to(this, 1, {alpha:0, delay:3, ease:Linear.easeNone, onComplete:closeMe});
            setSeconds(_loc_2);
            return;
        }// end function

        override protected function countdown(event:CustomEvent) : void
        {
            super.countdown(event);
            setSeconds(event.data.value);
            return;
        }// end function

        private function closeMe() : void
        {
            try
            {
                this.parent.removeChild(this);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function setSeconds(time:Number)
        {
            var _loc_2 = (time - time % 10) / 10;
            var _loc_3 = time % 10;
            counter1.setValue(_loc_2);
            counter2.setValue(_loc_3);
            return;
        }// end function

    }
}
