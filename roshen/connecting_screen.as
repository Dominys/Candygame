package roshen
{
    import flash.events.*;
    import flash.text.*;
    import gs.*;
    import sm.game.*;

    public class connecting_screen extends base_screen
    {
        private const STATUS_CONNECTED:Number = 1;
        private var serverport:Number;
        private var serveraddress:String = "";
        private const STATUS_CONNECTING:Number = 0;
        public var txt:TextField;

        public function connecting_screen()
        {
            serveraddress = "";
            if (globals.config.testing != 1)
            {
                serveraddress = globals.config.dictionary.adres;
                serverport = globals.config.dictionary.port;
                txt.text = "connecting to " + serveraddress + " on port " + serverport + "\n";
                connect();
            }
            else
            {
                TweenMax.delayedCall(0.5, startGame);
            }
            return;
        }// end function

        private function retryConnect() : void
        {
            txt.text = "retry connecting to " + serveraddress + " on port " + serverport + "\n";
            connect();
            return;
        }// end function

        private function dot()
        {
            txt.text = txt.text + ".";
            return;
        }// end function

        private function startGame(event:Event = null) : void
        {
            TweenMax.killDelayedCallsTo(retryConnect);
            TweenMax.killDelayedCallsTo(dot);
            txt.text = "connected to the server.";
            globals.showScreen(new idle_screen(), true, false);
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            return;
        }// end function

        private function connect()
        {
            globals.dictionary = new game_dictionary(serveraddress, serverport);
            globals.dictionary.addEventListener("connected", startGame, false, 0, true);
            TweenMax.delayedCall(9, retryConnect);
            TweenMax.delayedCall(1, dot);
            TweenMax.delayedCall(2, dot);
            TweenMax.delayedCall(3, dot);
            TweenMax.delayedCall(4, dot);
            TweenMax.delayedCall(5, dot);
            TweenMax.delayedCall(6, dot);
            TweenMax.delayedCall(7, dot);
            TweenMax.delayedCall(8, dot);
            return;
        }// end function

    }
}
