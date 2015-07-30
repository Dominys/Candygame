package 
{
    import flash.events.*;
    import flash.media.*;
    import gs.*;
	import roshen.code_screen;

    public class idle_screen extends idle_screenClip
    {

        public function idle_screen()
        {
            TweenMax.killAllDelayedCalls();
            globals.status = globals.STATUS_IDLE;
            globals.ctrls.addEventListener("start", instructions, false, 0, true);
            allLightsOff();
            return;
        }// end function

        override protected function timeisalmostup(event:Event) : void
        {
            return;
        }// end function

        override protected function reset(event:Event) : void
        {
            globals.showScreen(new idle_screen());
            return;
        }// end function

        override protected function timeisup(event:Event) : void
        {
            globals.countdown.hide();
            globals.sandTimer.hide();
            globals.score_counter.hide();
            globals.showScreen(new code_screen());
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            globals.ctrls.removeEventListener("start", instructions);
            return;
        }// end function

        private function allLightsOff():void
        {
            var property:XML;
            var Leds:XMLList = globals.game.leds.led;
            for each (property in Leds)
            {
                
                globals.ctrls.setLight(property.@index, false);
            }
            return;
        }// end function

        private function instructions(event:Event) : void
        {
            globals.ctrls.removeEventListener("start", instructions);
            var StartSound = new startbutton_long();
            StartSound.play();
            //if (globals.game.skip_intro != 1)
            //{
                //globals.showScreen(new instruction_screen());
            //}
            //else
            //{
                globals.showScreen(new game_screen());
            //}
            return;
        }// end function

    }
}
