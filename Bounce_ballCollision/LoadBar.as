package  {
	import flash.display.Sprite;
	public class LoadBar {
		private var mc1:Sprite;
		private var mc2:Sprite;
		private var WIDTH=200;
		private var HEIGHT=4;
		private var maxCount=120;
		public function LoadBar(_r:Sprite) {
			mc1 = new Sprite();
			mc2 = new Sprite();
			_r.addChild(mc1);
			_r.addChild(mc2);
			createBar(HEIGHT,WIDTH);
		}
		private function createBar(l:int,h:int):void {
			mc1.x = mc2.x = -l/2;
			mc1.y = mc2.y = h/2;
			drawLine(mc1,1,0xFFFFFF);
		}
		public function updateBar(i:int) {
			drawLine(mc2,i/maxCount,0xAAAAAA);
		}
		private function drawLine(clip:Sprite,perc:Number,color:int) {
			clip.graphics.clear();
			clip.graphics.beginFill(color,1);
			clip.graphics.drawRect(0,0,WIDTH*perc,HEIGHT);
			clip.graphics.endFill();
		}
	}
}
