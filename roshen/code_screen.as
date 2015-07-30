package roshen
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import sm.game.*;

    public class code_screen extends base_screen
    {
        public var text:TextField;
        private var tmr:Timer;
        public var code:TextField;

        public function code_screen()
        {
            if (globals.progressBar != null)
            {
                globals.progressBar.hide();
            }
            if (globals.score_counter != null)
            {
                globals.score_counter.hide();
            }
            code.htmlText = "<b>" + globals.config.code + "</b>";
            //if (this["code_p2"] != null)
            //{
                //this["code_p2"].htmlText = "<b>" + globals.config.code + "</b>";
            //}
            tmr = new Timer(1000 * 120, 1);
            tmr.addEventListener(TimerEvent.TIMER_COMPLETE, gotoIdle, false, 0, true);
            tmr.start();
            return;
        }// end function

        override protected function reset(event:Event) : void
        {
            globals.showScreen(new idle_screen());
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            tmr.stop();
            tmr.removeEventListener(TimerEvent.TIMER_COMPLETE, gotoIdle);
            return;
        }// end function

        private function gotoIdle(event:TimerEvent) : void
        {
            tmr.removeEventListener(TimerEvent.TIMER_COMPLETE, gotoIdle);
            tmr.stop();
            globals.showScreen(new idle_screen());
            return;
        }// end function

    }
}
