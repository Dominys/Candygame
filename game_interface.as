package 
{
    import com.phidgets.events.*;
    import flash.events.*;
    import game_interface.*;
    import sm.game.*;

    public class game_interface extends hw_interface
    {

        public function game_interface(param1:String = "localhost", param2:Number = 5001, param3:Number = 0)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override protected function onAttach(event:PhidgetEvent) : void
        {
            super.onAttach(event);
            globals.alert("phidget attached: " + event.Device);
            return;
        }// end function

        override protected function onSensorChange(event:PhidgetDataEvent) : void
        {
            dispatchEvent(new CustomEvent("sensorChanged", {index:event.Index, data:event.Data}));
            return;
        }// end function

        override protected function onConnect(event:PhidgetEvent) : void
        {
            super.onConnect(event);
            globals.alert("connected to phidget-service : " + event.Device);
            return;
        }// end function

        override protected function onDetach(event:PhidgetEvent) : void
        {
            super.onDetach(event);
            globals.alert("phidget detached: " + event.Device);
            return;
        }// end function

        override protected function onInputChange(event:PhidgetDataEvent) : void
        {
            dispatchEvent(new CustomEvent("inputChanged", {index:event.Index, data:event.Data}));
            return;
        }// end function

        override protected function reconnect(event:TimerEvent) : void
        {
            globals.alert("Reconnecting to phidget-service");
            super.reconnect(event);
            return;
        }// end function

        override protected function onDisconnect(event:PhidgetEvent) : void
        {
            super.onDisconnect(event);
            globals.alert("disconnected from phidget-service: " + event.Device);
            return;
        }// end function

        override protected function onError(event:PhidgetErrorEvent) : void
        {
            super.onError(event);
            globals.alert("phidget error: " + event.Error);
            return;
        }// end function

    }
}
