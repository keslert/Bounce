package  {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	public class Backdrop extends Sprite{
		//private var colorArray:Array = [0x660033,0x003366,0x000000,0x330000,0x000033];
		private var colorArray:Array = [0x000000];
		private var colorCounter:uint;
		private var mod:uint;
		public function Backdrop() {
			colorCounter = 0;
			mod = colorArray.length;
			changeColor();
		}
		public function changeColor() {
			this.graphics.beginFill(colorArray[colorCounter++%mod],1);
			this.graphics.drawRect(0,0,480,640);
			this.graphics.endFill();
		}

	}
	
}
