package roshen
{
    import flash.display.*;
    import gs.*;
    import gs.easing.*;

    public class counter extends MovieClip
    {
        public var flipspeed:Number = 0.25;
        public var newValueString:String = "0";
        public var bottom:MovieClip;
        public var top:MovieClip;
        public var bottom2:MovieClip;
        public var top2:MovieClip;
        public var newValue:Number = 0;
        private var newValueStr:String;

        public function counter()
        {
            newValue = 0;
            newValueString = "0";
            flipspeed = 0.25;
            newValueStr = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"Myriad Pro\" SIZE=\"46\" LETTERSPACING=\"-1.5\" KERNING=\"0\"><b>" + newValue + "</b></FONT></P></TEXTFORMAT>";
            switchValues();
            return;
        }// end function

        public function setValue(param1:Number)
        {
            if (param1 == newValue)
            {
                return;
            }
            TweenMax.killTweensOf(top);
            TweenMax.killTweensOf(bottom);
            newValue = param1;
            newValueStr = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"Myriad Pro\" SIZE=\"46\" LETTERSPACING=\"-1.5\" KERNING=\"0\"><b>" + newValue + "</b></FONT></P></TEXTFORMAT>";
            top2.tekst.htmlText = newValueStr;
            bottom.tekst.htmlText = newValueStr;
            if (flipspeed > 0)
            {
                TweenMax.to(top, this.flipspeed * 0.6, {scaleY:0, colorMatrixFilter:{brightness:0.25}, ease:Quad.easeIn});
                TweenMax.to(bottom, this.flipspeed * 0.4, {scaleY:1, colorMatrixFilter:{brightness:0.84}, ease:Quad.easeOut, delay:this.flipspeed * 0.6, onComplete:switchValues});
            }
            else
            {
                switchValues();
            }
            return;
        }// end function

        public function setValueString(param1:String)
        {
            if (param1 == newValueString)
            {
                return;
            }
            TweenMax.killTweensOf(top);
            TweenMax.killTweensOf(bottom);
            newValueString = param1;
            newValueStr = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"Myriad Pro\" SIZE=\"46\" LETTERSPACING=\"-1.5\" KERNING=\"0\"><b>" + newValueString + "</b></FONT></P></TEXTFORMAT>";
            top2.tekst.htmlText = newValueStr;
            bottom.tekst.htmlText = newValueStr;
            if (flipspeed > 0)
            {
                TweenMax.to(top, this.flipspeed * 0.6, {scaleY:0, colorMatrixFilter:{brightness:0.25}, ease:Quad.easeIn});
                TweenMax.to(bottom, this.flipspeed * 0.4, {scaleY:1, colorMatrixFilter:{brightness:0.84}, ease:Quad.easeOut, delay:this.flipspeed * 0.6, onComplete:switchValues});
            }
            else
            {
                switchValues();
            }
            return;
        }// end function

        private function switchValues() : void
        {
            TweenMax.killTweensOf(top);
            TweenMax.killTweensOf(bottom);
            if (flipspeed > 0)
            {
                TweenMax.to(top, 0, {colorMatrixFilter:{brightness:1}});
                TweenMax.to(bottom, 0, {colorMatrixFilter:{brightness:0.25}});
            }
            top.tekst.htmlText = newValueStr;
            bottom.tekst.htmlText = newValueStr;
            top2.tekst.htmlText = newValueStr;
            bottom2.tekst.htmlText = newValueStr;
            top.scaleY = 1;
            bottom.scaleY = 0;
            return;
        }// end function

        public function add()
        {
            TweenMax.killTweensOf(top);
            TweenMax.killTweensOf(bottom);
            (newValue + 1);
            newValueStr = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"Myriad Pro\" SIZE=\"46\" LETTERSPACING=\"-1.5\" KERNING=\"0\"><b>" + newValue + "</b></FONT></P></TEXTFORMAT>";
            top2.tekst.htmlText = newValueStr;
            bottom.tekst.htmlText = newValueStr;
            if (flipspeed > 0)
            {
                TweenMax.to(top, this.flipspeed * 0.6, {scaleY:0, colorMatrixFilter:{brightness:0.25}, ease:Quad.easeIn});
                TweenMax.to(bottom, this.flipspeed * 0.4, {scaleY:1, colorMatrixFilter:{brightness:0.84}, ease:Quad.easeOut, delay:this.flipspeed * 0.6, onComplete:switchValues});
            }
            else
            {
                switchValues();
            }
            return;
        }// end function

        public function sub()
        {
            TweenMax.killTweensOf(top);
            TweenMax.killTweensOf(bottom);
            (newValue - 1);
            newValueStr = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"Myriad Pro\" SIZE=\"46\" LETTERSPACING=\"-1.5\" KERNING=\"0\"><b>" + newValue + "</b></FONT></P></TEXTFORMAT>";
            top2.tekst.htmlText = newValueStr;
            bottom.tekst.htmlText = newValueStr;
            if (flipspeed > 0)
            {
                TweenMax.to(top, this.flipspeed * 0.6, {scaleY:0, colorMatrixFilter:{brightness:0.25}, ease:Quad.easeIn});
                TweenMax.to(bottom, this.flipspeed * 0.4, {scaleY:1, colorMatrixFilter:{brightness:0.84}, ease:Quad.easeOut, delay:this.flipspeed * 0.6, onComplete:switchValues});
            }
            else
            {
                switchValues();
            }
            return;
        }// end function

    }
}
