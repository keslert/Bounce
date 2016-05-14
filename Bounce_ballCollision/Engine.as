package  {
	import mochi.as3.*
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class Engine {
	
		private var ROOT:Sprite;
		private var _r:Sprite;
		private var delay:uint;
		private var delayReset:uint;
		private var ball:Ball;
		private var balls:Array;
		private var recycledBalls:Array;
		private var paddle:Paddle;
		private var ballCollisionHandler:BallCollisionHandler;
		private var paddleCollisionHandler:PaddleCollisionHandler;
		private var missed:int;
		private var totalBalls:int;

		public function Engine(rootMC:Sprite) {
			GLOBAL.engine = this;
			ROOT = rootMC;
			GLOBAL.backdrop = new Backdrop();
			ROOT.addChild(GLOBAL.backdrop);
			_r = new Sprite();
			ROOT.addChild(_r);
			delayReset = 120;
			balls = new Array();
			recycledBalls = new Array();
			ballCollisionHandler = new BallCollisionHandler();
			paddleCollisionHandler = new PaddleCollisionHandler();
			GLOBAL.music = new Music();
			setupMusic();
		}
		public function primaryGameSetup():void {
			setupGUI();
			createPaddle();
			setupGame();
		}
		private function setupGame():void {
			delay = delayReset;
			_r.addEventListener(Event.ENTER_FRAME,updateGame);
			totalBalls=0;
			GLOBAL.bouncedBalls=0;
			missed = 0;
			Mouse.hide();
			addBall();
			MochiEvents.startPlay(); //mochi
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
			GLOBAL.gui.updateBar(delayReset-delay);
		}
		private function updateBalls():void {
			ballCollisionHandler.runCheckBalls(balls);
			for(var i:int=balls.length-1;i>-1;i--) {
				ball = balls[i];
				ball.updateBall();
				if(ball.offScreen()) {
					balls.splice(i,1);
					ballMissed(ball);
					i=-1;
				}
				paddleCollisionHandler.runCheck(ball,paddle);
			}
			
		}
		private function addBall():void {
			if(recycledBalls.length > 0) {
				ball = recycledBalls.pop();
				ball.recycleBall();
				balls.push(ball);
			} else {
				balls.push(new Ball(_r));
			}
			var n = balls.length
			if(n > GLOBAL.totalBalls) GLOBAL.totalBalls = n;
			GLOBAL.gui.setNumBalls(n);
		}
		private function ballMissed(ball:Ball) {
			ball.cleanup();
			recycledBalls.push(ball);
			missed++;
			GLOBAL.gui.setNumBalls(balls.length);
			GLOBAL.gui.setMissed(missed);
			if(missed > 2) {
				gameOver();
			}
			GLOBAL.music.startSound("miss");
		}
		private function createPaddle():void {
			paddle = new Paddle(_r);
		}
		private function setupGUI():void {
			GLOBAL.gui = new GUI();
			_r.addChild(GLOBAL.gui);
		}
		private function gameOver():void {
			_r.removeEventListener(Event.ENTER_FRAME,updateGame);
			cleanup();
		}
		private function cleanup():void {
			cleanupBalls();
			paddle.cleanup();
			GLOBAL.gui.cleanupLevel();
			Mouse.show();
			MochiEvents.endPlay();//Mochi
		}
		private function cleanupBalls():void {
			while(balls.length > 0) {
				ball = balls.pop();
				ball.cleanup();
				recycledBalls.push(ball);
			}
		}
		private function setupMusic() {
			GLOBAL.music.startSong("song1");
		}
		public function playAgain():void {
			setupGame();
		}
	}
}
