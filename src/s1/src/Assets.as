package  
{
	/**
	 * ...
	 * @author callee
	 */
	public class Assets 
	{
		//ogre diffuse texture
		[Embed(source="../assets/ogre/ogre_diffuse.jpg")]
		public static var OgreDiffuse:Class;
		
		//ogre normal map texture
		[Embed(source="../assets/ogre/ogre_normals.png")]
		public static var OgreNormals:Class;
		
		//ogre specular map texture
		[Embed(source="../assets/ogre/ogre_specular.jpg")]
		public static var OgreSpecular:Class;
		
		//solider ant model
		[Embed(source="../assets/ogre/ogre.md2",mimeType="application/octet-stream")]
		public static var OgreModel:Class;
		
		[Embed(source="../assets/floor_diffuse.jpg")]
		public static var FloorDiffuse:Class;
		
		[Embed(source="../assets/floor_normal.jpg")]
		public static var FloorNormal:Class;
		
		[Embed(source="../assets/floor_specular.jpg")]
		public static var FloorSpecular:Class;	
		
	}

}