package sm.game
{
    import flash.display.*;
    import flash.events.*;

    public class base_clip extends MovieClip
    {

        public function base_clip()
        {
            this.addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false, 0, true);
            this.addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
            return;
        }// end function

        protected function enterframe(event:Event) : void
        {
            return;
        }// end function

        protected function cleanup(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, cleanup);
            removeEventListener(Event.ENTER_FRAME, enterframe);
            return;
        }// end function

    }
}
