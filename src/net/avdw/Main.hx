package net.avdw;

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
		//addChild(new FloydSteinbergDithering());
		//addChild(new MedianCut());
		addChild(new ColorQuantization());
	}

}
