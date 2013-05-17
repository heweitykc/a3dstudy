package  
{
	import away3d.animators.VertexAnimationSet;
	import away3d.animators.VertexAnimator;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.OutlineMethod;
	import away3d.materials.TextureMaterial;
	import away3d.utils.Cast;
	
	/**
	 * ...
	 * @author callee
	 */
	public class Role 
	{	
		public var id:int;
		public var x:Number;
		public var y:Number=120;
		public var z:Number;
		public var roationY:Number;
		
		private var _mesh:Mesh;
		private var vertexAnimator:VertexAnimator;
		private var material:TextureMaterial;
		private var outline:OutlineMethod;
		
		public function Role(mesh:Mesh,animalSet:VertexAnimationSet) 
		{
			super();
			_mesh = mesh;
			_mesh.scale(5);
			
			vertexAnimator = new VertexAnimator(animalSet);
			_mesh.animator = vertexAnimator;
			_mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
			_mesh.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut);
			outline = new OutlineMethod(0xCCCC00);
			_mesh.mouseEnabled = true;		
			roationY = _mesh.rotationY;
		}
		
		public function onMouseOver(evt:MouseEvent3D):void
		{
			material.addMethod(outline);
		}
		
		public function onMouseOut(evt:MouseEvent3D):void
		{
			material.removeMethod(outline);
		}
		
		public function render():void
		{
			_mesh.x = x;
			_mesh.y = y;
			_mesh.z = z;
			_mesh.rotationY = roationY;
		}
		
		public function get mesh():Mesh
		{
			return _mesh;
		}
		
		public function play(actionName:String):void
		{
			vertexAnimator.play(actionName);
		}
		
		public function initMaterial(picker:StaticLightPicker):void
		{
			material = _mesh.material as TextureMaterial;
			material.specularMap = Cast.bitmapTexture(Assets.OgreSpecular);
			material.normalMap = Cast.bitmapTexture(Assets.OgreNormals);
			material.lightPicker = picker;
			material.gloss = 30;
			material.specular = 1;
			material.ambientColor = 0x303040;
			material.ambient = 1;
			_mesh.material = material;
		}		
	}

}