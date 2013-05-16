package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	/**
	 * ...
	 * @author callee
	 */
	public class LightMachine 
	{
		public var x:int;
		public var y:int;
		public var z:int;
		
		public var rotationY:Number;
		
		private var _light:DirectionalLight;
		private var _cube:Mesh;
		private var _arrow:Mesh;
		private var _container:ObjectContainer3D;
		
		public function LightMachine() 
		{
			_light = new DirectionalLight(0, -1, -1);
			var material:ColorMaterial = new ColorMaterial(0xFFFF00);
			var material2:ColorMaterial = new ColorMaterial(0xFFFFFF);
			_cube = new Mesh(new CubeGeometry(50, 50, 50), material);
			_arrow = new Mesh(new CubeGeometry(20, 20, 20), material2);
			
			_container = new ObjectContainer3D();
			_container.addChild(_cube);
			_container.addChild(_arrow);
			_arrow.y = 25;
			_arrow.z = 25;
			
			rotationY = 0;
		}
		
		public function update():void
		{
			_container.x = x;
			_container.y = y;
			_container.z = z;
			_container.rotationY = rotationY;
			
			_light.x = x;
			_light.y = y;
			_light.z = z;
			_light.rotationY = rotationY;
		}
		
		public function get cube():ObjectContainer3D
		{
			return _container;
		}
		
		public function get light():DirectionalLight
		{
			return _light;
		}
	}

}