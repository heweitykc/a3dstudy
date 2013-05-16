package  
{
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	/**
	 * ...
	 * @author callee
	 */
	public class Map 
	{
		private var _scene:Scene3D;
		private var _floor:Mesh;
		private var _roleList:Vector.<Role>;
		
		public function Map(scene:Scene3D) 
		{
			_scene = scene;
			_roleList = new Vector.<Role>();
		}
		
		public function addRole(role:Role,x:Number,z:Number):void
		{			
			_roleList.push(role);
			role.x = x;
			role.z = z;
			_scene.addChild(role.mesh);
		}
		
		public function render():void
		{
			for each(var role:Role in _roleList)
			{
				role.render();
			}
		}
		
		public function dispose():void
		{
			
		}
	}

}