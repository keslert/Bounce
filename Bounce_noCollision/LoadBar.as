package  {
	import flash.display.Sprite;
	public class LoadBar extends Sprite{
		private var mc1:Sprite;
		private var mc2:Sprite;
		private var WIDTH=100;
		private var HEIGHT=4;
		private var maxCount=50;
		private var _r:Sprite;
		public function LoadBar (_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			this.x = 240-WIDTH/2;
			this.y = 390;
			mc1 = new Sprite();
			mc2 = new Sprite();
			this.addChild(mc1);
			this.addChild(mc2);
			createBar(HEIGHT,WIDTH);
		}
		private function createBar(l:int,h:int):void {
			mc1.x = mc2.x = -l/2;
			mc1.y = mc2.y = h/2;
			drawLine(mc1,1,0xFFFFFF);
		}
		public function updateBar(i:int) {
			trace("HERE");
			drawLine(mc2,i/maxCount,0xAAAAAA);
		}
		private function drawLine(clip:Sprite,perc:Number,color:int) {
			clip.graphics.clear();
			clip.graphics.beginFill(color,1);
			clip.graphics.drawRect(0,0,WIDTH*perc,HEIGHT);
			clip.graphics.endFill();
		}
		public function cleanup():void {
			mc1.graphics.clear();
			mc2.graphics.clear();
		}
	}
}
