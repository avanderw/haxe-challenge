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

		var bucket:Array<Color> = new Array();
		for (y in 0...orig.height)
		{
			for (x in 0...orig.width)
			{
				var pixel = Color.fromValue(orig.getPixel(x, y));
				bucket.push(pixel);
			}
		}

		largestRange(bucket);

		addChild(origBmp);
	}

	function largestRange(bucket:Array<Color>):String
	{
		var min = Color.fromRGB(255,255,255);
		var max = Color.fromRGB(0,0,0);

		for (color in bucket)
		{
			min.r = cast Math.min(min.r, color.r);
			min.g = cast Math.min(min.r, color.g);
			min.b = cast Math.min(min.b, color.b);

			max.r = cast Math.max(max.r, color.r);
			max.g = cast Math.max(max.g, color.g);
			max.b = cast Math.max(max.b, color.b);
		}

		var range = Color.subtract(max, min);

		if (range.r > range.g && range.r > range.b)
		{
			return "R";
		}
		else if (range.g > range.r && range.g > range.b)
		{
			return "G";
		}
		else if (range.b > range.r && range.b > range.g)
		{
			return "B";
		}
		return "R";
	}

}