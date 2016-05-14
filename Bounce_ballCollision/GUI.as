package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	public class GUI extends MovieClip{
		private var bar:LoadBar;
		private var circles:Array;
		private var gameSlideshow:GameSlideshow;
		public function GUI() {
			numberMC.loaderBarMC.mask = numberMC.textMC;
			circles = [circle1,circle2,circle3];
			gameSlideshow = new GameSlideshow(this);
			gameSlideshow.y = 450;
			gameSlideshow.x = 240;
			gameplodeBtn.addEventListener(MouseEvent.CLICK,moreGamesClicked);
		}
		public function setMissed(n:uint) {
			MovieClip(circles[n-1].gotoAndStop(2));
		}
		public function setNumBalls(n:int) {
			numberMC.textMC.numBallsText.text = ""+n;
			bottomText.text = getBottomText(n);
		}
		private function getBottomText(n:int) {
			var t="";
			if(n==0) t = "";
			else if(n==1) t = "The beginning...";
			else if(n==2) t = "One more than One";
			else if(n==3) t = "Whoa... can you handle three?";
			else if(n==4) t = "Easy peasy";
			else if(n==5) t = "Multi-tasker eh?";
			else if(n==6) t = "Less focus here, more focus up there!";
			else if(n==7) t = "Lucky number 7";
			else if(n==8) t = "So you've successfully bounced a couple balls";
			else if(n==9) t = "Big deal... start worrying right... about....";
			else if(n==10) t = "NOW!!!!";
			else if(n==11) t = "Still think you can read this and bounce those eh?";
			else if(n==12) t = "Now's where you start to sweat. Trust me.";
			else if(n==13) t = "Zoinks! Scooby, look what we got here!";
			else if(n==14) t = "The Force is strong with this One.";
			else if(n==15) t = "Only one more ball before you conquer!";
			else if(n==16) t = "Oops... that was a lie.  There's still another one :)";
			else if(n==17) t = "No Pain No Gain";
			else if(n==18) t = "Ahhhhhhh!!!!!";
			else if(n==19) t = "The secret to life is...";
			else if(n==20) t = "not playing this game for hours on end :)";
			else if(n==21) t = "You shall not PASS!!!!";
			else if(n==22) t = "Ok, Gandolf... a little extreme there.";
			else if(n==23) t = "This text has never before been seen.";
			else if(n==24) t = "Except for by the other thousands who've got this far.";
			else if(n==25) t = "A quarter of the way there.  Turn back now.";
			else if(n==26) t = "A Gameplode.com Game | The New Game Portal";
			else if(n==27) t = "Maybe you could get paid for doing this?";
			else if(n==28) t = "Maybe you could get a real job and get paid :)";
			else if(n==29) t = "Okay, you're either a professional or a cheater.";
			else if(n>29) t = "High score territory baby!!!";
			return t;
		}
		private function getInspirationalQuote():String {
			var s:String="";
			var n = int(Math.random()*10);
			if(n==0)s="Never, never, never give up!\n- Winston Churchill";
			else if(n==1)s="Our greatest glory is not in never failing, but in rising up every time we fail.\n- Ralph Waldo Emerson";
			else if(n==2)s="Saints are sinners who kept on going.\n- Robert Louis Stevenson";
			else if(n==3)s="It's not that I'm so smart, it's just that I stay with problems longer.\n- Albert Einstein";
			else if(n==4)s="It does not matter how slowly you go so long as you do not stop.\n- Confucius";
			else if(n==5)s="Perseverance is a great element of success. If you knock long enough and loud enough at the gate, you are sure to wake up somebody.\n- Henry Wadsworth Longfellow";
			else if(n==6)s="Pain is temporary. It may last a minute, or an hour, or a day, or a year, but eventually it will subside and something else will take its place. If I quit, however, it lasts forever.\"\n- Lance Armstrong";
			else if(n==7)s="Obstacles are those frightful things you see when you take your eyes off your goal.- Henry Ford";
			else if(n==8)s="It's not whether you get knocked down; it's whether you get up.\n~ Vince Lombardi";
			else if(n==9)s="Great works are performed not by strength but by perseverance.\n- Samuel Johnson";
			return s;
		}
		public function updateBar(n:int) {
			numberMC.loaderBarMC.loader_in.scaleY = n/120;
		}
		public function cleanupLevel():void {
			numberMC.textMC.numBallsText.text = "";
			bottomText.text = "";
			circle1.gotoAndStop(3);
			circle2.gotoAndStop(3);
			circle3.gotoAndStop(3);
			showScore();
		}
		public function cleanupScore():void {
			gameSlideshow.cleanup();
			circle1.gotoAndStop(1);
			circle2.gotoAndStop(1);
			circle3.gotoAndStop(1);
			scoreGUI.inspirationalText.text = "";
			scoreGUI.maxBallsNumText.text = "";
			scoreGUI.totalBouncesNumText.text = "";
			scoreGUI.playAgainBtn.removeEventListener(MouseEvent.CLICK,playAgainClicked);
			scoreGUI.submitScoreBtn.removeEventListener(MouseEvent.CLICK,submitScoreClicked);
			scoreGUI.moreGamesBtn.removeEventListener(MouseEvent.CLICK,moreGamesClicked);
			scoreGUI.sound_controller.removeEventListener(MouseEvent.CLICK,soundClicked);
			scoreGUI.gotoAndStop(1);
		}
		private function showScore():void {
			
			scoreGUI.gotoAndStop(2);
			scoreGUI.inspirationalText.text = getInspirationalQuote();
			scoreGUI.maxBallsNumText.text = ""+GLOBAL.totalBalls;
			scoreGUI.totalBouncesNumText.text = ""+GLOBAL.bouncedBalls;
			scoreGUI.playAgainBtn.addEventListener(MouseEvent.CLICK,playAgainClicked);
			scoreGUI.submitScoreBtn.addEventListener(MouseEvent.CLICK,submitScoreClicked);
			scoreGUI.moreGamesBtn.addEventListener(MouseEvent.CLICK,moreGamesClicked);
			scoreGUI.sound_controller.addEventListener(MouseEvent.CLICK,soundClicked);
			scoreGUI.sound_controller.gotoAndStop(GLOBAL.music.isSoundOn());
			gameSlideshow.restart();
		}
		public function restart():void {
			
		}
		private function moreGamesClicked(e:MouseEvent) {
			navigateToURL(new URLRequest("http://www.gameplode.com"), "_blank");
		}
		private function playAgainClicked(e:MouseEvent) {
			cleanupScore();
			GLOBAL.engine.playAgain();
		}
		private function submitScoreClicked(e:MouseEvent) {
			import mochi.as3.*;
			var o:Object = { n: [9, 4, 1, 11, 10, 7, 9, 5, 15, 9, 14, 13, 11, 7, 9, 8], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: GLOBAL.bouncedBalls});
			scoreGUI.submitScoreBtn.visible = false;
		}
		private function soundClicked(ev:MouseEvent) {
			scoreGUI.sound_controller.gotoAndStop((scoreGUI.sound_controller.currentFrame)%2+1);
			GLOBAL.music.switchVolume();
		}
		
	}
}
