package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import fl.video.FLVPlayback;
	import fl.video.MetadataEvent;
	
	/**
	 * ...
	 * @author Robert Grey
	 */
	public class Main extends Sprite {
		
		private var output:TextField = genText();
		private var video:FLVPlayback = new FLVPlayback();
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function playVideo(): void {
			video.play();
		}
			
		private function pauseVideo(): void {
			video.pause();
		}
		
		private function addCue(time:int, message:String): void {
			video.addASCuePoint(time, message);
			output.appendText("cue [" + message + "] added...\n");
		}
		
		private function cueListener(eventObject:MetadataEvent):void {
			output.appendText("cue hit " + eventObject.info.name + "...\n");
			ExternalInterface.call("cueMet", eventObject.info.name);
		}
		
		private function genText(): TextField {
			var input:TextField = new TextField();
            input.type = TextFieldType.INPUT;
            input.background = true;
            input.border = true;
            input.width = 350;
            input.height = 50;
			return input;
		}
		
		private function init(e:Event = null):void {
			trace("init");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// add queue listening
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("playVideo", playVideo);
				ExternalInterface.addCallback("pauseVideo", pauseVideo);
				ExternalInterface.addCallback("addCue", addCue);
				output.appendText("callbacks loaded...\n");
			} else {
				output.appendText("callbacks unavailabled...");
			}
			
			// add the status box
			addChild(output);
			
			// initialize and embed the video player			
			video.x = 150;
			video.y = 25;
			video.setSize(500, 500);
			video.source = "video.flv";
			video.pause();
			video.addEventListener(MetadataEvent.CUE_POINT, cueListener);
			addChild(video);
			
			// alert the page
			if (ExternalInterface.available) ExternalInterface.call("videoloaded");
			
			trace("init complete");
		}
		
	}
	
}