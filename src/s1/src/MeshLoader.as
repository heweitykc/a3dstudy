package  
{
	import away3d.animators.VertexAnimationSet;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.MD2Parser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
		
	/**
	 * ...
	 * @author callee
	 */
	public class MeshLoader extends EventDispatcher
	{
		private var _mesh:Mesh;
		private var _animationSet:VertexAnimationSet;
		
		public function MeshLoader() 
		{
			
		}
		
		public function load():void
		{
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext();
			assetLoaderContext.mapUrlToData("igdosh.jpg", new (Assets.OgreDiffuse)());			
			AssetLibrary.loadData(new (Assets.OgreModel)(), assetLoaderContext, null, new MD2Parser());
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);			
		}
		
		private function onAssetComplete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.MESH) {
				_mesh = event.asset as Mesh;
				this.dispatchEvent(new Event(Event.COMPLETE));
			} else if (event.asset.assetType == AssetType.ANIMATION_SET) {
				_animationSet = event.asset as VertexAnimationSet;
			}
		}
		
		public function get mesh():Mesh
		{
			return _mesh.clone() as Mesh;
		}
		
		public function get vertexAnimationSet():VertexAnimationSet
		{
			return _animationSet;
		}
	}

}