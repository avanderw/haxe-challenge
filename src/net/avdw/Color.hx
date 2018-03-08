package net.avdw;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Color
{
	public var r:Int;
	public var g:Int;
	public var b:Int;
	public var value:UInt;

	function new()
	{
	}

	static public function fromValue(v:UInt):Color
	{
		var c:Color = new Color();
		c.r = v >> 16 & 0xFF;
		c.g = v >>  8 & 0xFF;
		c.b = v >>  0 & 0xFF;
		c.value = v;

		return c;
	}

	static public function fromRGB(r:UInt, g:UInt, b:UInt):Color
	{
		var c:Color = new Color();
		c.r = r;
		c.g = g;
		c.b = b;
		c.value = r << 16 | g << 8 | b << 0;

		return c;
	}
	
	static public function subtract(a:Color, b:Color):Color {
		var c:Color = new Color();
		c.r = a.r - b.r;
		c.g = a.g - b.g;
		c.b = a.b - b.b;
		c.value = c.r << 16 | c.g << 8 | c.b << 0;
		
		return c;
	}
	
	static public function add(a:Color, b:Color):Color {
		var c:Color = new Color();
		c.r = a.r + b.r;
		c.g = a.g + b.g;
		c.b = a.b + b.b;
		c.value = c.r << 16 | c.g << 8 | c.b << 0;
		
		return c;
	}
	
	public function scaleSelf(factor:Float):Color {
		r = Math.round(r * factor);
		g = Math.round(g * factor);
		b = Math.round(b * factor);
		value = r << 16 | g << 8 | b << 0;
		
		return this;
	}
	
	public function refreshValue():Void {
		value = r << 16 | g << 8 | b << 0;
	}

}