package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.geom.Point;

	public class Ball extends Sprite{
		
		public var _mc:Sprite;
		public var _p:Sprite;
		public var radius:uint;
		private var radiusSquared:uint;
		public var m:uint;
		public var vx:Number;
		public var vy:Number;
		private var gravity:Number;
		private var color:int;
		private var stageW:uint;
		
		public var p0:Point;
		public var p1:Point;
		public var len:Number;
		public var dx:Number;
		public var dy:Number;
		public var rx:Number;
		public var ry:Number;
		public var lx:Number;
		public var ly:Number;

		public function Ball(p:Sprite) {
			_p=p;
			_p.addChild(this);
			stageW = GLOBAL.stageW;
			p0 = new Point(0,0);
			p1 = new Point(0,0);
			calcProperties();
			drawBall();
		}
		private function calcProperties() {
			//radius = uint(Math.random()*10)+10;
			radius = 15;
			radiusSquared = radius*radius;
			m = 1;
			color = int("0x000000");
			gravity = GLOBAL.gravity;
			x = 250;
			y = 0;
			p0.x=x;
			p0.y=y;
			p1.x=x;
			p1.y=y;
			vy=gravity;
			vx=0;
		}
		private function drawBall():void {
			this.graphics.lineStyle(3,color,1);
			this.graphics.drawCircle(0,0,radius);
			this.cacheAsBitmap=true;
		}
		public function updateBall():void {
			vy+=gravity;
			//x+=vx;
			//y+=vy;
		}  
		public function updateLoc(x,y) {
			this.x=x;
			this.y=y;
		}
		public function getRadius():uint {
			return radius;
		}
		public function getRadiusSquared():uint {
			return radiusSquared;
		}
		public function bounce(vy:Number) {
			this.vy = vy;
		}
		public function hitTestAgainst(ball:Ball):void {
			if(ball!=this) {
				
			}
		}
		
	}
}
