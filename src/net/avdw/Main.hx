package net.avdw;

import openfl.errors.Error;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Main extends Sprite
{

	public function new()
	{
		super();

		try
		{
			//addChild(new FloydSteinbergDithering());
			//addChild(new MedianCut());
			//addChild(new ColorQuantization());
			addChild(new EnhancedFloydSteinbergDithering());
		}
		catch (e:Error)
		{
			trace(e);
		}
	}

}
