package roshen
{
    import flash.display.*;
    import gs.*;
    import gs.easing.*;

    public class moving_arrow extends MovieClip
    {
        public var arrow:MovieClip;

        public function moving_arrow()
        {
            TweenMax.to(arrow, 0.7, {yoyo:999999, x:-58, y:-110, ease:Quad.easeOut});
            return;
        }// end function

    }
}
