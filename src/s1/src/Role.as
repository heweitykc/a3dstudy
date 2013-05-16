package  
{
	import away3d.animators.VertexAnimationSet;
	import away3d.animators.VertexAnimator;
	import away3d.entities.Mesh;
	import away3d.materials.lightpickers.StaticLightPicker;
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
		public var z:Number;
		
		private var _mesh:Mesh;
		private var vertexAnimator:VertexAnimator;
		private var material:TextureMaterial;
		
		public function Role(mesh:Mesh,animalSet:VertexAnimationSet) 
		{
			super();
			_mesh = mesh;
			_mesh.scale(10);
			
			vertexAnimator = new VertexAnimator(animalSet);
			_mesh.animator = vertexAnimator;			
		}
		
		public function render():void
		{
			_mesh.x = x;
			_mesh.z = z;
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
			
			_mesh.material = material;
		}
		
		/*
		private function onAssetComplete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.MESH) {
				_mesh = event.asset as Mesh;
				
				//adjust the ogre material
				var material:TextureMaterial = _mesh.material as TextureMaterial;
				//material.specularMap = Cast.bitmapTexture(OgreSpecular);
				//material.normalMap = Cast.bitmapTexture(OgreNormals);
				//material.lightPicker = lightPicker;
				material.gloss = 30;
				material.specular = 1;
				material.ambientColor = 0x303040;
				material.ambient = 1;
				material.shadowMethod = _shadowMapMethod;
				
				_mesh.scale(5);
				_mesh.mouseEnabled = true;
				
				//create 16 different clones of the ogre
				var numWide:Number = 4;
				var numDeep:Number = 4;
				var k:uint = 0;
				
				for (var i:uint = 0; i < numWide; i++) {
					for (var j:uint = 0; j < numDeep; j++) {
						//clone mesh
						var clone:Mesh = _mesh.clone() as Mesh;
						clone.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
						clone.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut);
						clone.x = (i-(numWide-1)/2)*1000/numWide;
						clone.z = (j-(numDeep-1)/2)*1000/numDeep;
						clone.castsShadows = true;
						
						view.scene.addChild(clone);
						
						//create animator
						var vertexAnimator:VertexAnimator = new VertexAnimator(_animationSet);
						
						//play specified state
						vertexAnimator.play("attack");
						clone.animator = vertexAnimator;
						k++;
					}
				}
			} else if (event.asset.assetType == AssetType.ANIMATION_SET) {
				_animationSet = event.asset as VertexAnimationSet;
			}
		}
		*/
	}

}