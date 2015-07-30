package
{
	import flash.events.*;
	import flash.ui.*;
	import gs.*;
	
	public class controls extends EventDispatcher
	{
		private var distances:Array;
		private var myInterface1:game_interface;
		private var myInterface2:game_interface;
		private var measured1:Object = 0;
		private var measured3:Object = 0;
		private var measured2:Object = 0;
		public var gateOpen:Boolean = false;
		
		public function controls()
		{
			measured1 = 0;
			measured2 = 0;
			measured3 = 0;
			gateOpen = false;
			if (globals.config.hardwareinterfaces.interface1 != "" && globals.config.testing != 1)
			{
				myInterface1 = new game_interface("localhost", 5001, globals.config.hardwareinterfaces.interface1);
				myInterface1.connect();
				myInterface1.addEventListener("inputChanged", inputChanged, false, 0, true);
				myInterface1.addEventListener("sensorChanged", sensorChanged, false, 0, true);
			}
			if (globals.config.hardwareinterfaces.interface2 != "" && globals.config.testing != 1)
			{
				myInterface2 = new game_interface("localhost", 5001, globals.config.hardwareinterfaces.interface2);
				myInterface2.connect();
				myInterface2.addEventListener("sensorChanged", sensorChanged2, false, 0, true);
			}
			globals.screen.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			distances = new Array(8);
			return;
		} // end function
		
		private function measure1(tubeNr:int):void
		{
			var sensor:XMLList;

			sensor = globals.game.distancesensors.sensor.(@tube == tubeNr);
			if (globals.game.showmeasures == 1)
			{
				globals.alert("Ball in tube: " + tubeNr);
			}
			if (sensor.length() > 0)
			{
				measured1 = myInterface1.phidget.getSensorValue(sensor.@index);
				TweenMax.delayedCall(0.025, measure2, [tubeNr]);
				TweenMax.delayedCall(0.05, measure3, [tubeNr]);
			}
			return;
		} // end function
		
		private function measure2(tubeNr:int):void
		{
			var sensor:XMLList;
			sensor = globals.game.distancesensors.sensor.(@tube == tubeNr);
			if (sensor.length() > 0)
			{
				measured2 = myInterface1.phidget.getSensorValue(sensor.@index);
			}
			return;
		} // end function
		
		private function measure3(tubeNr:int):void
		{
			var sensor:XMLList;
			var final_value:*;
			var alertText:*;
			//var tubeNr:* = param1;
			//var _loc_4:* = 0;
			//var _loc_5:* = globals.game.lightsensors.sensor;
			//var _loc_3:* = new XMLList("");
			
			
			
			sensor = globals.game.distancesensors.sensor.(@tube == tubeNr);
			if (sensor.length() > 0)
			{
				measured3 = myInterface1.phidget.getSensorValue(sensor.@index);
			}
			
			alertText = alertText + ("Measures " + measured1 + " / " + measured2 + " / " + measured3 + "\n");
			final_value = (measured1 + measured2 + measured3) / 3;
			alertText = alertText + ("Average =  " + final_value);
						
			if (globals.game.showmeasures == 1)
			{
				globals.alert(alertText);
			}
			
			if (final_value >= globals.game.distancesensors.inrange.@min && final_value < globals.game.distancesensors.inrange.@max)
			{
				dispatchEvent(new CustomEvent("ball", {tube:tubeNr, color:"auto"}));
			}
			
			return;
		} // end function
		
		private function sensorChanged(event:CustomEvent):void
		{
			checkSensor(event.data.index, event.data.data, "interface1", myInterface1);
			return;
		} // end function
		
		private function inputChanged(event:CustomEvent):void
		{
			if (event.data.index == 0 && event.data.data == 1)
			{
				dispatchEvent(new Event("start"));
			}
			if (event.data.index == 1 && event.data.data == 1)
			{
				dispatchEvent(new Event("release"));
				dispatchEvent(new Event("start"));
				gateOpen = true;
			}
			if (event.data.index == 1 && event.data.data == 0)
			{
				gateOpen = false;
			}
			return;
		} // end function
		
		public function setLight(index:Number, value:Boolean = true):void
		{
			var property:XML;
			var Leds:XMLList = globals.game.leds.led;
			try
			{
				for each (property in Leds)
				{
					if (property.@index == index)
					{
						if (property.@interf == "interface1")
						{
							if (myInterface1)
							{
								myInterface1.setDigitalOut(index, value);
							}
						}
						if (property.@interf == "interface2")
						{
							if (myInterface2)
							{
								myInterface2.setDigitalOut(index, value);
							}
						}
						break;
					}
				}				
			}
			catch (errObject:Error)
			{
				globals.alert(errObject.name + " | " + errObject.message);
			}
			return;
		} // end function
		
		private function sensorChanged2(event:CustomEvent):void
		{
			checkSensor(event.data.index, event.data.data, "interface2", myInterface2);
			return;
		} // end function
		
		private function keyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == "0".charCodeAt())
			{
				dispatchEvent(new Event("start"));
			}
			if (event.keyCode == "1".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", { tube: 1, color: "red" } ));
			}
			if (event.keyCode == "2".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 2}));
			}
			if (event.keyCode == "3".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 3}));
			}
			if (event.keyCode == "4".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 4}));
			}
			if (event.keyCode == "5".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 5}));
			}
			if (event.keyCode == "6".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 6}));
			}
			if (event.keyCode == "7".charCodeAt())
			{
				dispatchEvent(new CustomEvent("ball", {tube: 7}));
			}
			if (event.keyCode == "8".charCodeAt())
			{
				gateOpen = false;
			}
			if (event.keyCode == "9".charCodeAt())
			{
				gateOpen = true;
				dispatchEvent(new Event("release"));
			}
			if (event.keyCode == "t".charCodeAt() || event.keyCode == "T".charCodeAt() || event.keyCode == Keyboard.UP)
			{
				dispatchEvent(new Event("timeup"));
			}
			if (event.keyCode == "y".charCodeAt() || event.keyCode == "Y".charCodeAt() )
			{
				dispatchEvent(new Event("timealmostup"));
			}
			if (event.keyCode == "r".charCodeAt() || event.keyCode == "R".charCodeAt() || event.keyCode == Keyboard.DOWN)
			{
				dispatchEvent(new Event("reset"));
			}
			return;
		} // end function
		
		private function checkSensor(index:String, value:Number, param3:String, param4)
		{
			var distancesensor:*;
			var interfaceName:* = param3;
			var myInterface:* = param4;
			var _loc_7:* = 0;
			
			var SensorList:XMLList = globals.game.distancesensors.sensor;
			distancesensor = globals.game.distancesensors.sensor.(@index == index);
			
			if (distancesensor.length() > 0)
			{
				if (value >= globals.game.distancesensors.inrange.@min && value <= globals.game.distancesensors.inrange.@max)
				{
				TweenMax.killDelayedCallsTo(setDistanceOutOfRange);
				if (distances[distancesensor.@tube] != 1)
				{
					distances[distancesensor.@tube] = 1;
					TweenMax.delayedCall(0, measure1, [distancesensor.@tube]);
				}
				}
				else
				{
					TweenMax.delayedCall(0.2, setDistanceOutOfRange, [distancesensor.@tube]);
				}
			}
			return;
		} // end function
		
		private function setDistanceOutOfRange(param1:int):void
		{
			distances[param1] = 0;
			return;
		} // end function
	
	}
}
