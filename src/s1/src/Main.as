package 
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.*;
	import flash.events.*;
	import flash.display3D.*;	
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author lizhi http://game-develop.net/
	 */
	public class Main extends Sprite
	{
		private var stage3d:Stage3D;
		private var c3d:Context3D;
		private var vertices:Vector.<Number>;
		private var indices:Vector.<uint>;
		private var vertextBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		private var program:Program3D;
		
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
			buildVertex();
		}
		
		private function buildVertex():void
		{
			vertices = Vector.<Number>([
				-0.3,-0.3,0, 1, 0, 0, // x, y, z, r, g, b
				-0.3, 0.3, 0, 0, 1, 0,
				0.3, 0.3, 0, 0, 0, 1,
				0.3, -0.3, 0, 1, 0, 0
			]);
			vertextBuffer = c3d.createVertexBuffer(vertices.length / 6, 6);
			vertextBuffer.uploadFromVector(vertices, 0, vertices.length / 6);
			
			indices = Vector.<uint>([0, 1, 2]);
			indexBuffer = c3d.createIndexBuffer(indices.length);
			indexBuffer.uploadFromVector(indices, 0, 3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + "mov v0, va1"
			);
			fragShaderAssembler.assemble(Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);
			program = c3d.createProgram();
			program.upload(vertexShaderAssembler.agalcode, fragShaderAssembler.agalcode);
			
			this.addEventListener(Event.ENTER_FRAME, onRender);			
		}
		
		protected function onRender(evt:Event):void
		{
			c3d.clear(0, 0, 0, 1);
			c3d.setVertexBufferAt(0, vertextBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			c3d.setVertexBufferAt(1, vertextBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			c3d.setProgram(program);
			var m:Matrix3D = new Matrix3D();		
			c3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			c3d.drawTriangles(indexBuffer);
			c3d.present();
		}
	}
	
}