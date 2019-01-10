package;

import flixel.FlxGame;
import flixel.util.FlxSave;
import openfl.display.Sprite;
import flixel.FlxG;

class Main extends Sprite
{
	private var save : FlxSave;
	
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
		FlxG.mouse.visible = false;
		// Save
		save = new FlxSave();
		save.bind("musicVolume");
		if (save.data.volume != null)
			FlxG.sound.volume = save.data.volume;
		save.close();
		
		//FlxG.debugger.visible = true;
		//FlxG.debugger.drawDebug = true;
	}
}