package net.avdw;

import openfl.display.Bitmap;
import flash.display.Sprite;
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

		var posX:Int = 520;
		var buckets = splitBucket(origBucket, 3);
		for (bucket in buckets) {
			var average = Color.fromRGB(0, 0, 0);
			
			for (color in bucket) {
				average.r += color.r;
				average.g += color.g;
				average.b += color.b;
			}
			
			average.r = Math.round(average.r / bucket.length);
			average.g = Math.round(average.g / bucket.length);
			average.b = Math.round(average.b / bucket.length);
			average.refreshValue();
			
			var bmd = new BitmapData(32, 32);
			bmd.fillRect(bmd.rect, 0xFF << 24 | average.value);
			var bmp = new Bitmap(bmd);
			bmp.x = posX;
			addChild(bmp);
			posX += 32;
		}

		addChild(origBmp);
	}

	function splitBucket(bucket:Array<Color>, count:Int):Array<Array<Color>>
	{
		bucket.sort(largestRange(bucket));
		var buckets:Array<Array<Color>> = new Array();

		if (count > 0)
		{
			
			var upper:Array<Color> = bucket.slice(Math.floor(bucket.length / 2));
			var lower:Array<Color> = bucket.slice(0, Math.floor(bucket.length / 2));
			
			count--;
			for (newBucket in splitBucket(upper, count)) {
				buckets.push(newBucket);
			}
			for (newBucket in splitBucket(lower, count)) {
				buckets.push(newBucket);
			}
		}
		else {
			buckets.push(bucket);
		}

		return buckets;
	}

	function largestRange(bucket:Array<Color>):Color->Color->Int
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

		if (range.b > range.r && range.b > range.g)
		{
			return function(a:Color, b:Color):Int {return a.b - b.b; };
		}
		else if (range.g > range.r && range.g > range.b)
		{
			return function(a:Color, b:Color):Int {return a.g - b.g; };
		}
		else
		{
			return function(a:Color, b:Color):Int { return a.r - b.r; };
		}

	}

}