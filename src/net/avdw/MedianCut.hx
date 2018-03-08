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
			bmd.fillRect(bmd.rect, 0xFF << 24 | averageColor(bucket).value);
			var bmp = new Bitmap(bmd);
			bmp.x = 520 + 32 * idx;
			addChild(bmp);
			idx++;
		}
		
		var idx:Int = 0;
		for (bucket in splitByMean(origBucket, splitCount))
		{
			var bmd = new BitmapData(32, 32);
			bmd.fillRect(bmd.rect, 0xFF << 24 | averageColor(bucket).value);
			var bmp = new Bitmap(bmd);
			bmp.x = 520 + 32 * idx;
			bmp.y = 32;
			addChild(bmp);
			idx++;
		}

		addChild(origBmp);
	}

	function averageColor(bucket:Array<Color>):Color
	{
		var average = Color.fromRGB(0, 0, 0);

		for (color in bucket)
		{
			average.r += color.r;
			average.g += color.g;
			average.b += color.b;
		}

		average.r = Math.round(average.r / bucket.length);
		average.g = Math.round(average.g / bucket.length);
		average.b = Math.round(average.b / bucket.length);
		average.refreshValue();

		return average;
	}

	function splitByMedian(bucket:Array<Color>, count:Int):Array<Array<Color>>
	{
		bucket.sort(largestRange(bucket).sortFn);
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

	function splitByMean(bucket:Array<Color>, count:Int):Array<Array<Color>>
	{
		var largestRange = largestRange(bucket);
		bucket.sort(largestRange.sortFn);

		var buckets:Array<Array<Color>> = new Array();
		if (count > 0)
		{
			var upper:Array<Color> = bucket.filter(largestRange.upperFilterFn);
			var lower:Array<Color> = bucket.filter(largestRange.lowerFilterFn);

			count--;
			for (newBucket in splitByMean(upper, count))
			{
				buckets.push(newBucket);
			}
			for (newBucket in splitByMean(lower, count))
			{
				buckets.push(newBucket);
			}
		}
		else {
			buckets.push(bucket);
		}

		return buckets;
	}

	function largestRange(bucket:Array<Color>):RangeSort
	{
		var min = Color.fromRGB(255,255,255);
		var max = Color.fromRGB(0, 0, 0);
		var mean = Color.fromRGB(0, 0, 0);

		for (color in bucket)
		{
			min.r = cast Math.min(min.r, color.r);
			min.g = cast Math.min(min.r, color.g);
			min.b = cast Math.min(min.b, color.b);

			max.r = cast Math.max(max.r, color.r);
			max.g = cast Math.max(max.g, color.g);
			max.b = cast Math.max(max.b, color.b);

			mean.r += color.r;
			mean.g += color.g;
			mean.b += color.b;
		}

		mean.r = Math.round(mean.r / bucket.length);
		mean.g = Math.round(mean.g / bucket.length);
		mean.b = Math.round(mean.b / bucket.length);

		var range = Color.subtract(max, min);
		if (range.b > range.r && range.b > range.g)
		{
			var sortFn = function(a:Color, b:Color):Int {return a.b - b.b; };
			var upperFilterFn = function(c:Color) { return c.b >= mean.b; };
			var lowerFilterFn = function(c:Color) { return c.b < mean.b; };
			return new RangeSort("B", sortFn, upperFilterFn, lowerFilterFn);
		}
		else if (range.g > range.r && range.g > range.b)
		{
			var sortFn = function(a:Color, b:Color):Int {return a.g - b.g; };
			var upperFilterFn = function(c:Color) { return c.g >= mean.g; };
			var lowerFilterFn = function(c:Color) { return c.g < mean.g; };
			return new RangeSort("G", sortFn, upperFilterFn, lowerFilterFn);
		}
		else
		{
			var sortFn = function(a:Color, b:Color):Int { return a.r - b.r; };
			var upperFilterFn = function(c:Color) { return c.r >= mean.r; };
			var lowerFilterFn = function(c:Color) { return c.r < mean.r; };
			return new RangeSort("R", sortFn, upperFilterFn, lowerFilterFn);
		}

	}

}

class RangeSort
{
	public var id:String;
	public var sortFn:Color->Color->Int;
	public var upperFilterFn:Color->Bool;
	public var lowerFilterFn:Color->Bool;

	public function new(id:String, sortFn:Color->Color->Int, upperFilterFn:Color->Bool, lowerFilterFn:Color->Bool)
	{
		this.id = id;
		this.sortFn = sortFn;
		this.upperFilterFn = upperFilterFn;
		this.lowerFilterFn = lowerFilterFn;
	}
}