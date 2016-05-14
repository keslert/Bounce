package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.text.*;
	
	public class Circles extends Sprite {
		private var number:int;
		private var spacing:int=20;
		private var radius:int=8;
		private var t:TextField;
		private var _r:Sprite;
		public function Circles (_r:Sprite) {
			this._r = _r;
			this._r.addChild(this);
			this.cacheAsBitmap;
			number = 3;
			//createCircles();
			//createText();
		}
		private function createCircles():void {
			for(var i:int=0;i<number;i++) {
				drawCircle(i,0xFFFFFF);
			}
		}
		private function drawCircle(pos:int,color:int) {
			this.graphics.lineStyle(2,color,1);
			this.graphics.drawCircle(pos*spacing,0,radius);
		}
		private function createText():void {
			t = new TextField();
            t.defaultTextFormat = new TextFormat("Font1",15,0);
            t.text = "Lives";
			t.textColor = 0xFFFFFF;
            t.autoSize = TextFieldAutoSize.LEFT;
            t.selectable = false;
			t.x = -radius;
			t.y = radius;
            this.addChild(t);
		}
		public function addCircle():void {
			drawCircle(number,0xFFFFFF);
			number++;
		}
		public function removeCircle():void {
			number--;
			drawCircle(number,0x000000);
		}
		public function reset(lives:int):void {
			number = lives;
			createCircles();
			trace("HERE23");
		}
	}
}
