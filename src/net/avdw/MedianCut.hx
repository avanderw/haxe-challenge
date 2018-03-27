package net.avdw;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.BitmapData;
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
		var splitCount:Int = 3;
		var orig = Assets.getBitmapData("img/def611c3-b108-484f-85cc-38d208242101.jpg");
		var origBmp = new Bitmap(orig);

		var origBucket:Array<Color> = new Array();
		for (y in 0...orig.height)
		{
			for (x in 0...orig.width)
			{
				var pixel = Color.fromValue(orig.getPixel(x, y));
				origBucket.push(pixel);
			}
		}

		var idx:Int = 0;
		for (bucket in splitByMedian(origBucket, splitCount))
		{
			var bmd = new BitmapData(32, 32);
			bmd.fillRect(bmd.rect, 0xFF << 24 | ColorBucket.averageColor(bucket).value);
			var bmp = new Bitmap(bmd);
			bmp.x = 520 + 32 * idx;
			addChild(bmp);
			idx++;
		}

		var idx:Int = 0;
		for (bucket in splitByMedian(origBucket, splitCount))
		{
			var bmd = new BitmapData(32, 32);
			bmd.fillRect(bmd.rect, 0xFF << 24 | ColorBucket.averageColor(bucket).value);
			var bmp = new Bitmap(bmd);
			bmp.x = 520 + 32 * idx;
			bmp.y = 32;
			addChild(bmp);
			idx++;
		}

		addChild(origBmp);
	}

	static public function cut(bmd:BitmapData, numCuts:Int):Array<Color>
	{
		var colors:Array<Color> = new Array();
		for (bucket in splitByMedian(ColorBucket.createBucket(bmd), numCuts))
		{
			colors.push(ColorBucket.averageColor(bucket));
		}
		return colors;
	}


	static function splitByMedian(bucket:Array<Color>, count:Int):Array<Array<Color>>
	{
		bucket.sort(ColorBucket.largestRange(bucket).sortFn);
		var buckets:Array<Array<Color>> = new Array();

		if (count > 0)
		{

			var upper:Array<Color> = bucket.slice(Math.floor(bucket.length / 2));
			var lower:Array<Color> = bucket.slice(0, Math.floor(bucket.length / 2));

			count--;
			for (newBucket in splitByMedian(upper, count))
			{
				buckets.push(newBucket);
			}
			for (newBucket in splitByMedian(lower, count))
			{
				buckets.push(newBucket);
			}
		}
		else {
			buckets.push(bucket);
		}

		return buckets;
	}
}
