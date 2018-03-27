package net.avdw;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.utils.Assets;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class MeanCut 
{

	public function new() 
	{
		
	}
	
	static public function cut(bmd:BitmapData, numCuts:Int):Array<Color>
	{
		var colors:Array<Color> = new Array();
		for (bucket in splitByMean(ColorBucket.createBucket(bmd), numCuts))
		{
			colors.push(ColorBucket.averageColor(bucket));
		}
		return colors;
	}
	
	static function splitByMean(bucket:Array<Color>, count:Int):Array<Array<Color>>
	{
		var largestRange = ColorBucket.largestRange(bucket);
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
}