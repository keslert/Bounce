package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class Paddle extends Sprite{
		private var myHeight:int;
		private var myWidth:int;
		private var vx:Number;
		private var vy:Number;
		private var curve:Number;
		private var _r:Sprite;
		public function Paddle(_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			myHeight=10;
			myWidth=75;
			this.x = 240;
			this.y = 500;
			drawPaddle();
		}
		public function updatePaddle():void {
			vy = -int((this.y-_r.mouseY)/5);
			vx = -int((this.x-_r.mouseX)/5);
			this.x += vx;
			this.y += vy;
			curve = vy*2;
			this.rotation = calcRot(vx,vy);
			drawPaddle();
		}
		private function calcRot(dx:Number,dy:Number):Number {
			//var angle:Number = Math.atan2(dy,dx)*57.3+90;
			return dx;
			//return angle;
			
		}
		private function drawPaddle():void {
			this.graphics.clear();
			this.graphics.lineStyle(8,0x000000,1);
			this.graphics.moveTo(-myWidth,0);
			//this.graphics.lineTo(myWidth,0);
			this.graphics.curveTo(0,curve,myWidth,0);
		}
		public function hitTestBall(ball:Ball) {
			var yDist = y-ball.y;
			if(yDist < ball.getRadius() && yDist > 0) {
				var xDist = x-ball.x;
				xDist = xDist*xDist;
				if(xDist < ball.getRadiusSquared()) {
					ball.bounce(vy);
				}
			}
		}
	}
}
