package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class Credits extends FlxState 
{
	private var title : FlxText;
	private var name : FlxText;

	override public function create () : Void
	{
		super.create();
		camera.bgColor.setRGB(0,153,255);
		// Title
		title = new FlxText(0, 100, FlxG.width);
		title.text = "Credits";
		title.setFormat("assets/fonts/Minercraftory.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Name
		name = new FlxText(0, 500, FlxG.width);
		name.text = "Cristian Gianti";
		name.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		name.antialiasing = true;
		add(name);
		
		
	}
	
	
}