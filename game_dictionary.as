package 
{
    import com.phidgets.events.*;
    import flash.events.*;
    import game_dictionary.*;
    import sm.game.*;

    public class game_dictionary extends base_game_dictionary
    {

        public function game_dictionary(param1:String = "localhost", param2:Number = 5001)
        {
            super(param1, param2);
            return;
        }// end function

        override protected function disconnected(event:PhidgetDictionaryEvent) : void
        {
            if (globals.sandTimer)
            {
                globals.sandTimer.hide();
            }
            if (globals.progressBar)
            {
                globals.progressBar.hide();
            }
            if (globals.countdown)
            {
                globals.countdown.hide();
            }
            if (globals.score_counterA)
            {
                globals.score_counterA.hide();
            }
            if (globals.score_counterB)
            {
                globals.score_counterB.hide();
            }
            globals.showScreen(new connecting_screen());
            return;
        }// end function

        override protected function keyChanged(event:PhidgetDictionaryEvent) : void
        {
            if (event.Key.substr(0, 4) == "/PCK" || event.Key.substr(0, 4) == "/PSK")
            {
                return;
            }
            super.keyChanged(event);
            if (event.Key == "room" + globals.config.room + "_status")
            {
                if (event.Value == "time_almost_up")
                {
                    dispatchEvent(new Event("timealmostup"));
                }
                if (event.Value == "time_up")
                {
                    dispatchEvent(new Event("timeup"));
                }
                if (event.Value == "reset")
                {
                    dispatchEvent(new Event("reset"));
                }
            }
            if (event.Key == "room" + globals.config.room + "_countdown")
            {
                dispatchEvent(new CustomEvent("countdown", {value:event.Value}));
            }
            return;
        }// end function

    }
}
