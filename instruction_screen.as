package 
{
    import flash.events.*;
    import flash.media.*;
    import gs.*;
    import gs.easing.*;
    import instruction_screen.*;

    public class instruction_screen extends instruction_screenClip
    {
        //private var introVideo:FLVPlayback;
        private var step_durations:Array;

        public function instruction_screen()
        {
           /* var _loc_1:* = NaN;
            var _loc_2:* = undefined;
            step_durations = new Array(1, 12, 20, 5, 7, 7, 6, 7, 2.6, 12.5, 4, 1);
            globals.status = globals.STATUS_INTRODUCTION;
            globals.progressBar.show();
            globals.progressBar.setPercentage(0, 0);
            good_luck.alpha = 0;
            text0.alpha = 0;
            text1.alpha = 0;
            textballoon2.alpha = 0;
            textballoon3.alpha = 0;
            textballoon4.alpha = 0;
            lever.alpha = 0;
            vignet_big.alpha = 0;
            machine.alpha = 0;
            machine.ignoreLever = true;
            machine.intro_machine.tube1.ignoreLever = true;
            machine.intro_machine.tube2.ignoreLever = true;
            machine.intro_machine.tube3.ignoreLever = true;
            machine.intro_machine.tube4.ignoreLever = true;
            startbutton.alpha = 0;
            text1.scaleX = 1.1;
            text1.scaleY = 1.1;
            text1.x = 704;
            text1.y = 440;
            _loc_1 = 0;
            _loc_2 = 0;
            while (_loc_2 < step_durations.length)
            {
                
                _loc_1 = _loc_1 + step_durations[_loc_2];
                _loc_2 = _loc_2 + 1;
            }
            TweenMax.delayedCall(step_durations[0], step1);
            globals.progressBar.setPercentage(100, _loc_1);*/
            return;
        }// end function

        override protected function timeisalmostup(event:Event) : void
        {
            globals.showOverlay(new timealmostup());
            globals.countdown.start(globals.dictionary.getKey("room" + globals.config.room + "_countdown"));
            return;
        }// end function

       // private function step8() : void
        //{
            //TweenMax.to(textballoon4, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:1});
            //TweenMax.to(lever, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:1.2});
            //TweenMax.to(textballoon3, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:1.4});
            //TweenMax.to(textballoon2, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:1.6});
            //TweenMax.to(machine, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:1.8});
            //TweenMax.to(vignet_big, 0.2, {autoAlpha:0, ease:Linear.easeNone, delay:2});
            //TweenMax.delayedCall(step_durations[8], step9);
            //return;
        //}// end function
//
        //private function step9() : void
        //{
            //introVideo = new FLVPlayback();
            //introVideo.scaleMode = "exactFit";
            //introVideo.width = 1344;
            //introVideo.height = 756;
            //introVideo.autoRewind = false;
            //introVideo.fullScreenTakeOver = false;
            //introVideo.play("video/intro.flv");
            //introvid.movieHolder.addChild(introVideo);
            //TweenMax.to(introvid, 0.4, {alpha:1, ease:Linear.easeNone, delay:0.3});
            //introvid.visible = true;
            //TweenMax.delayedCall(step_durations[9], step10);
            //return;
        //}// end function
//
        //private function step7() : void
        //{
            //TweenMax.to(lever, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:0});
            //TweenMax.to(textballoon4, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:0.7});
            //TweenMax.delayedCall(2, machine.intro_machine.tube1.releaseBalls);
            //TweenMax.delayedCall(2, machine.intro_machine.tube2.releaseBalls);
            //TweenMax.delayedCall(2, machine.intro_machine.tube3.releaseBalls);
            //TweenMax.delayedCall(2, machine.intro_machine.tube4.releaseBalls);
            //TweenMax.delayedCall(3.5, machine.intro_machine.tube1.reset);
            //TweenMax.delayedCall(3.5, machine.intro_machine.tube2.reset);
            //TweenMax.delayedCall(3.5, machine.intro_machine.tube3.reset);
            //TweenMax.delayedCall(3.5, machine.intro_machine.tube4.reset);
            //TweenMax.delayedCall(step_durations[7], step8);
            //return;
        //}// end function
//
        //private function step11() : void
        //{
            //if (globals.game.autostart_after_intro == 1)
            //{
                //TweenMax.delayedCall(0.5, startGame);
                //return;
            //}
            //globals.ctrls.addEventListener("start", startGame, false, 0, true);
            //TweenMax.to(startbutton, 1, {autoAlpha:1, ease:Linear.easeNone});
            //TweenMax.to(startbutton, 15, {scaleX:1.1, scaleY:1.1, ease:Quad.easeOut});
            //TweenMax.delayedCall(step_durations[11], stepsDone);
            //return;
        //}// end function

        override protected function countdown(event:CustomEvent) : void
        {
            globals.countdown.setSeconds(event.data.value);
            return;
        }// end function

        //private function step10() : void
        //{
            //introVideo.stop();
            //TweenMax.to(introvid, 0.4, {alpha:0, ease:Linear.easeNone});
            //TweenMax.to(good_luck, 0.2, {autoAlpha:1, ease:Linear.easeNone, delay:0.5});
            //TweenMax.to(good_luck, 4, {scaleX:1.1, scaleY:1.1, ease:Linear.easeNone, delay:0.5});
            //TweenMax.to(good_luck, 0.3, {overwrite:false, autoAlpha:0, ease:Linear.easeNone, delay:4.5});
            //TweenMax.delayedCall(step_durations[10], step11);
            //return;
        //}// end function

        private function stepsDone() : void
        {
            globals.progressBar.hide();
            return;
        }// end function

        override protected function reset(event:Event) : void
        {
            globals.showScreen(new idle_screen());
            return;
        }// end function

        private function startGame(event:Event = null) : void
        {
            //var _loc_2:* = null;
            //globals.ctrls.removeEventListener("start", startGame);
            //_loc_2 = new startbutton_short();
            //_loc_2.play();
            //globals.progressBar.hide();
            //TweenMax.killAllDelayedCalls();
            globals.showScreen(new game_screen());
            return;
        }// end function

        override protected function timeisup(event:Event) : void
        {
            globals.countdown.hide();
            globals.sandTimer.hide();
            globals.score_counter.hide();
            globals.showScreen(new completed_screen());
            return;
        }// end function

        override protected function cleanup(event:Event) : void
        {
            super.cleanup(event);
            globals.progressBar.hide();
            //TweenMax.killDelayedCallsTo(step1);
            //TweenMax.killDelayedCallsTo(step2);
            //TweenMax.killDelayedCallsTo(step3);
            //TweenMax.killDelayedCallsTo(step4);
            //TweenMax.killDelayedCallsTo(step5);
            //TweenMax.killDelayedCallsTo(step6);
            TweenMax.killDelayedCallsTo(stepsDone);
            globals.ctrls.removeEventListener("start", startGame);
            return;
        }// end function

        //private function step4() : void
        //{
            //TweenMax.to(textballoon2, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:0.6});
            //TweenMax.delayedCall(0, machine.intro_machine.tube1.addBall, ["red"]);
            //TweenMax.delayedCall(0.3, machine.intro_machine.tube1.addBall, ["yellow"]);
            //TweenMax.delayedCall(0.6, machine.intro_machine.tube2.addBall, ["red"]);
            //TweenMax.delayedCall(0.9, machine.intro_machine.tube3.addBall, ["yellow"]);
            //TweenMax.delayedCall(1.2, machine.intro_machine.tube4.addBall, ["red"]);
            //TweenMax.delayedCall(1.5, machine.intro_machine.tube4.addBall, ["yellow"]);
            //TweenMax.delayedCall(1.8, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(2.1, machine.intro_machine.tube3.addBall, ["yellow"]);
            //TweenMax.delayedCall(2.4, machine.intro_machine.tube1.addBall, ["red"]);
            //TweenMax.delayedCall(2.7, machine.intro_machine.tube2.addBall, ["yellow"]);
            //TweenMax.delayedCall(3, machine.intro_machine.tube2.addBall, ["red"]);
            //TweenMax.delayedCall(3.3, machine.intro_machine.tube3.addBall, ["yellow"]);
            //TweenMax.delayedCall(3.6, machine.intro_machine.tube1.addBall, ["red"]);
            //TweenMax.to(textballoon2, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:4});
            //TweenMax.delayedCall(5, machine.intro_machine.tube1.hiliteBall, [4]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube2.hiliteBall, [3]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube3.hiliteBall, [2]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube4.hiliteBall, [1]);
            //TweenMax.delayedCall(step_durations[4], step5);
            //return;
        //}// end function
//
        //private function step5() : void
        //{
            //machine.intro_machine.tube1.releaseBalls();
            //machine.intro_machine.tube2.releaseBalls();
            //machine.intro_machine.tube3.releaseBalls();
            //machine.intro_machine.tube4.releaseBalls();
            //TweenMax.delayedCall(2, machine.intro_machine.tube1.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube2.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube3.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube4.reset);
            //TweenMax.delayedCall(2.1, machine.intro_machine.tube1.addBall, ["yellow"]);
            //TweenMax.delayedCall(2.4, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(2.7, machine.intro_machine.tube2.addBall, ["yellow"]);
            //TweenMax.delayedCall(3, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(3.3, machine.intro_machine.tube4.addBall, ["yellow"]);
            //TweenMax.delayedCall(3.6, machine.intro_machine.tube1.addBall, ["red"]);
            //TweenMax.delayedCall(3.9, machine.intro_machine.tube2.addBall, ["yellow"]);
            //TweenMax.delayedCall(4.2, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(4.5, machine.intro_machine.tube1.addBall, ["yellow"]);
            //TweenMax.delayedCall(4.8, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(6, machine.intro_machine.tube3.hiliteBall, [1]);
            //TweenMax.delayedCall(6, machine.intro_machine.tube3.hiliteBall, [2]);
            //TweenMax.delayedCall(6, machine.intro_machine.tube3.hiliteBall, [3]);
            //TweenMax.delayedCall(6, machine.intro_machine.tube3.hiliteBall, [4]);
            //TweenMax.delayedCall(step_durations[5], step6);
            //return;
        //}// end function
//
        //private function step2() : void
        //{
            //TweenMax.to(text0, 0.5, {alpha:0, ease:Quad.easeIn});
            //TweenMax.to(text1, 0.5, {y:460, alpha:1, ease:Quad.easeIn, delay:0.4});
            //TweenMax.to(text1, step_durations[2], {scaleX:1.3, scaleY:1.3, ease:Linear.easeNone});
            //TweenMax.delayedCall(step_durations[2], step3);
            //return;
        //}// end function
//
        //private function step3() : void
        //{
            //TweenMax.to(text1, 0.5, {y:330, x:1030, scaleX:0, scaleY:0, ease:Quad.easeInOut});
            //TweenMax.to(vignet_big, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:0.9});
            //TweenMax.to(machine, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:1.2});
            //TweenMax.to(textballoon3, 0.3, {autoAlpha:1, ease:Linear.easeNone, delay:2});
            //TweenMax.delayedCall(step_durations[3], step4);
            //return;
        //}// end function
//
        //private function step6() : void
        //{
            //machine.intro_machine.tube1.releaseBalls();
            //machine.intro_machine.tube2.releaseBalls();
            //machine.intro_machine.tube3.releaseBalls();
            //machine.intro_machine.tube4.releaseBalls();
            //TweenMax.delayedCall(2, machine.intro_machine.tube1.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube2.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube3.reset);
            //TweenMax.delayedCall(2, machine.intro_machine.tube4.reset);
            //TweenMax.delayedCall(2.1, machine.intro_machine.tube1.addBall, ["red"]);
            //TweenMax.delayedCall(2.4, machine.intro_machine.tube1.addBall, ["yellow"]);
            //TweenMax.delayedCall(2.7, machine.intro_machine.tube2.addBall, ["red"]);
            //TweenMax.delayedCall(3, machine.intro_machine.tube2.addBall, ["yellow"]);
            //TweenMax.delayedCall(3.3, machine.intro_machine.tube3.addBall, ["red"]);
            //TweenMax.delayedCall(3.6, machine.intro_machine.tube1.addBall, ["yellow"]);
            //TweenMax.delayedCall(3.9, machine.intro_machine.tube4.addBall, ["red"]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube1.hiliteBall, [1]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube2.hiliteBall, [1]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube3.hiliteBall, [1]);
            //TweenMax.delayedCall(5, machine.intro_machine.tube4.hiliteBall, [1]);
            //TweenMax.delayedCall(step_durations[6], step7);
            //return;
        //}// end function
//
        //private function step1() : void
        //{
            //TweenMax.to(text0, 0.5, {y:490, alpha:1, ease:Quad.easeIn});
            //TweenMax.to(text0, step_durations[1], {scaleX:1.3, scaleY:1.3, ease:Linear.easeNone});
            //TweenMax.delayedCall(step_durations[1], step2);
            //return;
        //}// end function

    }
}
