package  
{
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.utils.Cast;
	import flash.geom.Point;
	/**
	 * ...
	 * @author callee
	 */
	public class Map 
	{
		private var _scene:Scene3D;
		private var _floor:Mesh;
		private var _roleList:Vector.<Role>;
		private var _role:Role;
		private var _targetX:Number;
		private var _targetZ:Number;
		
		private var STEP:Number = 20;
		private var STEPR:Number = 20;
		
		public function Map(scene:Scene3D) 
		{
			_scene = scene;
			_roleList = new Vector.<Role>();
			
			_floor = new Mesh(new PlaneGeometry(1000, 1000), new TextureMaterial(Cast.bitmapTexture(Assets.FloorDiffuse)));
			_scene.addChild(_floor);
			_floor.addEventListener(MouseEvent3D.CLICK, onFloorClick);
			_floor.mouseEnabled = true;
		}
		
		private function onFloorClick(evt:MouseEvent3D):void
		{
			_targetX = evt.localPosition.x;
			_targetZ = evt.localPosition.z;
		}
		
		public function addRole(role:Role,x:Number,z:Number):void
		{			
			_roleList.push(role);
			role.x = x;
			role.z = z;
			_role = role;
			_scene.addChild(role.mesh);
			_targetX = x;
			_targetZ = z;
		}
		
		public function render():void
		{
			for each(var role:Role in _roleList)
			{
				role.render();
			}
			
			var diffx:Number = _targetX - role.x;
			var diffz:Number = _targetZ - role.z;
			if (Math.abs(diffx) <= STEP && Math.abs(diffz) <= STEP)
			{
				role.play("stand");
				return;
			}
			var angle:Number = Math.atan2(diffz, diffx);
			role.x += (STEP * Math.cos(angle));
			role.z += (STEP * Math.sin(angle));
			var target:Number = -angle * 180 / Math.PI;
			var diffr:Number = target - role.roationY;
			if (diffr > (Math.PI / 2)) diffr = diffr - Math.PI;
			else if (diffr < (Math.PI / -2)) diffr = diffr + Math.PI;
			if (Math.abs(diffr) <= STEPR && Math.abs(diffr) <= STEPR)
			{
				role.roationY +=  diffr;
				role.play("run");
				return;
			}
			
			role.roationY +=  (diffr>0 ? STEPR : -STEPR);
			role.play("run");
		}
		
		public function dispose():void
		{
			
		}
	}

}