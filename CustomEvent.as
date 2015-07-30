package 
{
    import flash.events.*;

    public class CustomEvent extends Event
    {
        public var data:Object;
        public static const ONLOADED:String = "OnLoaded";

        public function CustomEvent(param1:String, param2)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
