package sm.game
{
    import com.phidgets.*;
    import com.phidgets.events.*;
    import flash.events.*;
    import flash.utils.*;
    import gs.*;

    public class hw_interface extends EventDispatcher
    {
        protected var server:String;
        protected var port:Number;
        private var checkTimer:Timer;
        public var phidget:PhidgetInterfaceKit;
        private var reconnectTimer:Timer;
        protected var serial:Number;

        public function hw_interface(param1:String = "localhost", param2:Number = 5001, param3:Number = 0)
        {
            this.serial = param3;
            this.server = param1;
            this.port = param2;
            phidget = new PhidgetInterfaceKit();
            checkTimer = new Timer(5000, 0);
            checkTimer.addEventListener(TimerEvent.TIMER, checkIfConnected);
            checkTimer.start();
            return;
        }// end function

        private function checkIfConnected(event:TimerEvent) : void
        {
            if (phidget)
            {
                if (phidget.isConnected == false)
                {
                    if (reconnectTimer)
                    {
                        if (!reconnectTimer.running)
                        {
                            reconnectTimer = new Timer(8000, 1);
                            reconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, reconnect, false, 0, true);
                            reconnectTimer.start();
                        }
                    }
                    else
                    {
                        reconnectTimer = new Timer(8000, 1);
                        reconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, reconnect, false, 0, true);
                        reconnectTimer.start();
                    }
                }
            }
            return;
        }// end function

        protected function onSensorChange(event:PhidgetDataEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetSensorChanged", {phidget:event.Device}));
            return;
        }// end function

        protected function onOutputChange(event:PhidgetDataEvent) : void
        {
            return;
        }// end function

        protected function onDetach(event:PhidgetEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetDetached", {phidget:event.Device}));
            disconnect();
            return;
        }// end function

        protected function onAttach(event:PhidgetEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetAttached", {phidget:event.Device}));
            return;
        }// end function

        protected function reconnect(event:TimerEvent) : void
        {
            dispatchEvent(new Event("reconnect"));
            reconnectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, reconnect);
            reconnectTimer.stop();
            connect();
            return;
        }// end function

        protected function onConnect(event:PhidgetEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetConnected", {phidget:event.Device}));
            return;
        }// end function

        protected function onDisconnect(event:PhidgetEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetDisconnected", {phidget:event.Device}));
            disconnect();
            return;
        }// end function

        public function setDigitalOut(param1:int, param2:Boolean, param3:Number = -1)
        {
            if (phidget.isConnected)
            {
                if (phidget.isAttached)
                {
                    phidget.setOutputState(param1, param2);
                    if (param2 == true && param3 != -1)
                    {
                        TweenMax.delayedCall(param3, setDigitalOut, [param1, false]);
                    }
                }
            }
            return;
        }// end function

        public function setSensorChangeTrigger(param1:int, param2:Number)
        {
            phidget.setSensorChangeTrigger(param1, param2);
            return;
        }// end function

        protected function onError(event:PhidgetErrorEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetError", {error:event.Error}));
            disconnect();
            return;
        }// end function

        public function connect()
        {
            TweenMax.killDelayedCallsTo(connect);
            phidget.removeEventListener(PhidgetEvent.CONNECT, onConnect);
            phidget.removeEventListener(PhidgetEvent.DISCONNECT, onDisconnect);
            phidget.removeEventListener(PhidgetEvent.DETACH, onDetach);
            phidget.removeEventListener(PhidgetEvent.ATTACH, onAttach);
            phidget.removeEventListener(PhidgetErrorEvent.ERROR, onError);
            phidget.removeEventListener(PhidgetDataEvent.INPUT_CHANGE, onInputChange);
            phidget.removeEventListener(PhidgetDataEvent.SENSOR_CHANGE, onSensorChange);
            phidget.addEventListener(PhidgetEvent.CONNECT, onConnect);
            phidget.addEventListener(PhidgetEvent.DISCONNECT, onDisconnect);
            phidget.addEventListener(PhidgetEvent.DETACH, onDetach);
            phidget.addEventListener(PhidgetEvent.ATTACH, onAttach);
            phidget.addEventListener(PhidgetErrorEvent.ERROR, onError);
            phidget.addEventListener(PhidgetDataEvent.INPUT_CHANGE, onInputChange);
            phidget.addEventListener(PhidgetDataEvent.SENSOR_CHANGE, onSensorChange);
            if (serial != 0)
            {
                phidget.open(server, port, null, serial);
            }
            else
            {
                phidget.open(server, port);
            }
            return;
        }// end function

        public function disconnect()
        {
            phidget.removeEventListener(PhidgetEvent.CONNECT, onConnect);
            phidget.removeEventListener(PhidgetEvent.DISCONNECT, onDisconnect);
            phidget.removeEventListener(PhidgetEvent.DETACH, onDetach);
            phidget.removeEventListener(PhidgetEvent.ATTACH, onAttach);
            phidget.removeEventListener(PhidgetErrorEvent.ERROR, onError);
            phidget.removeEventListener(PhidgetDataEvent.INPUT_CHANGE, onInputChange);
            phidget.removeEventListener(PhidgetDataEvent.SENSOR_CHANGE, onSensorChange);
            phidget.close();
            return;
        }// end function

        protected function onInputChange(event:PhidgetDataEvent) : void
        {
            dispatchEvent(new CustomEvent("phidgetInputChanged", {phidget:event.Device}));
            return;
        }// end function

    }
}
