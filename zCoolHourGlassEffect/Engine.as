package  {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Engine {
	
		private var ROOT:Sprite;
		private var _r:Sprite;
		private var delay:uint;
		private var delayReset:uint;
		private var balls:Array;
		private var recycledBalls:Array;
		private var paddle:Paddle;
		private var ballCollisionHandler:BallCollisionHandler;
		public function Engine(rootMC:Sprite) {
			ROOT = rootMC;
			_r = new Sprite();
			ROOT.addChild(_r);
			delayReset = 60;
			balls = new Array();
			recycledBalls = new Array();
			ballCollisionHandler = new BallCollisionHandler();
			createPaddle();
			setupGame();
		}
		private function setupGame():void {
			delay = delayReset;
			_r.addEventListener(Event.ENTER_FRAME,updateGame);
			addBall();
		}
		private function updateGame(e:Event) {
			updateTimer();
			paddle.updatePaddle();
			updateBalls();
		}
		private function updateTimer():void {
			delay--;
			if(delay==0) {
				delay=delayReset;
				addBall();
			}
		}
		private function updateBalls():void {
			ballCollisionHandler.runCheck(balls);
			var ball:Ball;
			for(var i:int=balls.length-1;i>-1;i--) {
				ball = balls[i];
				ball.updateBall();
				paddle.hitTestBall(ball);
			}
		}
		private function addBall():void {
			balls.push(new Ball(_r));
		}
		private function createPaddle():void {
			paddle = new Paddle(_r);
		}
	}
}
