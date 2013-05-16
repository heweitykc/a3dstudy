package  
{
	import away3d.lights.DirectionalLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	/**
	 * ...
	 * @author callee
	 */
	public class LightController 
	{
		private var _picker:StaticLightPicker;
		
		public function LightController() 
		{
			
		}
		
		public function addLight():void
		{
			var light:DirectionalLight = new DirectionalLight(0, -1, -1);
			_picker = new StaticLightPicker([light]);
		}
		
	}

}