package net.avdw;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.Assets;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class ColorQuantization extends Sprite
{

	public function new()
	{
		super();
		var orig = Assets.getBitmapData("img/def611c3-b108-484f-85cc-38d208242101.jpg");
		var filter = orig.clone();
		quantize(filter);
		
		addChild(new Bitmap(orig));
		var bmp = new Bitmap(filter);
		bmp.x = 520;
		addChild(bmp);
	}

	function quantize(bmd:BitmapData):BitmapData
	{
		var palette:Array<Color> = MedianCut.cut(bmd, 3);

		for (y in 0...bmd.height)
		{
			for (x in 0...bmd.width)
			{
				bmd.setPixel(x, y, nearestNeighbour(palette, Color.fromValue(bmd.getPixel(x, y))));
			}
		}

		return bmd;
	}

	function meadianCut(bmd:BitmapData):Array<Color>
	{
		return [Color.fromRGB(0, 0, 0), Color.fromRGB(255, 255, 255)];
	}

	function nearestNeighbour(palette:Array<Color>, color:Color):UInt
	{
		var nearest:UInt = 0;
		var closest:UInt = 200000;
		for (c in palette)
		{
			var dist = Color.subtract(c, color);
			dist.r *= dist.r;
			dist.g *= dist.g;
			dist.b *= dist.b;

			var distSqr = dist.r + dist.g + dist.b;
			if (distSqr < closest)
			{
				closest = distSqr;
				nearest = c.value;
			}
		}

		return nearest;
	}

}