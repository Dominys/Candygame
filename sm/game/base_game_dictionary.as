package sm.game
{
    import com.phidgets.*;
    import com.phidgets.events.*;
    import flash.events.*;
    import flash.utils.*;

    public class base_game_dictionary extends EventDispatcher
    {
        protected var server:String;
        protected var port:Number;
        protected var myDictionary:PhidgetDictionary;
        private var reconnectTimer:Timer;
        protected var keyListener:PhidgetDictionaryKeyListener;
        protected var internalDictionary:Dictionary;

        public function base_game_dictionary(param1:String = "localhost", param2:Number = 5001)
        {
            this.internalDictionary = new Dictionary();
            this.server = param1;
            this.port = param2;
            myDictionary = new PhidgetDictionary();
            myDictionary.addEventListener(PhidgetDictionaryEvent.CONNECT, connected, false, 0, true);
            myDictionary.addEventListener(PhidgetDictionaryEvent.DISCONNECT, disconnected, false, 0, true);
            connect();
            return;
        }// end function

        protected function connected(event:PhidgetDictionaryEvent) : void
        {
            globals.alert("Connected to dictionary.");
            keyListener = new PhidgetDictionaryKeyListener(myDictionary, ".*");
            keyListener.addEventListener(PhidgetDictionaryEvent.KEY_CHANGE, keyChanged, false, 0, true);
            keyListener.addEventListener(PhidgetDictionaryEvent.KEY_REMOVAL, keyRemoved, false, 0, true);
            keyListener.start();
            dispatchEvent(new Event("connected"));
            return;
        }// end function

        protected function keyRemoved(event:PhidgetDictionaryEvent) : void
        {
            delete internalDictionary[event.Key];
            return;
        }// end function

        protected function disconnected(event:PhidgetDictionaryEvent) : void
        {
            globals.alert("Disconnected from dictionary.");
            reconnectTimer = new Timer(8000, 1);
            reconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, reconnect, false, 0, true);
            reconnectTimer.start();
            return;
        }// end function

        public function encode(param1:String)
        {
            var _loc_2:Array = null;
            var _loc_3:* = undefined;
            _loc_2 = new Array();
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(param1.charCodeAt(_loc_3));
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2.join(" ");
        }// end function

        private function reconnect(event:TimerEvent) : void
        {
            reconnectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, reconnect);
            reconnectTimer.stop();
            connect();
            return;
        }// end function

        public function removeKey(param1:String)
        {
            myDictionary.removeKey(param1);
            delete internalDictionary[param1];
            return;
        }// end function

        protected function keyChanged(event:PhidgetDictionaryEvent) : void
        {
            if (event.Key.substr(0, 4) == "/PCK" || event.Key.substr(0, 4) == "/PSK")
            {
                return;
            }
            internalDictionary[event.Key] = event.Value;
            return;
        }// end function

        protected function timeup() : void
        {
            dispatchEvent(new Event("timeup"));
            return;
        }// end function

        public function getKey(param1:String)
        {
            return internalDictionary[param1];
        }// end function

        protected function connect()
        {
            myDictionary.open(server, port);
            return;
        }// end function

        public function decode(param1:String)
        {
            var _loc_2:Array = null;
            var _loc_3:String = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_3 = "";
            _loc_2 = param1.split(" ");
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = parseInt(_loc_2[_loc_4]);
                if (_loc_5 != 0 && !isNaN(_loc_5))
                {
                    _loc_3 = _loc_3 + String.fromCharCode(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        public function addKey(param1:String, param2)
        {
            myDictionary.addKey(param1, param2);
            internalDictionary[param1] = param2;
            return;
        }// end function

    }
}
