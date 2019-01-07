package;

import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.FlxG;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
		FlxG.mouse.visible = false;
		//FlxG.debugger.visible = true;
		//FlxG.debugger.drawDebug = true;
	}
}