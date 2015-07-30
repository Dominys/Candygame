package sm.game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	
	/**
	 * ...
	 * @author Ramon van de Laar / SeriousMedia
	 */
	public class xmlLoader
	{
		private var on_completeFunction:Function;
		private var on_faultFunction:Function;
		private var filename:String;
		public function xmlLoader(file:String,onComplete:Function,onFault:Function=null):void
		{

			this.filename = file;
			this.on_completeFunction = onComplete;
			this.on_faultFunction = onFault;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, Loaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, LoadError);

			loader.load(new URLRequest(file));

		}
		
		private function LoadError(e:IOErrorEvent):void 
		{
			trace('Could not load file ' + this.filename + '!');
			if (this.on_faultFunction!=null) this.on_faultFunction('Could not load file ' + this.filename + '! '+e.text);
		}
		
		private function Loaded(e:Event):void 
		{
			this.on_completeFunction(new XML(e.target.data));
		}
	}
	
}