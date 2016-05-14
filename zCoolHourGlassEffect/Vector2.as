package  {
	import flash.geom.Point;
	
	public class Vector2 {
		
		public var p0:Point;
		public var p1:Point;
		public var vx:Number;
		public var vy:Number;
		public var dx:Number;
		public var dy:Number;
		public var rx:Number;
		public var ry:Number;
		public var lx:Number;
		public var ly:Number;
		public var len:Number;
		public var radius:Number;
		public function Vector2() {
			p0 = new Point(0,0);
			p1 = new Point(0,0);
			radius = 0;
		}
	}
}
