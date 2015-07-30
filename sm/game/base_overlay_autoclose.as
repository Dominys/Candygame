package sm.game
{
    import flash.events.*;
    import gs.*;
    import gs.easing.*;

    public class base_overlay_autoclose extends base_clip
    {

        public function base_overlay_autoclose()
        {
            if (globals.dictionary)
            {
                globals.dictionary.addEventListener("countdown", countdown, false, 0, true);
            }
            TweenMax.to(this, 0.4, {alpha:0, delay:2, ease:Linear.easeNone, onComplete:closeMe});
            return;
        }// end function

        protected function countdown(event:CustomEvent) : void
        {
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            TweenMax.killTweensOf(this);
            if (globals.dictionary)
            {
                globals.dictionary.removeEventListener("countdown", countdown);
            }
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

    }
}
