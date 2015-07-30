package roshen
{
    import flash.display.*;
    import gs.*;
    import gs.easing.*;

    public class progressbar extends Sprite
    {
        public var fill:MovieClip;
        private const fullwidth:Number = 253;

        public function progressbar()
        {
            globals.progressBar = this;
            this.alpha = 0;
            fill.width = 0;
            return;
        }// end function

        public function hide()
        {
            TweenMax.to(this, 0.3, {autoAlpha:0, ease:Linear.easeNone});
            return;
        }// end function

        public function setPercentage(param1:Number, param2:Number = 0.15)
        {
            TweenMax.to(fill, param2, {width:param1 / 100 * fullwidth, ease:Linear.easeNone});
            return;
        }// end function

        public function show(param1:Number = 0, param2:Number = 0.15)
        {
            TweenMax.to(this, 0.3, {autoAlpha:1, ease:Linear.easeNone});
            if (param1 != 0)
            {
                setPercentage(param1, param2);
            }
            return;
        }// end function

    }
}
