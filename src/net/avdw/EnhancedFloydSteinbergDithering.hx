package net.avdw;
import openfl.errors.Error;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.Assets;


/**
 * ...
 * @author Andrew van der Westhuizen
 */
class EnhancedFloydSteinbergDithering extends Sprite
{

	public function new() 
	{
		super();
		var orig = Assets.getBitmapData("img/def611c3-b108-484f-85cc-38d208242101.jpg");
		var filter = orig.clone();
		quantizeAndDither(filter);
		
		addChild(new Bitmap(orig));
		var bmp = new Bitmap(filter);
		bmp.x = 520;
		addChild(bmp);
	}
	
	function quantizeAndDither(bmd:BitmapData):BitmapData
	{
		var palette:Array<Color> = MeanCut.cut(bmd, 3);
		//var palette:Array<Color> = Palette.cga();
		

		for (y in 0...bmd.height-1)
		{
			for (x in 1...bmd.width-1)
			{
				var origColor = Color.fromValue(bmd.getPixel(x, y));
				var newPixel = nearestNeighbour(palette, origColor);
				var errColor = Color.subtract(origColor, newPixel);

				bmd.setPixel(x, y, newPixel.value);
				bmd.setPixel(x + 1, y + 0, Color.add(Color.fromValue(bmd.getPixel(x + 1, y + 0)), Color.scale(errColor, 7 / 16)).value);
				bmd.setPixel(x - 1, y + 1, Color.add(Color.fromValue(bmd.getPixel(x - 1, y + 1)), Color.scale(errColor, 3 / 16)).value);
				bmd.setPixel(x + 0, y + 1, Color.add(Color.fromValue(bmd.getPixel(x + 0, y + 1)), Color.scale(errColor, 5 / 16)).value);
				bmd.setPixel(x + 1, y + 1, Color.add(Color.fromValue(bmd.getPixel(x + 1, y + 1)), Color.scale(errColor, 1 / 16)).value);
			}
		}

		return bmd;
	}

	function nearestNeighbour(palette:Array<Color>, color:Color):Color
	{
		var nearest:Color = Color.fromRGB(0, 0, 0);
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
				nearest = c;
			}
		}
		

		return nearest;
	}
	
}