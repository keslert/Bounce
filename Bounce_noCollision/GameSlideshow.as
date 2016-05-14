package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import mochi.as3.*;

	public class GameSlideshow extends Sprite {
		
		private var thumbnail:thumbnailMC;
		private var highlighted:thumbnailMC;
		private var thumbnails:Array;
		private var recycledThumbnails:Array;
		private var gamesArray:Array;
		private var _r:Sprite;
		private var delay:int;
		private var delayReset:int;
		private var total:int;
		private var current:int;
		private var restartX:int;
		private var speed:int;
		private var locked:Boolean=false;
		public function GameSlideshow(_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			thumbnails = new Array();
			recycledThumbnails = new Array();
			gamesArray = ["Archery Challenge","Bike Mania 4","Bunny Flags","Chibi Knight",
						  "Fancy Pants Adventure","World Basketball Challenge","Monkey Kickoff",
						  "Madpet Halfpipe","Blastoff Bunnies","Bimmin", "Beauty Resort",
						  "Aqua Rotation","Pandas Big Adventure","Faultline", "Guardian Rock",
						  "Kick Buttowski MotoRush", "Zombie Bites", "Sniper Year One",
						  "Hurry Up Bob", "Quarterback Challenge 2010", "Indestruc2Tank",
						  "HeliBoarding","Hungry Sumo","DinoRun","World Cup Championship",
						  "Drake and the Wizard","Fludo Tasty Mushrooms","Virble",
						  "SkyFireII","Golferrific","Critter Escape","Wezap",
						  "Shopping Cart Hero 2","Bed and Breakfast 2","Morplee",
						  "Upstream Kayak","Space is Key"
						  ];
			delayReset = 30;
			delay = 0;
			restartX = 200;
			speed = 2;
			total = gamesArray.length;
			current = int(Math.random()*total);
		}
		public function restart():void {
			this.addEventListener(Event.ENTER_FRAME,update);
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseover);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseout);
			this.addEventListener(MouseEvent.CLICK,mouseclick);
		}
		private function update(e:Event) {
			if(!locked) {
				if(--delay < 0) {
					delay = delayReset;
					addThumbnail();
				}
				moveThumbnails();
			}
		}
		private function addThumbnail():void {
			current = (current)%total+1;
			if(recycledThumbnails.length > 0) {
				thumbnail = recycledThumbnails.pop();
			} else {
				thumbnail = new thumbnailMC();
				this.addChild(thumbnail);
			}
			thumbnails.push(thumbnail);
			thumbnail.gotoAndStop(current);
			thumbnail.x = restartX;
			thumbnail.visible = true;
		}
		private function moveThumbnails():void {
			for(var i:int=thumbnails.length-1;i>-1;i--) {
				thumbnail = thumbnails[i];
				thumbnail.x-=speed;
				thumbnail.alpha = 1-(Math.abs(thumbnail.x)/restartX);
				if(thumbnail.x < -restartX) {
					thumbnails.splice(i,1);
					thumbnail.visible = false;
					recycledThumbnails.push(thumbnail);
				}
			}
		}
		public function cleanup():void {
			this.removeEventListener(Event.ENTER_FRAME,update);
			this.removeEventListener(MouseEvent.MOUSE_OVER,mouseover);
			this.removeEventListener(MouseEvent.MOUSE_OUT,mouseout);
			this.removeEventListener(MouseEvent.CLICK,mouseclick);
			for(var i:int=thumbnails.length-1;i>-1;i--) {
				thumbnail = thumbnails[i];
				thumbnail.visible = false;
				thumbnails.splice(i,1);
				recycledThumbnails.push(thumbnail);				
			}
		}
		private function mouseover(e:MouseEvent) {
			locked = true;
			highlighted = getThumbnail();
			highlighted.scaleX = highlighted.scaleY = 1.1;
			highlighted.alpha = 1;
		}
		private function mouseout(e:MouseEvent) {
			highlighted.scaleX = highlighted.scaleY = 1;
			locked = false;
			highlighted = null;
		}
		private function mouseclick(e:MouseEvent) {
			if(highlighted!=null) {
				navigateToURL(new URLRequest("http://www.gameplode.com/play/"+getGameName(highlighted)), "_blank");
				MochiEvents.trackEvent("slideshowClicked");
			}
		}
		private function getThumbnail():thumbnailMC {
			var l = thumbnails.length;
			var dist = 200;
			var thumbnail;
			for(var i:int=0;i<l;i++) {
				var curDist = Math.abs(this.mouseX-thumbnailMC(thumbnails[i]).x);
				if(curDist < dist) {
					thumbnail = thumbnails[i];
					dist = curDist;
				}
			}
			return thumbnail;
		}
		private function getGameName(t:thumbnailMC):String {
			var gameName:String = String(gamesArray[t.currentFrame-1]).toLowerCase();
			while(gameName.indexOf(" ")!=-1) gameName = gameName.replace(" ","");
			return gameName;
		}
	}
}
