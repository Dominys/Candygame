package 
{
    import flash.events.*;
    import gs.*;
	import roshen.code_screen;
	
	
    public class completed_screen extends completed_screenClip
    {

        public function completed_screen()
        {
            globals.status = globals.STATUS_FINISHED;
            TweenMax.delayedCall(5, showCode);
            return;
        }// end function

        override protected function reset(event:Event) : void
        {
            globals.showScreen(new idle_screen());
            return;
        }// end function

        private function showCode() : void
        {
            globals.showScreen(new code_screen());
            return;
        }// end function

    }
}
