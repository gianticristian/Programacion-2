package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
using flixel.util.FlxSpriteUtil;


class MenuState extends FlxState
{
	private var title : FlxText;
	private var version : FlxText;
	private var start : FlxText;
	private var credits : FlxText;
	
	
	private var pointer: FlxSprite; 
	private var menu : Array<FlxText>;
	private var selected : Int = 0;
	private var selectedSound : FlxSound;
	
	override public function create () : Void
	{
		super.create();
		camera.bgColor.setRGB(255,77,77);
		// Title
		title = new FlxText(0, 100, FlxG.width);
		title.text = "Titulo Principal";
		title.setFormat("assets/fonts/Minercraftory.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Start
		start = new FlxText();
		start.text = "Start";
		start.setFormat("assets/fonts/Minercraftory.ttf", 40, FlxColor.WHITE, FlxTextAlign.CENTER);
		start.setPosition(FlxG.width / 2 - start.width / 2, FlxG.height / 2);
		start.antialiasing = true;
		// Credits
		credits = new FlxText();
		credits.text = "Credits";
		credits.setFormat("assets/fonts/Minercraftory.ttf", 40, FlxColor.WHITE, FlxTextAlign.CENTER);
		credits.setPosition(FlxG.width / 2 - credits.width / 2, FlxG.height / 1.5);
		credits.alpha = 0.5;
		credits.antialiasing = true;
		// Menu
		menu = new Array<FlxText>();
		menu.push(start);
		menu.push(credits);
		add(menu[0]);
		add(menu[1]);
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(250, 70, FlxColor.TRANSPARENT, true);
		pointer.setPosition(FlxG.width / 2 - pointer.width / 2, menu[selected].y); 
		pointer.drawRect(5, 0, 240, 5, FlxColor.WHITE);
		pointer.drawRect(5, 65, 240, 5, FlxColor.WHITE);
		pointer.drawRect(0, 5, 5, 60, FlxColor.WHITE);
		pointer.drawRect(245, 5, 5, 60, FlxColor.WHITE);
		add(pointer);
		// Sound
		selectedSound = FlxG.sound.load("assets/sounds/Selected.wav");
		selectedSound.volume = 1;
	}

	override public function update (elapsed : Float) : Void
	{
		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			if (selected > 0)
			{
				menu[selected].alpha = 0.5;
				selected--;
				menu[selected].alpha = 1;
				pointer.y = menu[selected].y;
				selectedSound.play();
			}
		}
		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			if (selected < menu.length - 1)
			{
				menu[selected].alpha = 0.5;
				selected++;
				menu[selected].alpha = 1;
				pointer.y = menu[selected].y;
				selectedSound.play();
			}
		}
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.camera.fade(FlxColor.BLACK, 2.0, false, ChangeState);
		}
		
		super.update(elapsed);
	}
	
	private function ChangeState () : Void
	{
		switch (selected) 
		{
			case 0:
				FlxG.switchState(new PlayState());
			case 1:
				FlxG.switchState(new Credits());
			default:
				trace("State not found");
		}
	}	
}