package roshen
{
    import flash.display.*;
    import flash.events.*;
    import gs.*;
    import gs.easing.*;

    public class scorecounter extends MovieClip
    {
        private var xpos:Number;
        private var ypos:Number;
        private var scale:Number;
        public var counter1:counterGrey;
        public var counter2:counterGrey;

        public function scorecounter()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, tostage, false, 0, true);
            globals.score_counter = this;
            counter1.flipspeed = 0.6;
            reset();
            return;
        }// end function

        public function unhilite()
        {
            TweenMax.killTweensOf(this);
            TweenMax.to(this, 0, {overwrite:false, glowFilter:{blurX:22, blurY:22, alpha:1, strength:0, color:16777215}});
            return;
        }// end function

        public function hilite()
        {
            TweenMax.killTweensOf(this);
            TweenMax.to(this, 0.5, {glowFilter:{blurX:22, blurY:22, alpha:1, strength:3, color:16777215}});
            TweenMax.to(this, 0.5, {overwrite:false, glowFilter:{blurX:22, blurY:22, alpha:1, strength:0, color:16777215}, delay:0.5, onComplete:hilite});
            return;
        }// end function

        public function setScore(param1:Number)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            TweenMax.to(this, 0.4, {autoAlpha:1, ease:Linear.easeNone});
            _loc_2 = (param1 - param1 % 10) / 10;
            _loc_3 = param1 % 10;
            counter1.setValue(_loc_2);
            counter2.setValue(_loc_3);
            return;
        }// end function

        private function tostage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, tostage);
            xpos = this.x;
            ypos = this.y;
            scale = this.scaleX;
            return;
        }// end function

        public function reset()
        {
            this.visible = false;
            counter1.setValue(0);
            counter2.setValue(0);
            return;
        }// end function

        public function minimize()
        {
            TweenMax.to(this, 0.7, {x:xpos - 40, y:ypos + 160, scaleX:scale * 0.62, scaleY:scale * 0.62, ease:Quad.easeInOut});
            return;
        }// end function

        public function maximize()
        {
            TweenMax.to(this, 0.7, {x:xpos, y:ypos, scaleX:scale, scaleY:scale, ease:Quad.easeInOut});
            return;
        }// end function

        public function show()
        {
            TweenMax.killTweensOf(this);
            counter1.setValue(0);
            counter2.setValue(0);
            TweenMax.to(this, 0.4, {autoAlpha:1, ease:Linear.easeNone});
            return;
        }// end function

        public function hide()
        {
            TweenMax.killTweensOf(this);
            TweenMax.to(this, 0.4, {autoAlpha:0, ease:Linear.easeNone});
            return;
        }// end function

    }
}
