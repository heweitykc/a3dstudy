package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import away3d.debug.*;
		
	/**
	 * ...
	 * @author callee
	 */
	public class Main extends Sprite 
	{		
		private var _panel:toolpanel;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		private var cameraController:HoverController;
		
		private var light1:DirectionalLight;
		private var light2:DirectionalLight;
		private var lightPicker:StaticLightPicker;
		
		private var cube1:Mesh;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_panel = new toolpanel();
			addChild(_panel);
			_panel.x = 300;
			initEngine();
			initLight();
			initModel();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function initEngine():void
		{
			scene = new Scene3D();
			camera = new Camera3D();
			view = new View3D(scene, camera);
			addChild(view);
			
			cameraController = new HoverController(camera);
			cameraController.distance = 1000;
			cameraController.minTiltAngle = 0;
			cameraController.maxTiltAngle = 90;
			cameraController.panAngle = 45;
			cameraController.tiltAngle = 20;
			
			addChild(new AwayStats(view));
		}
		
		private function initLight():void
		{
			light1 = new DirectionalLight();
			light1.direction = new Vector3D(0, -1, 0);
			light1.ambient = 0.1;
			light1.diffuse = 0.7;
			
			scene.addChild(light1);
			
			light2 = new DirectionalLight();
			light2.direction = new Vector3D(0, -1, 0);
			light2.color = 0x00ffff;
			light2.ambient = 0.2;
			light2.diffuse = 0.7;
			
			scene.addChild(light2);
			
			lightPicker = new StaticLightPicker([light1, light2]);			
		}
		
		private function initModel():void
		{
			var material:ColorMaterial = new ColorMaterial(0xFFFF00);
			material.lightPicker = lightPicker;
			cube1 = new Mesh(new PlaneGeometry(1000,1000), material);
			scene.addChild(cube1);
		}
		
		private function onEnterFrame(event:Event):void
		{
			view.render();
		}
	}
	
}