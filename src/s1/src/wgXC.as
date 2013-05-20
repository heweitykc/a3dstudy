/**
 * Copyright lizhi ( http://wonderfl.net/user/lizhi )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/wgXC
 */

package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import net.hires.debug.Stats;
	/**
	 * ...
	 * @author lizhi https://twitter.com/lizhi525
	 */
	[SWF(width=800,height=600,frameRate=60)]
	
	public class GameOfLifeAS3 extends Sprite
	{
		private var length:int;
		private var dir:Vector.<int>;
		private var dir2:Vector.<int>;
		private var universe_current:Vector.<uint>;
		private var universe_future:Vector.<uint>;
		private var vs:Vector.<uint>;
		private var bmd:BitmapData;
		private var xd:int;
		private var yd:int;
		
		public function GameOfLifeAS3()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			xd = Math.min(800,stage.stageWidth) / 3;
			yd = Math.min(600,stage.stageHeight) / 3;
			length = xd * yd;
			dir = Vector.<int>([-1, 1, xd, -xd, xd + 1, xd - 1, -xd + 1, -xd - 1]);
			dir2 = Vector.<int>([0, 1, xd * 3, xd * 3 + 1]);
			bmd = new BitmapData(xd * 3, yd * 3, false, 0);
			stage.quality = StageQuality.LOW;
			addChild(new Bitmap(bmd));
			universe_current = new Vector.<uint>(length);
			for (var i:int = 0; i < length; i++)
			{
				universe_current[i] = Math.random() < .5 ? 0 : 0xffffff;
			}
			universe_future = new Vector.<uint>(length);
			vs = new Vector.<uint>(length * 9);
			for (i = 0; i < vs.length; i++)
			{
				vs[i] = 0xffffff;
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			var stats:Stats = new Stats;
			addChild(stats);
		}
		
		private function enterFrame(e:Event):void
		{
			for (var i:int = 0; i < length; i++)
			{
				var livecount:int = 0;
				for (var j:int = 0; j < 8; j++)
				{
					var index:int = i + dir[j];
					if (index >= 0 && index < length && universe_current[index] == 0)
						livecount++;
				}
				if (universe_current[i] == 0)
				{
					if (livecount != 2 && livecount != 3)
						universe_future[i] = 0xffffff;
					else
						universe_future[i] = 0;
				}
				else
				{
					if (livecount == 3)
						universe_future[i] = 0;
					else
						universe_future[i] = 0xffffff;
				}
				var i2:int = (int(i / xd) * 3 * xd + (i % xd)) * 3
				for (j = 0; j < 4; j++)
				{
					vs[i2 + dir2[j]] = universe_current[i];
				}
			}
			bmd.lock();
			bmd.setVector(bmd.rect, vs);
			bmd.unlock();
			var tmp:Vector.<uint> = universe_current;
			universe_current = universe_future;
			universe_future = tmp;
		}
	
	}

}