package 
{
    import flash.display.*;
    import flash.events.*;
    import gs.*;
    import gs.easing.*;
    import roshen.*;

    public class globals extends Object
    {
        public static const STATUS_IDLE:Number = 0;
        public static var evtdisp:EventDispatcher = new EventDispatcher();
        public static const STATUS_INGAME:Number = 2;
        public static var dictionary:game_dictionary;
        static const popupTime:Number = 4.5;
        public static const STATUS_FINISHED:Number = 3;
        public static var sandTimer:sandtimer;
        public static var progressBar:progressbar;
        public static var host:String = "";
        public static var popup:MovieClip;
        static const scaleEnd:Number = 1.3;
        public static var countdown:countdowntimer;
        static const scaleStart:Number = 0.7;
        public static const STATUS_INTRODUCTION:Number = 1;
        public static var config:XML;
        public static var score_counter:scorecounter;
        public static var score_counterA:scorecounter;
        public static var score_counterB:scorecounter;
        public static var overlay:MovieClip;
        public static var ctrls:controls;
        public static var screen:MovieClip;
        public static var scoreA:Number = 0;
        public static var status:Number = 0;
        public static var scoreB:Number = 0;
        public static var game:XML;

        public function globals()
        {
            return;
        }// end function

        private static function uncache(param1) : void
        {
            param1.cacheAsBitmap = false;
            return;
        }// end function

        public static function removeScreen(param1) : void
        {
            var screen:* = param1;
            try
            {
                screen.parent.removeChild(screen);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function showOverlay(param1) : void
        {
            while (globals.overlay.numChildren > 0)
            {
                
                globals.overlay.removeChildAt(0);
            }
            globals.overlay.addChild(param1);
            return;
        }// end function

        public static function showPopup(param1) : void
        {
            param1.y = globals.popup.numChildren * (param1.height + 12);
            globals.popup.addChild(param1);
            return;
        }// end function

        public static function randomizeArray(param1:Array) : Array
        {
            var _loc_2:* = null;
            _loc_2 = new Array();
            while (param1.length > 0)
            {
                
                _loc_2.push(param1.splice(Math.floor(Math.random() * param1.length), 1));
            }
            return _loc_2;
        }// end function

        public static function fadeOut(param1:DisplayObject) : void
        {
            param1.cacheAsBitmap = true;
            TweenMax.to(param1, 0.7, {alpha:0, ease:Quad.easeIn});
            TweenMax.to(param1, 0.75, {overwrite:false, scaleX:scaleEnd, scaleY:scaleEnd, onUpdate:globals.updateScaleXYpos, onUpdateParams:[param1], ease:Quad.easeOut, onComplete:removeScreen, onCompleteParams:[param1]});
            return;
        }// end function

        public static function fadeIn(param1) : void
        {
            param1.cacheAsBitmap = true;
            TweenMax.to(param1, 0, {alpha:0, scaleX:scaleStart, scaleY:scaleStart, ease:Linear.easeNone});
            TweenMax.to(param1, 0.7, {overwrite:false, alpha:1, ease:Linear.easeOut});
            TweenMax.to(param1, 0.75, {overwrite:false, scaleX:1, scaleY:1, onUpdate:globals.updateScaleXYpos, onUpdateParams:[param1], ease:Quad.easeOut, onComplete:globals.uncache, onCompleteParams:[param1]});
            return;
        }// end function

        public static function showTimer(param1:Number)
        {
            globals.evtdisp.dispatchEvent(new CustomEvent("timer", {value:param1}));
            return;
        }// end function

        public static function updateScaleXYpos(param1) : void
        {
            param1.x = (globals.screen.stage.stageWidth - globals.screen.stage.stageWidth * param1.scaleX) / 2;
            param1.y = (globals.screen.stage.stageHeight - globals.screen.stage.stageHeight * param1.scaleY) / 2;
            return;
        }// end function

        public static function addPointsToScore(param1:Number = 1, param2:int = 1)
        {
            if (param2 == 1)
            {
                globals.scoreA = globals.scoreA + param1;
				if (globals.scoreA < 0) globals.scoreA = 0;
				if (globals.score_counterA)
                {
                    globals.score_counterA.setScore(globals.scoreA);
                }
            }
            if (param2 == 2)
            {
                globals.scoreB = globals.scoreB + param1;
				if (globals.scoreB < 0) globals.scoreB = 0;
				if (globals.score_counterB)
                {
                    globals.score_counterB.setScore(globals.scoreB);
                }
            }
            return;
        }// end function

        public static function alert(param1:String, param2:Boolean = false)
        {
            var _loc_3:* = undefined;
            _loc_3 = new alertClip();
            _loc_3.tekst.text = param1;
            globals.showPopup(_loc_3);
            if (param2 == false)
            {
                TweenMax.delayedCall(globals.popupTime, globals.removeScreen, [_loc_3]);
            }
            return;
        }// end function

        public static function showScreen(param1, param2:Boolean = true, param3:Boolean = false) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = undefined;
            _loc_4 = false;
            while (globals.popup.numChildren > 0)
            {
                
                globals.popup.removeChildAt(0);
            }
            if (param2)
            {
                while (globals.overlay.numChildren > 0)
                {
                    
                    globals.overlay.removeChildAt(0);
                }
            }
            if (param3 == true)
            {
                while (globals.overlay.numChildren > 0)
                {
                    
                    globals.screen.removeChildAt(0);
                }
            }
            else
            {
                _loc_5 = 0;
                while (_loc_5 < globals.screen.numChildren)
                {
                    
                    globals.fadeOut(globals.screen.getChildAt(_loc_5));
                    _loc_5 = _loc_5 + 1;
                }
                globals.fadeIn(param1);
            }
            globals.screen.addChild(param1);
            return;
        }// end function

        public static function fixText(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            _loc_3 = "";
            _loc_2 = param1.split("\n");
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_3 = _loc_3 + _loc_2[_loc_4];
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

    }
}
