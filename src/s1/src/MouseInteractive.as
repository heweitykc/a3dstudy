package  
{
	import away3d.controllers.HoverController;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author callee
	 */
	public class MouseInteractive 
	{
		private var _hoverController:HoverController;
		private var _light:LightMachine;
		private var _stage:Stage;
		
		public function MouseInteractive(controller:HoverController,light:LightMachine,stage:Stage) 
		{
			_hoverController = controller;
			_stage = stage;
			_light = light;
			init();
		}
		
		private function init():void
		{
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.A)
			{
				_hoverController.panAngle += 5;
			} 
			else 
			if (evt.keyCode == Keyboard.D)
			{
				_hoverController.panAngle -= 5;
			}
			else
			if (evt.keyCode == Keyboard.W)
			{
				_hoverController.tiltAngle -= 5;
			}
			else
			if (evt.keyCode == Keyboard.S)
			{
				_hoverController.tiltAngle += 5;
			}
			else
			if (evt.keyCode == Keyboard.UP)
			{
				_light.x += 5;
			}
			else
			if (evt.keyCode == Keyboard.DOWN)
			{
				_light.x -= 5;
			}
			else
			if (evt.keyCode == Keyboard.LEFT)
			{
				_light.rotationY += 10;
			}
			else
			if (evt.keyCode == Keyboard.RIGHT)
			{
				_light.rotationY -= 10;
			}
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{
			
		}
		
		private function onMouseUp(evt:MouseEvent):void
		{
			
		}
		
		private function onMouseMove(evt:MouseEvent):void
		{
			
		}
	}

}