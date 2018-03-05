package net.avdw;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Point;
import openfl.Assets;
import openfl.display.Sprite;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class FloydSteinbergDithering extends Sprite
{

	public function new()
	{
		super();

		var orig = Assets.getBitmapData("img/def611c3-b108-484f-85cc-38d208242101.jpg");
		var filter = orig.clone();
		var factor = 4;
		grayscale(filter);
		
		var histogram = filter.histogram();
		trace(histogram[0]); // alpha
		trace(histogram[1]); // red
		trace(histogram[2]); // green
		trace(histogram[3]); // blue

		var origBmp = new Bitmap(orig);
		var filterBmp = new Bitmap(filter);
		filterBmp.x = 520;
		addChild(origBmp);
		addChild(filterBmp);

		for (y in 0...filter.height-1)
		{
			for (x in 1...filter.width-1)
			{
				var origColor = Color.fromValue(filter.getPixel(x, y));
			
				var newR = Math.round(factor * origColor.r / 0xFF) * Math.round(0xFF / factor);
				var newG = Math.round(factor * origColor.g / 0xFF) * Math.round(0xFF / factor);
				var newB = Math.round(factor * origColor.b / 0xFF) * Math.round(0xFF / factor);
				
				var newColor = Color.fromRGB(newR, newG, newB);
				var errColor = Color.subtract(origColor, newColor);

				filter.setPixel(x, y, newColor.value);
				filter.setPixel(x + 1, y + 0, Color.add(Color.fromValue(filter.getPixel(x + 1, y + 0)), errColor.scaleSelf(7/16)).value);
				filter.setPixel(x - 1, y + 1, Color.add(Color.fromValue(filter.getPixel(x - 1, y + 1)), errColor.scaleSelf(3/16)).value);
				filter.setPixel(x + 0, y + 1, Color.add(Color.fromValue(filter.getPixel(x + 0, y + 1)), errColor.scaleSelf(5/16)).value);
				filter.setPixel(x + 1, y + 1, Color.add(Color.fromValue(filter.getPixel(x + 1, y + 1)), errColor.scaleSelf(1/16)).value);	
			}
		}
	}
	
	function grayscale(bmd:BitmapData):BitmapData
	{
		var rLum = 0.3086;
		var gLum = 0.6940;
		var bLum = 0.0820;

		var matrix:Array<Float> = [
			rLum, gLum, bLum, 0., 0.,
			rLum, gLum, bLum, 0., 0.,
			rLum, gLum, bLum, 0., 0.,
			0.,    0.,    0.,    1., 0.];

		var filter:ColorMatrixFilter = new ColorMatrixFilter( matrix );
		bmd.applyFilter( bmd, bmd.rect, new Point(0, 0), filter );

		return bmd;
	}

}