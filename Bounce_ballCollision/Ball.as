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
		public var color:int;
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
		public var f:Number;
		public var b:Number;
		public function Ball(p:Sprite) {
			_p=p;
			_p.addChild(this);
			stageW = GLOBAL.stageW;
			p0 = new Point(0,0);
			p1 = new Point(0,0);
			calcProperties();
			drawBall();
		}
		public function recycleBall():Ball {
			calcProperties();
			drawBall();
			return this;
		}
		private function calcProperties() {
			radius = uint(Math.random()*10)+20;
			//radius = 15;
			radiusSquared = radius*radius;
			m = 1;
			f = 1;
			b = 1.75;
			
			color = Math.random()*2*8388607;
			gravity = GLOBAL.gravity;
			x = 250;
			y = 0;
			p0.x=x;
			p0.y=y;
			p1.x=x;
			p1.y=y;
			vy=gravity;
			vx=Math.random()*3;
		}
		private function drawBall():void {
			this.graphics.lineStyle(6,color,1);
			//this.graphics.beginFill(color,1);
			this.graphics.drawCircle(0,0,radius);
			//this.graphics.endFill();
			this.cacheAsBitmap=true;
		}
		public function updateBall():void {
			vy+=gravity;
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
		public function offScreen():Boolean {
			if(this.y-radius > 650) return true;
			return false;
		}
		public function cleanup():void {
			this.graphics.clear();
		}
	}
}
