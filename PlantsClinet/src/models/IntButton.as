package models
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	
	public class IntButton extends Sprite {
		
		private var button:Sprite = new Sprite();
		private var label:String = "Button";
		
		public function IntButton(label:String) {
			this.label = label;
			drawButton()
			addChild(button);
		}
		
		private function drawButton():void {
			var textLabel:TextField = new TextField()
			button.graphics.clear();
			button.graphics.beginFill(0xD4D4D4); // grey color
			button.graphics.drawRoundRect(0, 0, 80, 25, 10, 10); // x, y, width, height, ellipseW, ellipseH
			button.graphics.endFill();
			textLabel.text = this.label;
			textLabel.x = 10;
			textLabel.y = 5;
			textLabel.selectable = false;
			button.addChild(textLabel)
		}
	}

}