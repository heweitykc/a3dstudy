package  
{
	import flash.display.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author callee
	 */
	public class test1 extends Sprite 
	{
		private var _arrow:MovieClip;
		public function test1() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);	
			_arrow = new arrow();
			_arrow.x = 300;
			_arrow.y = 300;
			this.addChild(_arrow);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			var angle:Number = Math.atan2(e.localY - _arrow.y, e.localX - _arrow.x);
			_arrow.rotation = angle * 180 / Math.PI;
		}
	}

}