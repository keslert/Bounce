package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class Music extends Sound {
	    private var currentSong:Sound;
		private var myChannel:SoundChannel;
		private var myTransform:SoundTransform;
		private var currentSound:Sound;
		private var mySoundChannel:SoundChannel;
		private var myVolume:Number;
		public function Music() {
			myChannel = new SoundChannel();
			myTransform = new SoundTransform();
			myChannel.soundTransform = myTransform;
			mySoundChannel = new SoundChannel();
			mySoundChannel.soundTransform = myTransform;
			myVolume = 1;
		}
		public function startSong(song:String):void {
			currentSong = null;
			myChannel.stop();
			currentSong = new Song1();
			myChannel = currentSong.play(0,100);
			myTransform.volume = myVolume;
			myChannel.soundTransform = myTransform;
   		}
		public function stopSong():void {
			myChannel.stop();
		}
		public function startSound(song:String):void {
			var r:int = int(Math.random()*3)+1;
			if(song=="bounce") {			
				if(r==1)currentSound = new soundEffect1;
				else if(r==2) currentSound = new soundEffect2();
				else if(r==3) currentSound = new soundEffect3();
			} else if(song=="miss") {
				currentSound = new Miss1();
			} else if(song=="collide") {
				currentSound = new ballHitSound();
			}
			mySoundChannel = currentSound.play();
			mySoundChannel.soundTransform = myTransform;
		}
		public function switchVolume() {
			if(myTransform.volume==0) {
				myVolume = 1;
				myTransform.volume = 1;
				myChannel.soundTransform = myTransform;
				mySoundChannel.soundTransform = myTransform;
			} else {
				myVolume = 0;
				myTransform.volume = 0;
				myChannel.soundTransform = myTransform;
				mySoundChannel.soundTransform = myTransform;
			}
		}
		public function isSoundOn():int {
			return (myVolume==0) ? 2 : 1;
		}
	}
}
