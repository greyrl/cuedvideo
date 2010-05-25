package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Robert Grey
	 */
	public class  
	{
		
		private function vide():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var video:Video = new Video();
			addChild(video);
 
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
 
			var ns:NetStream = new NetStream(nc);
			ns.client = {};
			ns.client.onMetaData = ns_onMetaData;
			ns.client.onCuePoint = ns_onCuePoint;
			ns.client.add
			ns.play("http://openinit.com/demo.flv");
 
			video.attachNetStream(ns);
		
 
			function ns_onMetaData(item:Object):void {
				trace("metaData");
				// Resize video instance.
				video.width = item.width;
				video.height = item.height;
				// Center video instance on Stage.
				video.x = (stage.stageWidth - video.width) / 2;
				video.y = (stage.stageHeight - video.height) / 2;
			}
 
			function ns_onCuePoint(item:Object):void {
				trace("cuePoint");
				trace(item.name + "\t" + item.time);
			}
		}
		
	}
	
}