package  
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.materials.lightpickers.StaticLightPicker;
	import flash.display.*;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author callee
	 */
	public class MainGame extends Sprite 
	{	
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		private var _view:View3D;
		private var _cameraController:HoverController;
		
		private var _meshLoader:MeshLoader;
		private var _map:Map;
		private var _interactive:MouseInteractive;
		
		private var _light:LightMachine;
		private var _picker:StaticLightPicker;

		public function MainGame() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initEngine();
			initAssets();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function initEngine():void
		{
			_scene = new Scene3D();
			_camera = new Camera3D();
			_view = new View3D(_scene, _camera);
			addChild(_view);
			
			_cameraController = new HoverController(_camera);
			_cameraController.distance = 1000;
			_cameraController.minTiltAngle = 0;
			_cameraController.maxTiltAngle = 90;
			_cameraController.panAngle = 45;
			_cameraController.tiltAngle = 20;
			
			_light = new LightMachine();
			_interactive = new MouseInteractive(_cameraController,_light, stage);			
		}
		
		public function initAssets():void
		{
			_meshLoader = new MeshLoader();
			_meshLoader.addEventListener(Event.COMPLETE, onAssetComplete);
			_meshLoader.load();
		}
		
		private function onAssetComplete(evt:Event):void
		{
			_meshLoader.removeEventListener(Event.COMPLETE, onAssetComplete);
			initMap();
		}
		
		public function initMap():void
		{
			_picker = new StaticLightPicker([_light.light]);
			_scene.addChild(_light.cube);
			
			_map = new Map(_scene);
			var role1:Role = new Role(_meshLoader.mesh,_meshLoader.vertexAnimationSet);
			_map.addRole(role1, 0, 0);
			role1.play("jump");
			role1.initMaterial(_picker);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_view.render();
			_cameraController.update();
			_light.update();
		}
	}

}