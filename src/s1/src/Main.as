package 
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.*;
	import flash.display3D.textures.Texture;
	import flash.events.*;
	import flash.display3D.*;	
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author lizhi http://game-develop.net/
	 */
	[SWF(width=800,height=600,frameRate=60)]
	public class Main extends Sprite
	{	
		private var stage3d:Stage3D;
		private var c3d:Context3D;

		private var texture:Texture;
		private var bmd:BitmapData;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage3d = stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, stage3Ds_context3dCreate);
			stage3d.requestContext3D();
		}
		
		private function stage3Ds_context3dCreate(e:Event):void 
		{
			c3d = stage3d.context3D;
			c3d.configureBackBuffer(800, 600,0);
			c3d.setDepthTest(true, Context3DCompareMode.LESS);
			
			c3d.clear(0, 0, 0, 1);
			
			
			buildRED();
			buildWHITE();
			buildYELLOW();
			
			c3d.present();
						
			this.addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function buildRED():void
		{	
			var vertices:Vector.<Number> = Vector.<Number>([
				-0.3,-0.3,0, 1, 0, 0, // x, y, z, r, g, b
				-0.3, 0.3, 0, 1, 0, 0,
				0.3, 0.3, 0, 1, 0, 0,
				0.3, -0.3, 0, 1, 0, 0
			]);
			var vertextBuffer:VertexBuffer3D = c3d.createVertexBuffer(vertices.length / 6, 6);
			vertextBuffer.uploadFromVector(vertices, 0, vertices.length / 6);
			c3d.setVertexBufferAt(0, vertextBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 3, 0]);
			var indexBuffer:IndexBuffer3D = c3d.createIndexBuffer(indices.length);
			indexBuffer.uploadFromVector(indices, 0, indices.length);
			c3d.setVertexBufferAt(1, vertextBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + "mov v0, va1"
			);
			fragShaderAssembler.assemble(Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);
			var program:Program3D = c3d.createProgram();
			program.upload(vertexShaderAssembler.agalcode, fragShaderAssembler.agalcode);
			c3d.setProgram(program);
			
			var m:Matrix3D = new Matrix3D();		
			c3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			c3d.drawTriangles(indexBuffer);
		}
		
		private function buildWHITE():void
		{
			var vertices:Vector.<Number> = Vector.<Number>([
				-0.8,-0.8,0, 1, 1, 1, // x, y, z, r, g, b
				-0.8, 0.8, 0, 1, 1, 1,
				0.8, 0.8, 0, 1, 1, 1,
				0.8, -0.8, 0, 1, 1, 1
			]);
			var vertextBuffer:VertexBuffer3D = c3d.createVertexBuffer(vertices.length / 6, 6);
			vertextBuffer.uploadFromVector(vertices, 0, vertices.length / 6);
			c3d.setVertexBufferAt(0, vertextBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 3, 0]);
			var indexBuffer:IndexBuffer3D = c3d.createIndexBuffer(indices.length);
			indexBuffer.uploadFromVector(indices, 0, indices.length);
			c3d.setVertexBufferAt(1, vertextBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + "mov v0, va1"
			);
			fragShaderAssembler.assemble(Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);
			var program:Program3D = c3d.createProgram();
			program.upload(vertexShaderAssembler.agalcode, fragShaderAssembler.agalcode);
			c3d.setProgram(program);
			
			var m:Matrix3D = new Matrix3D();		
			c3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			c3d.drawTriangles(indexBuffer);
			
			//var a:* = new Assets.HEAD();
			//bmd = a.bitmapData;
			//texture = c3d.createTexture(bmd.width, bmd.height, Context3DTextureFormat.BGRA, false);
			//texture.uploadFromBitmapData(bmd);
		}
		
		private function buildYELLOW():void
		{	
			var vertices:Vector.<Number> = Vector.<Number>([
				0.1, 0.1,0, 1, 1, 0, // x, y, z, r, g, b
				0.1, 1.0, 0, 1, 1, 0,
				1.0, 1.0, 0, 1, 1, 0,
				1.0, 0.1, 0, 1, 1, 0
			]);
			var vertextBuffer:VertexBuffer3D = c3d.createVertexBuffer(vertices.length / 6, 6);
			vertextBuffer.uploadFromVector(vertices, 0, vertices.length / 6);
			c3d.setVertexBufferAt(0, vertextBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 3, 0]);
			var indexBuffer:IndexBuffer3D = c3d.createIndexBuffer(indices.length);
			indexBuffer.uploadFromVector(indices, 0, indices.length);
			c3d.setVertexBufferAt(1, vertextBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + "mov v0, va1"
			);
			fragShaderAssembler.assemble(Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);
			var program:Program3D = c3d.createProgram();
			program.upload(vertexShaderAssembler.agalcode, fragShaderAssembler.agalcode);
			c3d.setProgram(program);
			
			var m:Matrix3D = new Matrix3D();		
			c3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			c3d.drawTriangles(indexBuffer);
		}
		
		protected function onRender(evt:Event):void
		{
			
		}
	}
	
}