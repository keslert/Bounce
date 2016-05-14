package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	public class Paddle extends Sprite{
		private var myHeight:int;
		private var myWidth:int;
		
		public var p0:Point;
		public var p1:Point;
		public var vx:Number;
		public var vy:Number;
		private var curve:Number;
		private var _r:Sprite;
		public var oldColor:int;
		public var color:int;
		private var maxV:int;
		public function Paddle(_r:Sprite) {
			trace(int("0x000000"));
			trace(int("0xFFFFFF")/2);
			this._r = _r;
			this._r.addChild(this);
			myHeight=10;
			myWidth=140;
			this.x = 240;
			this.y = 500;
			p0 = new Point(x,y);
			p1 = new Point(x,y);
			color = int("0xFF0000");
			oldColor = color;
			maxV = 20;
			drawPaddle();
		}
		public function updatePaddle():void {
			var y1 = _r.mouseY;
			//var newY = (y1 < 200) ? 200 : y1;
			vy = -int((this.y-y1)/5);
			vx = -int((this.x-_r.mouseX)/5);
			if(vy > maxV) vy = maxV;
			if(vy < -maxV) vy = -maxV;
			if(vx > maxV) vx = maxV;
			if(vx < -maxV) vx = -maxV;
			this.x += vx;
			this.y += vy;
			p0.x = this.x-myWidth;
			p0.y = this.y-vx*1.5;
			p1.x = this.x+myWidth;
			p1.y = this.y+vx*1.5;
			curve = vy*2;
			//this.rotation = calcRot(vx,vy);
			//checkColors();
			drawPaddle();
		}
		private function calcRot(dx:Number,dy:Number):Number {
			//var angle:Number = Math.atan2(dy,dx)*57.3+90;
			return dx;
			//return angle;
			
		}
		private function drawPaddle():void {
			this.graphics.clear();
			this.graphics.lineStyle(8,color,1);
			this.graphics.moveTo(-myWidth,-vx*1.5);
			//this.graphics.lineTo(myWidth,0);
			this.graphics.curveTo(0,curve,myWidth,vx*1.5);
		}
		private function checkColors():void {
			if(oldColor!= color) {
				oldColor = color;
				GLOBAL.backdrop.changeColor();
			}
		}
		public function cleanup():void {
			this.graphics.clear();
		}
	}
}
