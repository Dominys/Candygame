package sm.game
{
    import flash.display.*;
    import flash.events.*;

    public class base_screen extends base_clip
    {
        public var tongue:MovieClip;
        public var good_luck:MovieClip;
        public var textballoon2:MovieClip;
        public var startbutton:MovieClip;
        public var textballoon1:textBalloon2;
        public var bg_border:MovieClip;
        public var buttons:MovieClip;
        public var text1:bigTextArea;
        public var sequence:MovieClip;
        public var vignet_big:MovieClip;
        public var question:MovieClip;

        public function base_screen()
        {
            if (globals.dictionary != null)
            {
                globals.dictionary.addEventListener("timealmostup", timeisalmostup, false, 0, true);
                globals.dictionary.addEventListener("timeup", timeisup, false, 0, true);
                globals.dictionary.addEventListener("countdown", countdown, false, 0, true);
                globals.dictionary.addEventListener("reset", reset, false, 0, true);
            }
            if (globals.ctrls != null)
            {
				globals.ctrls.addEventListener("timealmostup", timeisalmostup, false, 0, true);
                globals.ctrls.addEventListener("timeup", timeisup, false, 0, true);
                globals.ctrls.addEventListener("reset", reset, false, 0, true);
            }
            return;
        }// end function

        protected function timeisalmostup(event:Event) : void
        {
			globals.showOverlay(new timealmostup);
            return;
        }// end function

        protected function countdown(event:CustomEvent) : void
        {
            return;
        }// end function

        protected function reset(event:Event) : void
        {
            return;
        }// end function

        protected function timeisup(event:Event) : void
        {
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            if (globals.dictionary != null)
            {
                globals.dictionary.removeEventListener("timealmostup", timeisalmostup);
                globals.dictionary.removeEventListener("timeup", timeisup);
                globals.dictionary.removeEventListener("countdown", countdown);
                globals.dictionary.removeEventListener("reset", reset);
            }
            if (globals.ctrls != null)
            {
                globals.ctrls.removeEventListener("timeup", timeisup);
                globals.ctrls.removeEventListener("reset", reset);
            }
            return;
        }// end function

    }
}
