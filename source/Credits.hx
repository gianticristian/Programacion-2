package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

using flixel.util.FlxSpriteUtil;

class Credits extends FlxState 
{
	private var title : FlxText;
	private var name : FlxText;

	private var pointer: FlxSprite; 
	private var back : FlxText;
	private var menuSelected : FlxSound;
	
	override public function create () : Void
	{
		super.create();
		camera.bgColor.setRGB(0,153,255);
		// Title
		title = new FlxText(0, 70, FlxG.width);
		title.text = "Credits";
		title.setFormat("assets/fonts/Minercraftory.ttf", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Name
		name = new FlxText(0, 250, FlxG.width);
		name.text = "Cristian Gianti";
		name.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		name.antialiasing = true;
		add(name);
		// Back
		back = new FlxText();
		back.text = "Back";
		back.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		back.setPosition(FlxG.width / 2 - back.width / 2, FlxG.height / 2 + back.height * 3);
		back.antialiasing = true;
		add(back);
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(250, 50, FlxColor.TRANSPARENT, true);
		pointer.setPosition(FlxG.width / 2 - pointer.width / 2, back.y); 
		pointer.drawRect(5, 0, 240, 5, FlxColor.WHITE);
		pointer.drawRect(5, 45, 240, 5, FlxColor.WHITE);
		pointer.drawRect(0, 5, 5, 40, FlxColor.WHITE);
		pointer.drawRect(245, 5, 5, 40, FlxColor.WHITE);
		add(pointer);
		// Sound
		menuSelected = FlxG.sound.load("assets/sounds/MenuSelected.wav");
		menuSelected.volume = 1;
	}
	
	override public function update (elapsed : Float) : Void
	{
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.camera.fade(FlxColor.BLACK, 2.0, false, ChangeState);
			menuSelected.play();
		}
		super.update(elapsed);
	}
	
	private function ChangeState () : Void
	{
		FlxG.switchState(new MenuState());
	}	
	
}