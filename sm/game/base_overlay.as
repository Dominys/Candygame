package sm.game
{
    import flash.display.*;
    import flash.events.*;

    public class base_overlay extends base_clip
    {
        public var bg_border:MovieClip;
        public var counter1:counterGrey;
        public var counter2:counterGrey;

        public function base_overlay()
        {
            if (globals.dictionary)
            {
                globals.dictionary.addEventListener("countdown", countdown, false, 0, true);
            }
            return;
        }// end function

        protected function countdown(event:CustomEvent) : void
        {
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            if (globals.dictionary)
            {
                globals.dictionary.removeEventListener("countdown", countdown);
            }
            return;
        }// end function

    }
}
