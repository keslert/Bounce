package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	public class StartMenu extends MovieClip{
		private var _r:Sprite;
		public function StartMenu(_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			startGameBtn.addEventListener(MouseEvent.CLICK,startGameClicked);
			highScoresBtn.addEventListener(MouseEvent.CLICK,highScoresClicked);
			moreGamesBtn.addEventListener(MouseEvent.CLICK,moreGamesClicked);
			gameplodeBtn.addEventListener(MouseEvent.CLICK,moreGamesClicked);
			
			startGameBtn.addEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			highScoresBtn.addEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			moreGamesBtn.addEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			
		}
		private function startGameClicked(e:MouseEvent):void {
			GLOBAL.engine.primaryGameSetup();
			cleanup();
		}
		private function highScoresClicked(e:MouseEvent) {
			import mochi.as3.*;
			var o:Object = { n: [9, 4, 1, 11, 10, 7, 9, 5, 15, 9, 14, 13, 11, 7, 9, 8], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID});
		}
		private function moreGamesClicked(e:MouseEvent): void {
			navigateToURL(new URLRequest("http://www.gameplode.com/"), "_blank");
		}
		private function cleanup():void {
			startGameBtn.removeEventListener(MouseEvent.CLICK,startGameClicked);
			highScoresBtn.removeEventListener(MouseEvent.CLICK,highScoresClicked);
			moreGamesBtn.removeEventListener(MouseEvent.CLICK,moreGamesClicked);
			gameplodeBtn.removeEventListener(MouseEvent.CLICK,moreGamesClicked);
			
			startGameBtn.removeEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			highScoresBtn.removeEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			moreGamesBtn.removeEventListener(MouseEvent.MOUSE_OVER,playRollOver);
			_r.removeChild(this);
		}
		private function playRollOver(e:MouseEvent):void {
			GLOBAL.music.startSound("collide");
		}
	}
}
