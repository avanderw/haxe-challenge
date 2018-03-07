package net.avdw;

import openfl.display.Bitmap;
import flash.display.Sprite;
import openfl.utils.Assets;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class MedianCut extends Sprite
{

	public function new()
	{
		super();
		var orig = Assets.getBitmapData("img/def611c3-b108-484f-85cc-38d208242101.jpg");
		var origBmp = new Bitmap(orig);

		var min = Color.fromRGB(255,255,255);
		var max = Color.fromRGB(0,0,0);
		for (y in 0...orig.height)
		{
			for (x in 0...orig.width)
			{
				var pixel = Color.fromValue(orig.getPixel(x, y));
				
				min.r = cast Math.min(min.r, pixel.r);
				min.g = cast Math.min(min.r, pixel.g);
				min.b = cast Math.min(min.b, pixel.b);
				
				max.r = cast Math.max(max.r, pixel.r);
				max.g = cast Math.max(max.g, pixel.g);
				max.b = cast Math.max(max.b, pixel.b);
			}
		}
		
		var range = Color.subtract(max, min);
		
		addChild(origBmp);
	}

}