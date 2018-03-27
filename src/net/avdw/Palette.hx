package net.avdw;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Palette
{

	public function new()
	{

	}

	public static function c64():Array<Color>
	{
		var palette:Array<Color> = new Array();
		palette.push(Color.fromRGB(0, 0, 0));
		palette.push(Color.fromRGB(255, 255, 255));
		palette.push(Color.fromRGB(136, 0, 0));
		palette.push(Color.fromRGB(170, 255, 238));
		palette.push(Color.fromRGB(204, 68, 204));
		palette.push(Color.fromRGB(0, 204, 85));
		palette.push(Color.fromRGB(0, 0, 170));
		palette.push(Color.fromRGB(238, 238, 119));
		palette.push(Color.fromRGB(221, 136, 85));
		palette.push(Color.fromRGB(102, 68, 0));
		palette.push(Color.fromRGB(255, 119, 119));
		palette.push(Color.fromRGB(51, 51, 51));
		palette.push(Color.fromRGB(119, 119, 119));
		palette.push(Color.fromRGB(170, 255, 102));
		palette.push(Color.fromRGB(0, 136, 255));
		palette.push(Color.fromRGB(187, 187, 187));
		
		return palette;
	}
	
	public static function cga():Array<Color>
	{
		var palette:Array<Color> = new Array();
		palette.push(Color.fromRGB(0, 0, 0));
		palette.push(Color.fromRGB(85, 255, 255));
		palette.push(Color.fromRGB(255, 85, 255));
		palette.push(Color.fromRGB(255, 255, 255));
		
		return palette;
	}
}